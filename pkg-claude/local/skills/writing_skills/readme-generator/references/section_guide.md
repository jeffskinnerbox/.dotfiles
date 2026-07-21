# README Section Guide

Used after `scan_project.py` has run. This maps scan signals → depth tier →
which sections to include. Don't include a section just because it's listed
here — only if the scan actually produced content for it. An empty
"Contributing" section is worse than no section.

## 1. Pick a depth tier

| Signal (from scan JSON)                                          | Tier          |
|--------------------------------------------------------------------|---------------|
| `file_count_scanned` < 15, one manifest, no CI/tests               | **Micro**     |
| Single manifest, some deps, maybe tests, no CI                     | **Standard**  |
| CI present, tests present, license present, >1 manifest or workspace | **Full**    |
| Multiple top-level packages/services (monorepo-shaped tree)        | **Monorepo**  |

If unsure between two tiers, prefer the smaller one — a padded README for a
50-line script reads as noise, not polish.

## 2. Section order by tier

**Micro** (script, small utility):
1. Title + one-line description
2. Usage (how to run it)
3. License badge/line if a LICENSE file was found

**Standard** (typical library/app):
1. Title + description (1–3 sentences, from manifest description or entry-point docstring)
2. Badges (only for things actually detected — see §3)
3. Installation
4. Usage (with a real example, not a placeholder)
5. Configuration (only if env vars / config files were found)
6. Testing (only if `tests.has_test_directory` or config files were found)
7. License

**Full** (adds to Standard):
- Table of Contents (if the README will exceed ~6 sections)
- Features (bullet list, only if distinguishing capabilities are evident from code/docs, not invented)
- Contributing (only if CONTRIBUTING.md exists — link to it, don't duplicate it)
- CI badge (from `ci` detection)

**Monorepo**:
- Title + description
- High-level architecture: one line per sub-package/service, not full docs for each
- Link out to each sub-package's own README if one exists, rather than inlining everything
- Root-level install/build/test commands only

## 3. Badges (shields.io)

Only emit a badge if the scan actually found the underlying signal — never
placeholder or aspirational badges.

- License (from `license.spdx_guess`):
  `![License](https://img.shields.io/badge/license-<SPDX>-blue)`
- npm version (if `package_json.name` and published — don't assume published,
  phrase as install instructions instead unless user confirms it's on npm)
- CI (if `ci` non-empty and it's GitHub Actions):
  `![CI](https://github.com/<owner>/<repo>/actions/workflows/<file>/badge.svg)`
  — only if a git remote / repo slug is knowable; otherwise skip rather than guess.
- Language/version (from `requires_python`, `go_version`, engines field, etc.)

## 4. Filling what the script can't see

`scan_project.py` reports facts, not intent. Before writing the description
and usage sections, do a short pass yourself:

- Read the entry point (`main.py`, `index.js`, `src/main.rs`, `cmd/*/main.go`)
  for a module docstring or top comment explaining purpose.
- If it's a CLI, check for an argparse/click/cobra setup — the `--help` text
  or command definitions make a better usage example than a guess.
- If it's a library, check the primary export/class for its docstring.
- Skim `docs/`, `CONTRIBUTING.md`, `CHANGELOG.md` if present, but don't
  reproduce them — link out.

Think of the script as a home inspector: it checks the wiring and foundation
(manifests, license, CI, tests) so you can spend your attention on the part
that actually needs a human eye — what the place is for and how to live in it.

## 5. Guardrails

- Never invent dependencies, commands, or features not present in the scan
  or the source. If usage is genuinely unclear, write the install step and
  a minimal "run it and see" note rather than fabricating an example.
- If `existing_readme` is present, treat its content as a source of truth
  for anything the scan can't verify (project rationale, known caveats) —
  merge, don't silently discard.
- Keep the whole file skimmable: short paragraphs, real code blocks for
  commands, no walls of prose.
