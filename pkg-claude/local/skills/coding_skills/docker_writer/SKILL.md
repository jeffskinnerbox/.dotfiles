---
name: docker-writer
description: Write, review, or fix Dockerfile and docker-compose.yml files that build small, reproducible, secure images and define production-ready service stacks. Use this whenever the user asks for a Dockerfile, compose file, docker-compose.yml, "containerize this app", a docker image build, a multi-stage build, or wants an existing Dockerfile/compose file audited or hardened for image size, build cache, security (non-root, secrets), healthchecks, or service dependencies -- even if they don't say "Docker" explicitly (e.g. "package this service so it runs anywhere", "add a database to my dev stack"). Also use for questions about ENTRYPOINT vs CMD, COPY vs ADD, depends_on, profiles, or compose healthchecks.
---

# Docker Writer

## Why this skill exists

Dockerfiles and compose files that are dashed off quickly fail in the same places: images
are bloated and unreproducible (no multi-stage split, unpinned bases, cache-busting
instruction order), containers run as root with secrets baked into env vars, services
race each other at startup because `depends_on` only waits for *started* not *ready*,
and six months later nobody can tell why any line is there because nothing is commented.
This skill makes small/reproducible/secure/observable — and **well-commented** — the
default rather than something to remember each time.

The rules and their sources live in `references/docker-guidelines.md`. Read that file when
you need to justify a choice or the user asks why a pattern is used.

## When to generate vs. when to review

- **Generating a new file**: start from the matching template in `assets/`
  (`template.Dockerfile`, `template.docker-compose.yml`), adapt it to the actual app, and
  delete anything the project doesn't need (an unused build stage, the db service, a
  profile). Don't leave placeholder comments like `<your-app>` in the delivered file.
- **Reviewing/fixing an existing file**: read it fully, then walk the checklist below,
  fixing what doesn't hold up. Don't rewrite a working file just to match the template's
  exact shape — the checklist states the *properties* that matter.

Either way: **every logical block in a delivered Dockerfile or compose file gets a comment
saying what it does and — when non-obvious — why it's done that way** (e.g. why apt-get
update and install share one RUN, why COPY of the lockfile precedes COPY of the source).
Comment the *reasoning*, not a restatement of the syntax.

## Pillar 1: Small, reproducible images

- **Multi-stage builds**: separate build tooling from the runtime image; the final stage
  copies only artifacts (`COPY --from=build`). Name stages (`FROM ... AS build`).
- **Minimal, pinned base images**: prefer official/verified minimal images (`-slim`,
  `alpine`) and pin a specific version tag — never bare `latest`. For supply-chain
  integrity, pin the digest too (`FROM python:3.12-slim@sha256:...`) when the project
  wants reproducible rebuilds.
- **Cache-friendly instruction order**: things that change rarely (base, system packages)
  come first; dependency manifests (`requirements.txt`, `package.json`, `Cargo.toml`)
  are COPYed and installed *before* the app source, so editing code doesn't re-install
  dependencies.
