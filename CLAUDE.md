# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles managed with GNU Stow. No build system or test suite. Content is shell/Lua/TOML/JSON config, Markdown docs, and Claude Code skills.

## Layout & Stow Conventions

- Each `pkg-<name>/` dir is a Stow package (bash, nvim, tmux, git, claude, alacritty, i3, X, etc.). Stow symlinks its contents into `$HOME` (or a chosen target), e.g. `stow --dir=~/.dotfiles --target=$HOME pkg-bash`.
- The Stow target varies by package. `pkg-bash` etc. target `$HOME`; `pkg-alacritty`, `pkg-ghostty`, `pkg-nvim`, `pkg-yamllint` target `$HOME/.config` and become directory symlinks (e.g. `~/.config/ghostty -> ../.dotfiles/pkg-ghostty/ghostty`). Stow with `--target=$HOME/.config pkg-ghostty`, and dry-run first with `stow -n -v`.
- `.bash_aliases` and `.bashrc` live in `pkg-bash/` and are symlinked into `$HOME`.
- Backups: `*.bak*` is gitignored. Per the user's global rule, make a `<file>.bak` copy before editing a file.
- Commit messages are short, lowercase, often prefixed with the area (e.g. `nvim active: ...`).
- Each package has a `.stow-local-ignore` that excludes `bin`, `src`, `docs`, `files`, README/LICENSE, `.git*`. Those dirs are repo-only helpers/docs and are **not** symlinked.
- Edits to files under `pkg-*` are live: `~/.config/nvim` is a symlink to `pkg-nvim/nvim`, so changes take effect immediately.
- `pkg-vim/.vim/bundle/*` are git submodules (see `.gitmodules`).
- Root `README.md` is a personal scratchpad ("NOTES TO SELF", macOS install steps), not a project overview. `docs/` holds setup/how-to notes (Stow, fresh Ubuntu install).

## Checker Files

`checker-files/` is the single source of truth for lint/format rules (markdownlint-cli2, yamllint, luacheck, prettier). Repo-root `.markdownlint-cli2.jsonc`, `.yamllint.yaml` and `pkg-nvim/nvim/.markdownlint-cli2.jsonc` are **symlinks** into it. Edit the file in `checker-files/`, never break the links.

- `.markdownlint-cli2.jsonc` is the only markdownlint config. It wins over any `.markdownlint.yaml` in the same dir (the yaml was removed). It sets `"fix": true`, so linting **rewrites files in place**. Ignores `.claude/**` and `.specify/**` (vendored).
- Lint a markdown file: `~/.local/share/nvim/active/mason/bin/markdownlint-cli2 <file>` (mason-installed, not on PATH). Config is the nearest one walking up from the file.
- prettier (`.prettierrc`): width 100, 2-space, no trailing commas, `quoteProps: preserve` for JSON. Sole json/jsonc formatter in nvim.

## Terminals & Launchers (`pkg-alacritty/`, `pkg-ghostty/`)

- Ghostty is the primary terminal (apt package `ghostty`); Alacritty is kept as fallback. `pkg-ghostty/ghostty/config` is a port of the active `alacritty.toml` (general use only). Validate with `ghostty +validate-config`.
- Only `pkg-alacritty/alacritty/alacritty.toml` is active. The other `.toml` files there are imported only by `alacritty-ros.toml` (run with `--config-file`). `config-key-bindings.toml` is not valid TOML and is not loaded.
- `.bashrc` sources ROS 2 only when `$TERMINAL` is `alacritty-ros` (set in `alacritty-ros.toml`); Ghostty has no ROS variant.
- `pkg-bash/.bash_aliases` holds the launcher functions: `vi`, `vi-beta`, `vi-lv` (and the `*-ghostty` duplicates) open nvim in Ghostty via `ghostty-terminal-with-nvim-*`, choosing the nvim config with `NVIM_APPNAME` (`nvim/active|beta|lazyvim`). `term-ghostty` is a general Ghostty window. The `alacritty-terminal-*` functions remain as fallback. Ghostty functions redirect output to `/dev/null` to hide harmless GTK/Adwaita warnings; run `ghostty` directly to debug.
- `pkg-*/applications/*.desktop` (`nvim-ghostty`, `nvim-alacritty`) are symlinked by hand into `~/.local/share/applications` with `ln -s` (not stowed, excluded via `^/applications` in `.stow-local-ignore`). `text/markdown` and `text/plain` default to `nvim-ghostty.desktop` (`xdg-mime query default <mime>`).
- `pkg-wezterm/` is only a README stub.

