# My Vision

This is the specification for this project.

- It is a single document organized into phases.
- Each phase has its own success criteria (**Done when**), and the phases must be executed in order:
  Phase 1 (image spec) → Phase 2 (configuration & validation scripts) → Phase 3 (utility scripts) → Phase 4 (build & validate loop).
- Validation criteria (Phase 2) and teardown tooling (Phase 3) are defined
  _before_ the build loop so it has a concrete target and can purge failed attempts between iterations.

## Primary Goal

I want to create a Docker container where I can develop & test C++, Python, Rust, and CircuitPython projects.

## Version Policy

Install the latest available version of every tool, subject to these minimum floors.
Validation (Phase 2) must FAIL if an installed version is below its floor:

|    Tool    | Minimum version |
| :--------: | :-------------: |
|    nvim    |     0.12.4      |
|  LazyVim   |     16.0.0      |
|    git     |     2.43.0      |
| Nerd Fonts |       3.0       |

Note: Ubuntu 24.04's apt ships a stale nvim (0.9.x). Since snap is prohibited (see "Do Not Do This"),
install nvim from the official release tarball/AppImage or the `neovim-ppa/unstable` PPA.

LazyVim has no `--version` command. Check its floor by querying headless nvim
(e.g. `nvim --headless "+lua print(require('lazyvim').version)" +qa`) or by reading the
`LazyVim` entry in `~/.config/nvim/lazy-lock.json`.

Installed fonts carry no queryable release version (`fc-list` shows the font, not the Nerd Fonts release).
The Dockerfile must record the downloaded release tag to `/usr/local/share/fonts/.nerd-fonts-version`;
validation reads that file and compares against the floor.

## Install Sources

"Latest version" alone is ambiguous on Ubuntu 24.04 — apt is stale or missing for several
tools. Install every tool by the mechanism below (the Dockerfile does all installs):

