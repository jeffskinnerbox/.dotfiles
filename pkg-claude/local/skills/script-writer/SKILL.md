---
name: script-writer
description: Write, review, or fix Bash or Python command-line scripts that handle arguments correctly, recover from errors instead of crashing cryptically, and are self-documenting with excellent --help output. Use this whenever the user asks for a shell script, bash script, python script, CLI tool, command-line tool, automation script, or wants an existing script audited/hardened/fixed for argument parsing, error handling, or --help/usage text -- even if they don't use the word "script" explicitly (e.g. "write something that loops over these files and renames them", "make a tool that backs up a directory"). Also use when the user references scripting-rules.md or asks about positional/keyword arguments, options, or getopts/argparse conventions.
---

# Script Writer

## Why this skill exists

Scripts that are dashed off quickly tend to fail in the same three places: they mishandle
arguments (wrong positional/option split, no validation, silent misuse), they die with a raw
stack trace or a `set: command not found`-style error instead of a clear message, and they have
no `--help` at all or one that lies about what the script actually does. This skill exists to
make those three things automatic rather than something to remember each time.

Everything here follows the terminology and rules in `references/scripting-rules.md` (a
Bash/Python glossary sourced from `man bash` and the official Python docs: script, parameter,
argument, positional vs. keyword, option/flag). Read that file if you need to explain *why* a
piece of arg-handling code is structured the way it is, or if the user asks a definitional
question about scripting terms.

## When to generate vs. when to review

- **Generating a new script**: start from the matching template in `assets/` (see below),
  fill in the real logic, and delete anything the script doesn't need (an unused retry
  helper, an unused option). Don't leave placeholder comments like `<what this does>` in
  the delivered script.
- **Reviewing/fixing an existing script**: read it fully, then walk the checklist below
  section by section, fixing anything that doesn't hold up. Don't rewrite working, correct
  code just to match the template's exact shape — the checklist states the *properties*
  that matter, not a mandate to make every script byte-identical to the template.

Either way, the same three pillars apply: argument handling, error recovery, self-documentation.

## Pillar 1: Argument handling

Get the positional/option split right before anything else — it's the thing users hit first.

- **Bash**: use the `getopts` builtin to parse options (never hand-rolled `[ "$1" = "-x" ]`
  string comparisons — they don't handle combined short flags, don't give clean errors, and
  silently break when option order changes). Remaining `$@` after `shift $((OPTIND-1))` are
  the positional arguments. Validate positional count (`$#`) and option values *before* using
  them — fail fast with a usage message, don't let a missing arg surface as an obscure error
  three commands later.
- **Python**: use `argparse`. Bare names in `add_argument()` are positional; `-x`/`--long`
  flags are options. Prefer explicit `type=`, sensible `default=`, and `action='store_true'`
  for booleans over accepting a string and parsing it yourself. Let argparse's own validation
  (required positional args, `type=int` conversion, etc.) do the work instead of re-checking
  it manually afterward.
