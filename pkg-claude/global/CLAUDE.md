# Global Claude Code Instructions

This files location should be at `~/.claude/CLAUDE.md` so it has global impact

## Communication
**If possible, don't create or tolerate ambiguity.**

* Be concise. Call out trade-offs.
* Push back if a smaller approach can work.
* When you plan/design/solution is not clear, ask questions to clarify and give recommendations.

## Working Style
**Don't assume. Don't hide confusion. Surface trade-offs.**

* State assumptions before editing. If uncertain, ask.
* If multiple interpretations exist, present them - don't pick silently.
* If a simpler approach exists, say so. Push back when warranted.
* If something is unclear, stop. Name what's confusing. Ask.
* Prefer the smallest change that solves it.
* Touch only files needed for the change.
* Verify with the narrowest relevant test.

## Simplicity First
**Minimum text/code that solves the problem. Nothing speculative.**

* No features beyond what was asked.
* No abstractions for single-use code.
* No "flexibility" or "configurability" that wasn't requested.
* No error handling for impossible scenarios.
* If you write 200 lines and it could be 50, rewrite it.

## Surgical Changes
**Touch only what you must. Clean up only your own mess.**

* Every changed line should trace directly to the user's request.
* Don't "improve" adjacent code, comments, or formatting.
* Don't refactor things that aren't broken.
* Match existing style, even if you'd do it differently.
* If you notice unrelated dead code, text, comments, mention it - don't delete it.
* When your changes create orphans:
  * Remove text/imports/variables/functions/comments that YOUR changes made unused.
  * Don't remove pre-existing dead code unless asked.

## Goal-Driven Execution
**Define success criteria. Loop until verified.**

* Transform tasks into verifiable goals:
  * "Add validation" → "Write tests for invalid inputs, then make them pass"
  * "Fix the bug" → "Write a test that reproduces it, then make it pass"
  * "Refactor X" → "Ensure tests pass before and after"
  * "Create Feature X" → "Ensure tests stress/validate all key characteristics"
* For multi-step tasks, state a brief plan:
  1. [Step] → verify: [check]
  2. [Step] → verify: [check]
  3. [Step] → verify: [check]

## Context and Tool Use
* Use `rg -n <pat> <path>` for exact matches.
* Review edits with `git diff -- <path>`.

## Python Defaults
* Use `uv` for deps and environments.
* Use `logging` , not `print()`, in app code.
* Add type hints to public functions.
