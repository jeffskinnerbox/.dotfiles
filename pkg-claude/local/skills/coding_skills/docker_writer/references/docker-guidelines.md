# Docker Guidelines — rules, rationale, sources

Collected July 2026 from Docker's official documentation and current best-practice
articles. This is the "why" behind SKILL.md's checklist; cite these when the user asks.

## Dockerfile

### Multi-stage builds
Split instructions into stages so the final image contains only what the app needs to
run. Build tooling (compilers, headers, package managers' caches) stays in earlier
stages; the last stage COPYs artifacts with `COPY --from=<stage>`. Stages can build in
parallel, and named stages (`FROM x AS build`) can be reused (`--target`).

### Base images
- Prefer official images, verified publishers, and Docker-sponsored open source.
- Prefer minimal variants (`-slim`, `alpine`) — fewer packages means fewer CVEs and
  faster pulls.
- Pin a version tag always; pin the digest (`image:tag@sha256:...`) when supply-chain
  reproducibility matters. Never bare `latest`.
- Rebuild regularly with `--pull` (and `--no-cache` for a fully fresh build) to pick up
  base-image security updates.

### Build cache and instruction order
Layers invalidate top-down: order instructions from least- to most-frequently changing.
The canonical payoff: COPY the dependency manifest and install dependencies *before*
COPYing the application source, so code edits don't re-run dependency installation.
`RUN --mount=type=cache` keeps package-manager caches out of layers but warm across
builds.

### apt-get / package installs
- `apt-get update && apt-get install -y --no-install-recommends <pkgs> && rm -rf
  /var/lib/apt/lists/*` — all in ONE `RUN`. A standalone `update` layer gets cached and
  goes stale ("cache busting" problem); cleanup in a later layer doesn't shrink anything.
- Sort multi-line package lists alphanumerically; one package per line with `\`.
- Don't install packages "just in case" — every extra package is size + attack surface.
- Pin package versions where unexpected upgrades would hurt.

### Shell and pipes
Prepend `set -o pipefail &&` to RUN commands that pipe, so a failure in any pipe stage
fails the build (default shell only checks the last command). Requires bash — use
`SHELL ["/bin/bash", "-o", "pipefail", "-c"]` or wrap in `bash -c`.

### Users and privileges
- `USER` a dedicated non-root account before the final CMD whenever the service can run
  unprivileged. Create it with explicit UID/GID for stable file ownership;
  `useradd --no-log-init` avoids sparse-file issues with large UIDs.
- No sudo inside containers; if you must step down from root at runtime, use gosu/tini
  patterns.

### Instruction specifics
- **COPY vs ADD**: COPY for files from context or stages. ADD only for its special
  powers (remote URL with `--checksum`, tar auto-extract) — otherwise it's a foot-gun.
- **ENTRYPOINT vs CMD**: exec-form ENTRYPOINT is the image's fixed command; CMD supplies
  overridable default flags. Exec form (JSON array) lets signals reach PID 1 — shell
  form wraps in `/bin/sh -c` and breaks graceful shutdown.
- **WORKDIR**: absolute paths; never `RUN cd ... && ...` chains.
- **ENV**: fine for paths/config/versions; combine with the RUN that uses it if the var
  shouldn't persist. Never for secrets — they're visible in `docker inspect` and to
  every child process.
- **EXPOSE**: declare the conventional listening port; it documents intent (it does not
  publish).
- **LABEL**: OCI keys (`org.opencontainers.image.title/description/source/...`) so
  registries and scanners can read them.
- **HEALTHCHECK**: define one for long-running services; `--start-period` covers boot
  time. Compose/orchestrator readiness gating depends on it.
- **Heredocs** (`RUN <<EOF ... EOF`) are cleaner than `&&`-chains for complex steps
  (needs the `# syntax=docker/dockerfile:1` directive).

### Secrets at build time
`RUN --mount=type=secret,id=...` exposes a secret only for that command, in tmpfs, never
in a layer. Never COPY credentials or pass them as ARG (ARGs are recorded in image
history).

### .dockerignore
Ship one with every Dockerfile: `.git`, dependency/build caches, `.env` and other
secrets, editor noise. Smaller context = faster builds; excluded secrets can't leak into
layers by accident.

### Validation
- `docker build --check .` runs BuildKit's built-in lint rules without building.
- `hadolint Dockerfile` for a stricter external linter.

## docker-compose.yml

### Spec-level
- The top-level `version:` key is obsolete (Compose Specification); omit it.
- `name:` sets the project name explicitly instead of inheriting the directory name.

### Startup ordering that actually works
`depends_on` alone waits only for the container to *start*. Use the long form with
conditions:
- `condition: service_healthy` — dependency's healthcheck must pass first.
- `condition: service_completed_successfully` — for one-shot init/migration jobs.
A `service_healthy` condition pointing at a service with **no** healthcheck blocks
forever — always pair them. Healthcheck fields: `test`, `interval`, `timeout`,
`retries`, `start_period`.

### Resource limits
Without limits, one leaking service can starve the whole host. Give every service
`deploy.resources.limits` (ceiling) and `.reservations` (guaranteed minimum) — honored
by `docker compose up` since Compose v2.17.

### Profiles
`profiles:` gates optional services (debug UIs, monitoring, one-off tools) behind
`--profile <name>`, replacing parallel compose-file variants. Services without a profile
always run.

### Data
Named volumes (top-level `volumes:`) for anything that must survive container
replacement; bind mounts only for dev-time source code. Named volumes survive
`docker compose down` (only `down -v` removes them).

### Secrets and config
- Top-level `secrets:` + per-service `secrets:` mounts files at `/run/secrets/<name>`;
  pair with images' `*_FILE` env conventions (postgres, mysql, etc. support this).
- Compose file-based secrets are fine for dev/staging; production wants an external
  manager (Vault, cloud secret stores).
- `.env` / `env_file:` for non-secret config; keep `.env` in `.gitignore` and
  `.dockerignore`.

### Misc
- `restart: unless-stopped` for services; `restart: "no"` for one-shot/debug containers.
- YAML anchors or `x-` extension fields de-duplicate shared blocks (logging, common env)
  when repetition is real.
- Validate with `docker compose config -q` (parses, resolves, and schema-checks).

## Sources

- Docker docs — Building best practices: <https://docs.docker.com/build/building/best-practices/>
- Docker docs — Compose services reference: <https://docs.docker.com/reference/compose-file/services/>
- Docker Compose in 2026: best practices that actually matter: <https://www.gaultonlab.org/posts/docker-compose-best-practices/>
- Docker Compose v2 tutorial (profiles, health checks, secrets): <https://tutorials.technology/tutorials/docker-compose-v2-tutorial-2026.html>
- Docker Compose healthchecks (Last9): <https://last9.io/blog/docker-compose-health-checks/>
- Compose for production workloads (freeCodeCamp): <https://www.freecodecamp.org/news/how-to-use-docker-compose-for-production-workloads/>