## Neovim (`pkg-nvim/nvim/`)

- Multiple configs side by side: `active/` (in use), `beta/` (candidate to become active), `lazyvim/` (stock LazyVim starter), `_archive/`. The old `experimental/` dir was removed and promoted into `active/`.
- `active/` follows LazyVim layout: `init.lua` -> `require("config.lazy")`; settings in `lua/config/{options,keymaps,autocmds,lazy}.lua`; plugin specs in `lua/plugins/*.lua` (e.g. `json-format.lua` = prettier via conform.nvim + mason, `sem.lua`).
- The header comment in `pkg-nvim/nvim/init.lua` describes an older directory layout (`lua/active/...`). Don't trust it over the real tree.
- Plugin pins live in `active/lazy-lock.json` (a `.bak` is kept beside it).
- To try another config without changing the symlink: `NVIM_APPNAME=<name> nvim` (needs `~/.config/<name>` symlink).
- Health check inside nvim: `:checkhealth lazy`. Update plugins: `:Lazy update`.
- Images in buffers: `active/lua/plugins/snacks-image.lua` enables the snacks.nvim image module (kitty protocol, Ghostty; nvim is launched directly, not in tmux). Renders image files and inline markdown images, `<leader>uv` = hover image. It carries workarounds that rely on snacks internals (snacks pinned in `lazy-lock.json`, re-check after `:Lazy update snacks.nvim`): a debounced rebuild of placements on `BufEnter`/`TabEnter`, a wrapper that tracks `snacks.image.inline` instances, and a patch of `Image.del` (upstream bug: sends placement id 1 instead of the real id). Known issue: the same file shown as markdown inline image and as a PNG buffer can intermittently render wrong (small/cropped) after toggling tabs. Mermaid: `mmdc` (npm global, nvm) runs via `active/puppeteer-no-sandbox.json` because Ubuntu AppArmor blocks Chromium's sandbox. Don't fire a synthetic `WinResized` (breaks snacks.win). `image.formats` is generated from one ext list at the top of the file: the snacks defaults plus `svg`/`svgz` (not default, so SVGs otherwise open as XML), each also as a case-insensitive pattern like `[jJ][pP][gG]` (autocmd patterns are case-sensitive; camera photos are `*.JPG`/`*.Jpg`). A list in opts replaces the defaults, so keep the full list. SVG renders via an Inkscape AppImage delegate (slow first start). The image-buffer rebuild only runs when returning to a buffer already left, since rebuilding on first open blanked big photos.
- `pkg-nvim/test-cases/` holds per-language sample files for exercising lint/format behavior. `pkg-nvim/bin/` has helper scripts (`purge_nvim.sh`, `refresh_nvim.sh`) that wipe nvim cache/state/data — destructive, don't run without asking.

## Claude Config Package (`pkg-claude/`)

Source for `~/.claude` content:

- `global/` — user-level `CLAUDE.md`, `settings.json`, `hooks/block-dangerous-bash.py`, and skills (presentation, questioning, research, truth).
- `local/` — project-level `CLAUDE.md` and skills (e.g. `coding_skills/docker_writer`).
- `project/CLAUDE-project.md` — template for new projects. `claude_skills/templates/` — skill and slash-command templates.
- `scripting-rules.md` — shared vocabulary for Bash/Python scripts (parameter vs argument, etc.). `voice-principles.md` — writing voice guide.
- `global/hooks/block-dangerous-bash.py` is a PreToolUse hook (wired in `global/settings.json`) that **blocks Bash commands** matching regexes: `rm -rf`, `sudo rm`, `chmod 777`, any `git push`, `git reset --hard`, `git clean -f`, `git branch -D`, `git checkout .`, `git restore .`. Blocked calls exit 2 with "BLOCKED". Don't retry or work around; ask the user to run it (`! <cmd>`).
- Each skill is a dir with `SKILL.md` (+ optional `references/`, `assets/`, `scripts/`).

## Conventions

- `my-prompts.md` at root is a personal prompt library.
- Markdown here intentionally uses long lines (line-length rule relaxed) and `---------------` as horizontal rule style; follow the existing markdownlint config rather than reformatting.
- Files carry maintainer/version header comments; keep them when editing.
