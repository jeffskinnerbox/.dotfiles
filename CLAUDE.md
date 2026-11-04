# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles managed with GNU Stow. No build system or test suite. Content is shell/Lua/TOML/JSON config, Markdown docs, and Claude Code skills.

## Layout & Stow Conventions

- Each `pkg-<name>/` dir is a Stow package (bash, nvim, tmux, git, claude, alacritty, i3, X, etc.). Stow symlinks its contents into `$HOME` (or a chosen target), e.g. `stow --dir=~/.dotfiles --target=$HOME pkg-bash`.
- Each package has a `.stow-local-ignore` that excludes `bin`, `src`, `docs`, `files`, README/LICENSE, `.git*`. Those dirs are repo-only helpers/docs and are **not** symlinked.
- Edits to files under `pkg-*` are live: `~/.config/nvim` is a symlink to `pkg-nvim/nvim`, so changes take effect immediately.
- `pkg-vim/.vim/bundle/*` are git submodules (see `.gitmodules`).
- Root `README.md` is a personal scratchpad ("NOTES TO SELF", macOS install steps), not a project overview. `docs/` holds setup/how-to notes (Stow, fresh Ubuntu install).

## Checker Files

`checker-files/` is the single source of truth for lint/format rules (markdownlint-cli2, yamllint, luacheck, prettier). Repo-root `.markdownlint-cli2.jsonc`, `.yamllint.yaml` and `pkg-nvim/nvim/.markdownlint-cli2.jsonc` are **symlinks** into it. Edit the file in `checker-files/`, never break the links.

- `.markdownlint-cli2.jsonc` is the only markdownlint config. It wins over any `.markdownlint.yaml` in the same dir (the yaml was removed). It sets `"fix": true`, so linting **rewrites files in place**. Ignores `.claude/**` and `.specify/**` (vendored).
- Lint a markdown file: `~/.local/share/nvim/active/mason/bin/markdownlint-cli2 <file>` (mason-installed, not on PATH). Config is the nearest one walking up from the file.
- prettier (`.prettierrc`): width 100, 2-space, no trailing commas, `quoteProps: preserve` for JSON. Sole json/jsonc formatter in nvim.

## Neovim (`pkg-nvim/nvim/`)

- Multiple configs side by side: `active/` (in use), `beta/` (candidate to become active), `lazyvim/` (stock LazyVim starter), `_archive/`. The old `experimental/` dir was removed and promoted into `active/`.
- `active/` follows LazyVim layout: `init.lua` -> `require("config.lazy")`; settings in `lua/config/{options,keymaps,autocmds,lazy}.lua`; plugin specs in `lua/plugins/*.lua` (e.g. `json-format.lua` = prettier via conform.nvim + mason, `sem.lua`).
- The header comment in `pkg-nvim/nvim/init.lua` describes an older directory layout (`lua/active/...`). Don't trust it over the real tree.
- Plugin pins live in `active/lazy-lock.json` (a `.bak` is kept beside it).
- To try another config without changing the symlink: `NVIM_APPNAME=<name> nvim` (needs `~/.config/<name>` symlink).
- Health check inside nvim: `:checkhealth lazy`. Update plugins: `:Lazy update`.
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