- **apt/apk hygiene**: `apt-get update && apt-get install -y --no-install-recommends ...`
  in ONE `RUN` (a separate update layer goes stale), then clean lists
  (`rm -rf /var/lib/apt/lists/*`) in the same layer. Sort multi-line package lists
  alphabetically, one per line with `\`.
- **`.dockerignore`**: always ship one alongside a Dockerfile (`.git`, caches, secrets,
  local env files) — it shrinks the build context and keeps secrets out of layers.
- **COPY, not ADD** unless you specifically need tar auto-extraction; use
  `ADD --checksum` for remote files if truly needed.
- **Pipes**: prepend `set -o pipefail &&` (under `SHELL ["/bin/bash", "-c"]` or an
  explicit `bash -c`) to any RUN using a pipe so mid-pipe failures fail the build.

## Pillar 2: Secure and operable at runtime

- **Non-root**: create a dedicated user with explicit UID/GID and switch with `USER`
  before the final CMD; only stay root when the container genuinely needs it (and say
  why in a comment).
- **ENTRYPOINT + CMD split**: `ENTRYPOINT` (exec form) is the executable, `CMD` its
  default arguments — so `docker run image --other-flag` works naturally.
- **`HEALTHCHECK`** in the image (or `healthcheck:` in compose) for any long-running
  service — orchestrators and `depends_on: condition: service_healthy` need it.
- **`EXPOSE`** the listening port (documentation for humans and tooling).
- **No secrets in ENV or layers**: use build secrets (`RUN --mount=type=secret`) at build
  time and compose `secrets:`/`*_FILE` env conventions at runtime. Never COPY a
  credential file into an image.
- **`LABEL`** metadata (maintainer, source, description) using OCI keys
  (`org.opencontainers.image.*`).

## Pillar 3: Production-ready compose files

- **No top-level `version:` key** — it's obsolete in the Compose Specification and
  produces a warning.
- **Readiness, not just startup**: give every service a `healthcheck:` and make
  dependents use `depends_on: <svc>: condition: service_healthy` (or
  `service_completed_successfully` for one-shot jobs). A `service_healthy` condition
  pointing at a service *without* a healthcheck waits forever — never do that.
- **Named volumes** for persistent data (declared under top-level `volumes:`); bind
  mounts only for source code in dev.
- **Resource limits**: every service gets `deploy.resources.limits` (ceiling) and
  `reservations` (guaranteed minimum) so one leaking service can't starve the host
  (honored by `docker compose up` since v2.17).
- **`profiles:`** for optional services (debug tools, admin UIs, monitoring) instead of
  maintaining parallel compose files; services without a profile always run.
- **`restart:`** policy (`unless-stopped` for services, `no` for one-shot jobs).
- **Secrets** via the top-level `secrets:` block + `*_FILE` env vars, not plaintext
  `environment:` values; `.env`/`env_file:` for non-secret config, and never commit
  `.env` (belongs in `.gitignore` and `.dockerignore`).
- **DRY with YAML anchors / `x-` extension fields** when several services share
  logging/env boilerplate — but only when there's real repetition.

## Before handing back

- [ ] Every logical block is commented — the why, not a restatement of syntax.
- [ ] Dockerfile: multi-stage (or a comment saying why single-stage suffices), pinned
      base tag, deps-before-source COPY order, single-RUN apt with cleanup, non-root
      USER, exec-form ENTRYPOINT/CMD, EXPOSE, HEALTHCHECK for long-running services.
- [ ] A `.dockerignore` accompanies any new Dockerfile.
- [ ] Compose: no `version:` key, healthchecks + condition-based `depends_on`, named
      volumes, resource limits, restart policies, secrets not plaintext.
- [ ] Validate: `docker build --check .` (buildx lint, no image built) for Dockerfiles;
      `docker compose config -q` for compose files; run `hadolint` if installed — if a
      validator isn't available, say so rather than silently skipping. Don't install
      new tooling without asking first.
- [ ] If the repo has its own container conventions (a spec file, a CLAUDE.md rule like
      "no snap" or "--no-install-recommends"), those override this skill's defaults —
      follow and preserve them.

## Templates

- `assets/template.Dockerfile` — commented multi-stage build (Python example; the
  structure transfers to any language: builder stage, runtime stage, non-root, healthcheck).
- `assets/template.dockerignore` — starter ignore file to copy alongside it.
- `assets/template.docker-compose.yml` — commented two-service stack: app + postgres,
  healthchecks, condition-based depends_on, named volume, secrets, limits, a `debug`
  profile service.

Adapt, then delete what the project doesn't use — don't deliver dead example services.

## Reference

- `references/docker-guidelines.md` — the full rule list with rationale and source links
  (Docker official docs and current best-practice articles). Consult it for "why" questions
  or when a rule here seems to conflict with project reality.
