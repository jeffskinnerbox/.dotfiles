---
name: readme-generator
description: Generate a polished GitHub README.md by scanning a project directory for its language, dependencies, entry points, license, tests, CI, and Docker setup, then adaptively assembling only the sections the project actually warrants — a one-file script gets a short README, a tested library with CI gets a fuller one. Use this skill whenever the user asks to create, write, draft, or generate a README (or README.md) for a project/repo/codebase, wants an existing README refreshed to match the current code, or asks to "document this project" for GitHub. Trigger even if they just say "write me a README" without more detail.
---

# README Generator

Produces a README.md from the actual state of a project directory, not a
generic template. Facts come from a deterministic scan; interpretation
(what the project is *for*) comes from you reading a little source.

## Workflow

1. **Scan the project**

   ```bash
   python scripts/scan_project.py <path_to_project_root>
   ```

   Returns JSON: languages, parsed manifests (deps, scripts, entry points),
   license guess, CI config, test setup, Docker files, existing README, and
   a trimmed directory tree. This is deterministic — trust it for facts,
   don't re-derive them by hand.

2. **Fill what the script can't see**
   The scan won't tell you what the project *does*. Read the entry point's
   docstring/top comment, skim `docs/` or `CONTRIBUTING.md` if present, and
   for CLIs check the argument parser for real usage. Never invent a
   feature, command, or dependency that isn't backed by the scan or source.

3. **Pick depth and sections**
   See `references/section_guide.md` for the tier table (Micro / Standard /
   Full / Monorepo) and which sections + badges each tier earns. Only
   include a section if the scan/source actually produced content for it.

4. **Write the file**
   - No existing README → write `README.md` directly at the project root.
   - Existing README → show a diff/summary of what would change and confirm
     before overwriting, or write `README.generated.md` alongside it if the
     user wants to compare first.

5. **Sanity check before finishing**
   - Every command in the README actually appears in the scan output.
   - Every badge corresponds to a signal the scan actually found.
   - No placeholder text (`<your project>`, `TODO`, etc.) left behind.

## Notes

- Ignore noise directories automatically (`node_modules`, `.git`, `venv`,
  `dist`, `target`, etc. — handled by the script).
- Multi-language repos: report all detected languages, but lead the
  description with whichever has the most source files unless the manifest
  says otherwise (e.g. a Python project with a small `scripts/` dir in Bash
  is still a Python project).
- If the directory doesn't look like a project root (no manifest, no source
  files, mostly data/docs), say so rather than forcing a README onto it.