- Full definitions and validation checklists for every term (parameter, argument, positional,
  keyword, option) are in `references/scripting-rules.md` — consult it when unsure whether
  something should be positional or an option, or whether a Bash construct is even valid
  (Bash has no keyword arguments; don't invent fake ones).

## Pillar 2: Error recovery

A script should never fail with a raw interpreter traceback or an unexplained non-zero exit.
Every failure path should produce a clear message on stderr and a meaningful exit code.

- **Bash**:
  - Start with `set -euo pipefail` (exit on error, exit on unset variable, fail a pipeline
    if any stage fails) unless the script has a specific, commented reason not to (e.g. a
    loop that must tolerate individual command failures).
  - Use `trap cleanup EXIT` for anything that needs cleanup regardless of how the script
    exits (temp files/dirs, background jobs) — see `assets/template.sh`'s `cleanup()`/`trap`
    pair. Trap `INT TERM` separately if the script should say something specific on Ctrl-C.
  - Validate inputs up front (file existence, required option values, argument counts)
    and `die` with a specific message and a distinct exit code per failure category —
    don't reuse exit code 1 for both "usage error" and "the actual job failed."
  - For network calls or other flaky operations, wrap them in a retry-with-backoff helper
    like the `retry()` function in `assets/template.sh` rather than letting a single
    transient failure kill the whole script.
- **Python**:
  - Raise a small script-specific exception (see `ScriptError` in `assets/template.py`)
    for expected failure modes, and catch it exactly once in `main()` to log a clean message
    and return the right exit code — don't let exceptions propagate to a raw traceback, and
    don't scatter `try/except` throughout the business logic.
  - Validate inputs before doing anything with them (file existence, value ranges) and raise
    `ScriptError` with a distinct `exit_code` per category, mirroring the Bash exit-code
    convention above.
  - Wrap flaky calls in a retry-with-backoff helper (see `retry()` in `assets/template.py`)
    instead of a bare try/except that swallows the error or fails on the first attempt.
  - Use the standard `logging` module (not bare `print`) once a script does more than the
    simplest one-shot task, so verbosity is controllable via `-v/--verbose` and messages are
    distinguishable as INFO/WARNING/ERROR.

## Pillar 3: Self-documentation (`--help`)

`--help` (or `-h`) must exist, must be accurate, and must follow a consistent shape so any
script produced by this skill looks like part of the same family:

1. One-line usage synopsis (program name, options, positional args).
2. Short description of what the script does and why.
3. Every option and positional argument, with what it means and whether it's required.
4. At least one runnable example invocation.

- **Bash** gets this for free from argparse's Python cousin, but has to build it by hand:
  write a `usage()` function (see `assets/template.sh`) and call it both for `-h` and
  whenever a usage error is detected (`die` after printing usage), so the same text serves
  both "the user asked for help" and "the user got the invocation wrong."
- **Python** gets most of this for free from `argparse` — set `description=` and `epilog=`
  (with `formatter_class=argparse.RawDescriptionHelpFormatter` if the epilog has its own
  line breaks, e.g. for an examples block) so `-h`/`--help` renders it. Don't write a second,
  separate help string by hand when argparse can generate one from the parser definition —
  keeping the source of truth in one place is what stops help text from drifting out of sync
  with the actual arguments.

## Templates

- `assets/template.sh` — full Bash skeleton: `usage()`, `getopts` loop, `set -euo pipefail`,
  `trap`-based cleanup, input validation, a `retry()` helper.
- `assets/template.py` — full Python skeleton: `argparse` setup with a Bash-mirroring exit-code
  convention, `ScriptError`, `logging` setup, a `retry()` helper, type hints throughout.

Start from these for new scripts. Strip out what's unused (e.g. delete `retry()` if the
script has nothing flaky to retry) rather than leaving dead code in the delivered script.

## Before handing back a script

Run through this checklist; fix anything that fails before considering the script done.

- [ ] `--help`/`-h` works and matches the actual arguments (no stale/missing options).
- [ ] Every option and positional argument is validated before use; bad input produces a
      clear stderr message + non-zero exit, not a crash or silent wrong behavior.
- [ ] Bash: `set -euo pipefail` present (or its absence is deliberate and commented);
      cleanup handled via `trap`; options parsed via `getopts`.
- [ ] Python: type hints on function signatures; exceptions for expected failures are caught
      once in `main()`; options/positionals declared via `argparse`, not manual `sys.argv`
      indexing.
- [ ] Exit codes are distinct per failure category and documented (in the `--help`/docstring
      or a header comment).
- [ ] If `shellcheck` (Bash) or `ruff`/`pylint` (Python) is installed, run it on the script
      and fix what it flags; if not installed, say so briefly rather than silently skipping —
      don't install new tooling without asking first.
- [ ] Actually run the script with `--help`, with valid args, and with one deliberately bad
      arg, to confirm the behavior described above actually happens rather than assuming it
      from reading the code.

## Reference

- `references/scripting-rules.md` — the full glossary (script, variable, parameter, argument,
  positional/keyword, option) with Bash-vs-Python comparisons and per-term validation notes,
  sourced from `man bash` and the official Python docs. Consult it for definitional questions
  or when the "right" categorization of an argument isn't obvious.
