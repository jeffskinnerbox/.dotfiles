# syntax=docker/dockerfile:1
# The syntax directive opts into the current Dockerfile frontend (BuildKit
# features: heredocs, --mount, build checks). Keep it as line 1.
#
# template.Dockerfile — multi-stage build for a Python web app.
# The STRUCTURE is the point; swap the toolchain for node/go/rust/c++ as needed:
#   stage "build":   compilers, headers, dependency install — everything heavy
#   stage "runtime": minimal base + the built artifacts + a non-root user
#
# Build:  docker build -t myapp .
# Lint:   docker build --check .      (validates without building)

# ---------------------------------------------------------------------------
# Build stage — allowed to be fat; nothing here ships to production.
# ---------------------------------------------------------------------------
# Pin a specific version tag, never 'latest' — rebuilds must be reproducible.
# For supply-chain pinning, append the digest: python:3.12-slim@sha256:...
FROM python:3.12-slim AS build

# System build deps in ONE RUN: 'apt-get update' cached alone goes stale and
# later installs then fetch old package indexes. --no-install-recommends keeps
# out weak dependencies; rm of the lists must be in the SAME layer to shrink it.
# Package list sorted alphabetically, one per line, for reviewable diffs.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Always an absolute WORKDIR — never 'cd' inside RUN commands.
WORKDIR /app

# Dependency manifest is COPYed *before* the source so editing app code does
# not invalidate the (slow) dependency-install layer in the build cache.
COPY requirements.txt .

# --mount=type=cache persists pip's download cache across builds without
# baking it into any layer.
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --prefix=/install -r requirements.txt

# Source last — it changes most often, so it invalidates the least.
COPY src/ ./src/

# ---------------------------------------------------------------------------
# Runtime stage — minimal surface: no compilers, no package caches, non-root.
# ---------------------------------------------------------------------------
FROM python:3.12-slim AS runtime

# OCI standard labels — tooling (registries, scanners) reads these keys.
LABEL org.opencontainers.image.title="myapp" \
      org.opencontainers.image.description="Example service built from template.Dockerfile" \
      org.opencontainers.image.source="https://github.com/example/myapp"

# curl only because HEALTHCHECK below uses it; drop if you health-check
# another way. Same single-RUN + cleanup pattern as the build stage.
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Dedicated non-root user with explicit UID/GID (stable file ownership across
# hosts); --no-log-init avoids sparse-file issues with high UIDs.
RUN groupadd --gid 10001 app \
    && useradd --uid 10001 --gid app --no-log-init --create-home app

WORKDIR /app

# Only the built artifacts cross the stage boundary — build tools stay behind.
COPY --from=build /install /usr/local
COPY --from=build --chown=app:app /app/src ./src

# Config via ENV is fine; secrets are NOT — pass secrets at runtime
# (compose 'secrets:', or RUN --mount=type=secret at build time).
ENV PYTHONUNBUFFERED=1 \
    PORT=8000

# Documentation for humans and tooling; does not publish the port by itself.
EXPOSE 8000

# Drop privileges before the process starts. Everything after this line runs
# as 'app', so debugging installs would need a root build stage instead.
USER app

# Lets 'docker ps' show health and lets compose 'service_healthy' gates work.
# start-period covers slow app startup before failures count.
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD curl -fsS "http://localhost:${PORT}/health" || exit 1

# ENTRYPOINT (exec form — no shell, signals reach the process) is the fixed
# executable; CMD holds default args users can override:
#   docker run myapp --workers 4
ENTRYPOINT ["python", "-m", "src.main"]
CMD ["--port", "8000"]