| Mechanism                              | Tools                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `apt`                                  | gcc, clang, clangd, clang-format, clang-tidy, make, cmake, ninja-build, gdb, libgtest-dev, catch2, git, tmux, screen, xclip, wl-clipboard, ripgrep, fd-find, curl, npm, python3-pip, stow, tio, openssh-server, xauth, alacritty, gnome-terminal, shellcheck, shfmt, bat, eza, zoxide, btop, pyenv Python build deps (build-essential, libssl-dev, zlib1g-dev, libbz2-dev, libreadline-dev, libsqlite3-dev, libncursesw5-dev, xz-utils, tk-dev, libffi-dev, liblzma-dev)                                                            |
| GitHub release tarball/binary          | nvim, lazygit, gitui, fzf, Nerd Fonts (`ryanoasis/nerd-fonts` JetBrainsMono zip, latest release)                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `npm install -g`                       | tree-sitter-cli, prettier                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| Official installer script              | uv (from astral.sh), rustup (from rustup.rs, as user `jeff` — installs `rustc`, `cargo`, and components `rustfmt`, `clippy`, `rust-analyzer`; apt's rust is stale), pyenv (from pyenv.run, as user `jeff` — clones pyenv + plugins into `~/.pyenv`; PATH + `pyenv init` go in `~/.profile`)                                                                                                                                                                                                                                         |
| `uv tool install` (as user `jeff`)     | ruff, pytest, mypy, pyright, mkdocs (with mkdocs-material + mkdocstrings), circup                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `pip3 install --break-system-packages` | icecream, circuitpython-stubs, debugpy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `git clone`                            | LazyVim starter → `~/.config/nvim`, baked into the image home (drop its `.git`); lazy.nvim installs LazyVim + plugins on first `nvim --headless "+Lazy! sync"`. NOTE: `.dotfiles` `pkg-nvim` is NOT stowed — its active config is a custom setup, not LazyVim, and would break the LazyVim floor. Its `NVIM_APPNAME` variant subdirs (`active`, `beta`, `experimental`, `lazyvim`) ARE symlinked into `~/.config/nvim/` by `15-dotfiles.sh` so the `vi`/`vi-beta`/`vi-exp`/`vi-lv` aliases work; the top-level config stays LazyVim |

Notes: apt installs `bat` as `batcat` and `fd-find` as `fdfind` — symlink `bat` and `fd`
into `/usr/local/bin`. Ubuntu 24.04's apt git (2.43.0) meets its floor, so apt is fine.
The apt layer also installs runtime/support packages that are requirements, not tools:
g++, python3-venv, sudo, x11-apps (xclock), fontconfig, locales, dbus-x11,
libxkbcommon-x11-0 + the Mesa GL stack (alacritty over X11), iproute2, procps,
ca-certificates, unzip.

## Phase 1 — Image Specification (Dockerfile + docker-compose.yml)

Create a Dockerfile and docker-compose.yml that build a complete development & test environment for
C++, Python, Rust, and CircuitPython projects, using the latest version of their libraries & tools
(subject to the Version Policy above).

**All tools are installed by the Dockerfile.**
The bash scripts in Phase 2 only configure and validate — they install nothing.
There is no existing `Dockerfile` or `docker-compose.yml` —
create both from scratch in the repo root per this spec (ssh, X11 forwarding, user setup, tooling).

### Base System

- Base image `ubuntu:24.04`, configured as a server (no desktop environment installed)
- The image built from the Dockerfile is named `ubuntu-dev`
- docker-compose.yml sets `container_name: ubuntu-dev-test` — the container the build &
  validate loop (Phase 4) creates and the utility scripts (Phase 3) tear down
- Include any packages required so X Window applications running in the container appear on the host's desktop
- Create user account `jeff` with `sudo` privileges and password 'password';
  add `jeff` to the `dialout` group (serial access to CircuitPython boards)
- `jeff` must have UID 1000 to match the host user, so the `~/src` bind mount is writable
  (the `ubuntu:24.04` base image's default `ubuntu` user holds UID 1000 — remove it first)
- I will access the container via ssh at port '2222' on the host, as user 'jeff', password 'password'

### Python & CircuitPython Tooling

`uv` is the center of the Python workflow — it manages Python versions,
virtual environments, projects (`pyproject.toml`), and tool running. Install:

- `uv` — project management, Python version management, venvs
- `pyenv` — alternative Python version manager, installed alongside `uv` for projects
  that still use pyenv workflows (`uv` remains primary for new work); requires the
  Python-from-source build deps in the apt row of Install Sources
- `ruff` — code formatting AND linting/syntax checking
- `pytest` — code testing
- `pyright` AND `mypy` — static type checking (pyright drives the nvim LSP experience;
  mypy for CLI/CI-style checks; both must resolve CircuitPython stubs)
- `icecream` — print-style debugging
- `debugpy` — debug adapter, so nvim-dap can set/hit breakpoints in Python code
- `mkdocs` with `mkdocs-material` theme and `mkdocstrings` plugin — code documentation from docstrings
- Python standard `logging` (document a preferred config; nothing to install)

Install mechanism: CLI tools (`ruff`, `pytest`, `mypy`, `pyright`, `mkdocs`, `circup`) via
`uv tool install` as user `jeff` — they land in `~/.local/bin`, on PATH via Ubuntu's default
`~/.profile`. Importable libraries (`icecream`, `circuitpython-stubs`, `debugpy`) via
`pip3 install --break-system-packages` into the system python3.

CircuitPython (boards will be plugged into this host via USB):

- `circuitpython-stubs` — board API stubs for type checking & editor completion
- `circup` — install/update CircuitPython libraries on an attached board
- `tio` — serial console to the board's REPL

Make use of these sources to better understand my objectives for Python development/testing
(note: pyenv is installed as an alternative version manager,
but `uv` remains the primary tool for Python version management here):

- Python Virtual Environments: A Primer - <https://realpython.com/python-virtual-environments-a-primer/>
- Managing Multiple Python Versions With pyenv - <https://realpython.com/intro-to-pyenv/>
- Managing Python Projects With uv: An All-in-One Solution - <https://realpython.com/python-uv/>
- Python and TOML: New Best Friends - <https://realpython.com/python-toml/>
- How to Manage Python Projects With pyproject.toml - <https://realpython.com/python-pyproject-toml/>
- Debug Your Python Code Efficiently with IceCream Package - <https://medium.com/@danielwume/debug-your-python-code-efficiently-with-icecream-package-10-advanced-examples-to-replace-print-820fef801cb0>

### C++ Toolchain

- Compilers: `gcc` and `clang`
- Build: `make`, `cmake`, `ninja`
- Debug: `gdb`
- LSP: `clangd` — drives nvim's C/C++ completion & diagnostics
- Static analysis & formatting: `clang-format`, `clang-tidy`
- Testing: GoogleTest (`libgtest-dev`, includes GoogleMock) AND Catch2 (`catch2`) — each project picks

### Rust Toolchain

- `rustup` — toolchain manager, installed via the official rustup.rs script as user `jeff`
  (toolchain lands in `~/.cargo/bin`; ensure it is on the login PATH)
- `rustc` and `cargo` — compiler and build/package tool (stable toolchain)
- `rustfmt` — code formatting (rustup component)
- `clippy` — linting (rustup component)
- `rust-analyzer` — LSP, drives nvim's Rust completion & diagnostics (rustup component)

### Editor & Supporting Tools

- C compiler (`gcc`/`clang`) + `tree-sitter-cli` — for `nvim-treesitter` parsers
- `nvim` and `lazyvim` (version floors in Version Policy)
- `git`, `gitui`, `lazygit` (`lazygit` is a `git` terminal UI bound to Neovim's `<leader>gg`)
- Latest versions of: `tmux`, `screen`, `xclip`, `wl-clipboard`, `ripgrep`, `fzf`, `curl`, `fd`, `npm`, `pip`
  (`xclip` serves the X11 host via `ssh -X`; `wl-clipboard` is future-proofing for Wayland)
- `shellcheck`, `shfmt` — bash linting & formatting (this project's own scripts, plus nvim shell support)
- `prettier` — Markdown/YAML/JSON/JS/TS/CSS formatting; general-purpose tool, and used to
  self-check this project's own docs/config files (see Key Objectives of Validation)
- Quality-of-life CLI: `bat`, `eza`, `zoxide`, `btop`
- `alacritty` AND `gnome-terminal` — GUI terminal emulators in the container, used to launch
  a terminal on the host desktop via X11 forwarding (gnome-terminal needs `dbus-x11` at runtime)
- Nerd Fonts v3+ `JetBrainsMonoNL Nerd Font Mono` — installed in the container for `alacritty`

### Host Requirements (NOT part of the image)

Terminal emulators run on the host — you ssh in from one. When ssh'd in, nvim's Nerd Font
glyphs and true color are rendered by the HOST terminal. The host therefore needs:

- A true-color terminal (e.g. kitty, wezterm, alacritty, ghostty) with
  `JetBrainsMonoNL Nerd Font Mono` installed on the host
- X11 forwarding enabled for container GUI apps: `xhost +local:docker`
- `sshpass` — lets the Phase 4 build & validate loop run the validation scripts over
  real ssh unattended

### Persistence & Hardware Access (docker-compose.yml)

- Named volume `ubuntu-dev-home` mounted at `/opt/dev_containers` — persistent workspace,
  survives container rebuilds
- Named volume `ubuntu-dev-jeff` mounted at `/home/jeff` — nvim plugins, uv caches, and shell
  history survive container recreation
- Bind-mount host `~/src/projects` at `/home/jeff/src` — project files visible & editable from host and container
- Caveat: the `/home/jeff` volume is populated from the image on FIRST run only; after that,
  files baked into `/home/jeff` by a rebuilt image are shadowed by the existing volume.
  To pick up home-directory changes from a rebuilt image, remove the volume
  (`docker volume rm ubuntu-dev-jeff`) or apply the change via the Phase 2 scripts
- USB passthrough for CircuitPython boards, so `circup` and `tio` work from inside the container.
  Boards vary and change, so passthrough is flexible — no single hardcoded device:
  `device_cgroup_rules` allow the serial device classes (`c 166:*` = ttyACM, `c 188:*` = ttyUSB)
  and `/dev` is bind-mounted so hot-plugged device nodes are visible in the container.
  A narrower per-device `devices:` alternative is documented (commented) in docker-compose.yml

**Done when:** `Dockerfile` and `docker-compose.yml` exist in the repo root,
`docker compose build` completes without error, and `docker compose up -d` leaves the
`ubuntu-dev-test` container running with ssh answering on host port 2222
(full validation happens in Phase 4).

## Phase 2 — Configuration & Validation Scripts

Build Bash scripts that configure and validate the development/testing environment inside the
running container. One script per tool area; each script does configuration and validation ONLY —
installation happens in the Phase 1 Dockerfile.

- All scripts live in the `scripts/` directory. The existing `scripts/NN-*.sh`, `common.sh`,
  and `run-all.sh` are prior drafts of exactly this approach — review and extend them,
  don't start over
- Scripts are named `NN-<area>.sh` and share their helpers (colors, step/skip/banner
  functions) from `common.sh`
- `run-all.sh` runs every `NN-*.sh` in numeric order, halts at the first script that fails,
  and prints a final pass/fail/skip summary
- Scripts reach the container through the bind-mounted `~/src` directory — no scp needed

**User environment files (dotfiles)** — handled by the `15-dotfiles.sh` script:

- My user environment files: <https://github.com/jeffskinnerbox/.dotfiles>
- Clone to `~/.dotfiles`; an existing clone is left alone
- Stow with GNU `stow` (installed by the Dockerfile) — exactly these packages:
  `pkg-bash`, `pkg-tmux`, `pkg-screen` → `$HOME`; `pkg-alacritty` → `~/.config`.
  Do NOT stow `pkg-nvim` — its active config is a custom (non-LazyVim) setup that
  would replace LazyVim and break the Version Policy floor. Instead, symlink its
  `NVIM_APPNAME` variant subdirs (`active`, `beta`, `experimental`, `lazyvim`) into
  `~/.config/nvim/` — this powers the `vi`/`vi-beta`/`vi-exp`/`vi-lv` aliases from
  `pkg-bash` without touching the top-level LazyVim starter config. Do NOT stow the other
  `pkg-*` packages — they are desktop/host-specific (i3, conky, cura, conda, wezterm, …)
- No logout/login step is needed: validation runs in a fresh ssh login shell (see Phase 4),
  so the stowed files are in effect for every check that follows

**Key Features of Scripts**

- Provide colored visual display of progress and success or failure at each configuration and validation step.
- Progress feedback at each step and error handling that halts on failures and explanation of the failure.
- When the script terminates (with or without error), summarize the configuration and validation performed.
- Every script answers `-h` with a usage synopsis, description, options, and an example;
  unexpected options or arguments → exit 2 + usage. Exit codes: 0 = all checks pass,
  1 = a check failed (halted there), 2 = bad usage.

**SKIP semantics** — checks that need a human eye or hardware (GUI apps appearing on the
host desktop, an attached CircuitPython board) are marked SKIP when `DISPLAY` is unset or
no board is present — never silently passed. `run-all.sh` ends with a short manual-check
checklist covering everything skipped. The Phase 4 loop passes on automated checks alone.

**Key Objectives of Validation** — functional smoke tests, not just `--version` checks:

- ssh login as `jeff` at host port 2222 succeeds; `sudo` works
- `xclock` appears on the host desktop; `alacritty` AND `gnome-terminal` launch on the
  host desktop via X11
- C++: hello-world compiles & runs with BOTH gcc and clang; a cmake+ninja build succeeds;
  a GoogleTest sample test AND a Catch2 sample test pass; gdb can set and hit a breakpoint on `main`;
  `clangd` responds (nvim's C/C++ LSP)
- Python: `uv init` a sample project; `uv run pytest` passes; `ruff format` and `ruff check`
  run clean; `pyright` and `mypy` both run clean on the sample; `icecream` imports and prints;
  `python3 -c "import debugpy"` succeeds; `pyenv --version` responds on the login PATH and
  `pyenv install --list` shows installable versions (no `pyenv install` at validation time —
  scripts must not install)
- Rust: `cargo new` a sample project; `cargo build` and `cargo run` succeed; `cargo test`
  passes; `cargo fmt --check` and `cargo clippy` run clean; `rust-analyzer --version` responds
- CircuitPython: `pyright` and `mypy` resolve `circuitpython-stubs` in a sample `code.py`;
  with a board attached, the serial device is visible in the container and `tio --list`
  shows it; `circup` drive detection requires the CIRCUITPY drive mounted inside the
  container (host desktop mounts are NOT visible — only `/dev` is bind-mounted) and is
  marked SKIP otherwise
- nvim: version ≥ floor; `nvim --headless "+Lazy! sync" +qa` completes with zero errors;
  a treesitter parser compiles (proving gcc + tree-sitter-cli work together)
- Nerd Fonts: `fc-list` finds `JetBrainsMonoNL Nerd Font Mono`;
  `/usr/local/share/fonts/.nerd-fonts-version` reads ≥ 3.0
- `git`, `gitui`, `lazygit`, `tmux`, `ripgrep`, `fzf`, `fd`, `curl`, `npm`, `bat`, `eza`,
  `zoxide`, `btop` each respond; version ≥ floor where the Version Policy sets one;
  `screen` starts a detached session
- `shellcheck` and `shfmt -d` pass on this project's own `scripts/*.sh`
- `prettier --check` passes on this project's own docs/config: `README.md`, `CLAUDE.md`,
  `input/my-vision.md`, `docker-compose.yml` (`docs/*.md` is excluded — those are
  symlinks into an external blogging repo, and prettier refuses to touch symlinks)

**Done when:** every script exists, and `run-all.sh` completes inside the container with
zero failures (SKIPs allowed) — exercised for real by the Phase 4 loop.

## Phase 3 — Utility Scripts

Two host-side helper scripts in the `scripts/` directory for tearing down what the
Phase 4 build & validate loop creates between iterations (and before any clean rebuild).
Both take exactly one command-line argument — the name of the image/container — plus one
option. Parse arguments with `getopts` using the `-:` long-option idiom (or an equivalent
`while`/`case` loop) so both `-c` and `--confirm` work:

- `purge-container.sh [-c|--confirm] <container-name>` — stops the container if it
  is running, then removes it. Named volumes are NOT removed (deliberate — they hold
  the persistent home/workspace; remove manually with `docker volume rm` if wanted).
- `purge-image.sh [-c|--confirm] <image-name>` — removes the image. REFUSES to act
  if any container (running or stopped) still uses the image, and lists those
  containers with the instruction to purge them first.

**Common behavior**

- Print what will be purged before acting (container: name, image, status;
  image: name, id, size), then ask for confirmation `Proceed? (Yes/No)` —
  only `y`/`yes` (case-insensitive) proceeds
- `-c` / `--confirm` skips the confirmation prompt (for scripted use)
- Clear colored feedback; meaningful exit codes: 0 = removed or user aborted,
  1 = error (not found, in use, docker failure), 2 = bad usage
- Full reset of this project: `./purge-container.sh ubuntu-dev-test`, then
  `./purge-image.sh ubuntu-dev`, optionally followed by
  `docker volume rm dev_env_ubuntu-dev-jeff dev_env_ubuntu-dev-home`

**Done when:** each behavior is demonstrated: missing or extra arguments → exit 2 + usage;
nonexistent container/image → exit 1 with clear message; image still in use → refusal that
lists the offending containers; prompt answered `n` → exit 0, nothing removed;
`-c`/`--confirm` skips the prompt and removes.

## Phase 4 — Build & Validate Loop

Iterate until the environment validates clean:

1. Purge any previous attempt with the Phase 3 scripts:
   `./purge-container.sh -c ubuntu-dev-test`, then `./purge-image.sh -c ubuntu-dev`
2. Build & start: `docker compose up -d --build` — image `ubuntu-dev`, container `ubuntu-dev-test`
3. Validate over the real login path, run from the host:

   ```bash
   sshpass -p password ssh -X -p 2222 \
     -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
     jeff@localhost 'bash ~/src/docker_containers/dev_env/scripts/run-all.sh'
   ```

   (a fresh ssh login shell — dotfiles, `~/.profile` PATH, and X11 forwarding are all
   exercised exactly as in daily use)

4. On any build error or validation failure: correct the Dockerfile / docker-compose.yml /
   scripts, then return to step 1

**Done when:** every automated Phase 2 check passes (SKIPs allowed) and the run ends with
the manual-check checklist for anything skipped.

## Do Not Do This

- Do not use Ubuntu's `snap` packages when installing tools since they may not operate properly within a Docker container.

---

## Setup Instructions

### Purge Existing Image/Container

```bash
# on the host, from the scripts/ directory (add -c to skip the confirmation prompt)
./purge-container.sh ubuntu-dev-test
./purge-image.sh ubuntu-dev

# optional — also wipe the persistent volumes for a truly clean start
docker volume rm dev_env_ubuntu-dev-jeff dev_env_ubuntu-dev-home
```

### Create New Container

1. Build a new image and start container:

```bash
# In the directory with Dockerfile and docker-compose.yml
# (docker compose v2 — no hyphen; compose file needs no obsolete 'version:' key)
docker compose up -d --build
```

2. Enable X11 forwarding on host:

```bash
# Allow X11 connections (run on your host)
xhost +local:docker
```

3. SSH into container:

```bash
# the password is: password
ssh -X jeff@localhost -p 2222
```

4. Run configuration & validation scripts
   (inside container — scripts arrive via the bind-mounted `~/src`, no scp needed):

```bash
# host ~/src/projects is mounted at ~/src inside the container
cd ~/src/docker_containers/dev_env/scripts
chmod +x *.sh

# run each per-tool config/validation script in sequence
./run-all.sh
```

---
