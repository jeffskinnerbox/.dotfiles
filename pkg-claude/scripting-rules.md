<!-- markdownlint-disable MD025 MD024 -->
# Bash & Python Scripting Rules

## Purpose
Shared vocabulary for Bash & Python scripts. Use to write consistent scripts + validate existing ones
against a fixed set of terms. Definitions sourced from official docs only: GNU Bash Reference
Manual / `man bash`, and Python 3 official docs (`docs.python.org`: glossary, argparse, tutorial).

## Common Ground (both languages)
Both languages distinguish two related but different things:

- **Parameter** — the placeholder declared by the script/function author
  (Bash: `$1`, `$2`... implicitly; Python: names in a `def` signature).
- **Argument** — the actual value supplied at invocation/call time,
  matched to a parameter either by position or by keyword.

Both languages also split arguments into two flavors:

- **Positional** — matched by order, no name needed at call site.
- **Keyword/option** — matched by an explicit name or flag
  (`--foo=x` in Bash convention, `foo=x` or `-f`/`--foo` in Python).

Where they diverge: Python has this as a first-class language feature (`def f(a, *, b=1)`);
Bash has no language-level concept of keyword args or options — everything a shell script
receives is a positional parameter (`$1`, `$2`, ...), and "options"/"flags" are a convention
the script author implements by hand (typically with `getopts`).

Keep this common/divergent split in mind — each section below defines the same terms
but the mechanics differ.

<p align="center"><strong>Quick Reference Table</strong></p>

| Term | Bash | Python |
|---|---|---|
| Variable | named parameter, `name=value` | name bound to object |
| Parameter | variable, positional param, or special param | placeholder in `def` signature (5 kinds) |
| Argument | word passed to script/function at invocation | value passed to a function call |
| Positional parameter/argument | `$1`, `$2`, ... (`$0` = script name, special) | argument matched by position, no keyword |
| Keyword parameter/argument | *(none — simulate via option parsing)* | `name=value` at call, or keyword-only param after `*` |
| Option/flag | word starting with `-`/`--`, parsed via `getopts` | `add_argument('-f','--foo', ...)` in argparse |


---

# Bash Rules

## Overview
In Bash there is no distinct "argument" object like Python has — the words following
the script/command name on invocation become the script's **positional parameters**.
Bash itself has no built-in notion of "option" separate from a positional parameter;
the `-`/`--` flag convention is enforced entirely by the script author,
usually via the `getopts` builtin. Everything below is grounded in `man bash`
(PARAMETERS, Positional Parameters, Special Parameters, and the `getopts` builtin entry).

### The `getopts` Builtin
`man bash`: "`getopts` is used by shell procedures to parse positional parameters."
Syntax: `getopts optstring name [arg ...]`.

- `optstring` — the option characters to recognize (e.g. `"a:bh"`).
  A colon after a character (`a:`) means that option requires an argument,
  supplied separated by whitespace or attached.
- `name` — the variable `getopts` sets on each call to the option character found
  (or `?` on an invalid option).
- Called repeatedly, typically in a `while` loop, once per option,
  until it returns non-zero (no more options).
- `OPTIND` tracks the index of the next argument to process
  (starts at 1, must be reset manually between multiple parses in the same shell).
- `OPTARG` holds the value of an option that requires an argument.
- A leading `:` in `optstring` (e.g. `":a:bh"`) enables silent error reporting:
  invalid options set `name` to `?` with the bad char in `OPTARG`;
  missing required args set `name` to `:` with the option char in `OPTARG`,
  instead of `getopts` printing its own diagnostic.

**Typical usage:**

```bash
#!/usr/bin/env bash
# usage: script.sh -a VALUE [-b] [-h]

while getopts ":a:bh" opt; do
  case "$opt" in
    a) aval="$OPTARG" ;;
    b) bflag=1 ;;
    h) echo "usage: $0 -a VALUE [-b] [-h]"; exit 0 ;;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done
shift $((OPTIND - 1))   # remaining args are now $1, $2, ... (positional, non-option)

echo "aval=$aval bflag=${bflag:-0} remaining args: $*"
```

Run as `./script.sh -a foo -b file1 file2` →
`aval=foo bflag=1 remaining args: file1 file2`.

## Variable
A named storage location holding a value that can change during execution.

`man bash`, PARAMETERS section: "A variable is a parameter denoted by a name.
A variable has a value and zero or more attributes." Assigned via `name=value`
(no spaces around `=`).

**Validate:** descriptive names; quote variable expansions (`"$var"`)
unless intentional word-splitting; consistent naming case.

## Parameter
`man bash`, PARAMETERS: "A parameter is an entity that stores values.
It can be a name, a number, or one of the special characters listed below
under Special Parameters." Three kinds: variables (named),
positional parameters (numbered),
special parameters (`*`, `@`, `#`, `?`, `-`, `$`, `!`, `0`).

**Validate:** every parameter referenced in the script is one of these three kinds —
no typo'd `$` expansions.

## Argument
Informally, the words passed to a script or command on the command line —
these become the script's positional parameters (`$1`, `$2`, ...)
once the script starts running. Also passed to `getopts` as `arg`
in `getopts optstring name [arg ...]`.

**Validate:** number/order of args passed matches what the script/function expects;
required args aren't silently assumed present.

## Positional Parameter
`man bash`, "Positional Parameters": "A positional parameter is a parameter denoted
by one or more digits, other than the single digit 0. Positional parameters are
assigned from the shell's arguments when it is invoked, and may be reassigned
using the `set` builtin command. Positional parameters may not be assigned to
with assignment statements."

Referenced as `$1`, `$2`, ... `${10}` (braces required beyond a single digit).
`$0` is the script/shell name — a **special** parameter, not positional.
`$#` = count of positional parameters. `$@`/`$*` = all of them
(see Special Parameters below for quoting differences).

**Validate:** script uses `$1`, `$2`... consistently with documented usage/help text;
checks `$#` before assuming an arg exists; quotes `"$@"` when forwarding all args
to another command (never bare `$*` unless deliberate — `"$*"` collapses args
into one word, `"$@"` preserves them as separate words).

## Special Parameters
`man bash`, "Special Parameters": "The shell treats several parameters specially.
These parameters may only be referenced; assignment to them is not allowed." Includes:

- `$@` / `$*` — all positional parameters
  (differ in word-splitting behavior when quoted)
- `$#` — count of positional parameters
- `$?` — exit status of the most recently executed foreground pipeline
- `$-` — current option flags set for the shell
- `$$` — process ID of the shell
- `$!` — process ID of the most recent background job
- `$0` — name of the shell or shell script

**Validate:** `$?` checked immediately after the command it refers to
(nothing runs in between that would overwrite it); `$0` not assumed to be
a full path in all invocation contexts.

## Keyword Parameter / Keyword Argument
No native equivalent. Bash has no language-level keyword-argument mechanism
for functions — all arguments are positional (`$1`, `$2`, ...) inside a shell
function, regardless of how the caller conceptually intends them.
Simulated keyword-style args are done manually via flag parsing
(`--name=value` parsed with `getopts` or a manual `case` loop),
which is really an **option** (see below), not a language-level keyword parameter.

**Validate:** if a script simulates keyword args via `--name=value`,
this is documented as a convention (not a language guarantee) and parsed defensively.

## Option (a.k.a. flag)
`man bash`, `getopts` entry: "`getopts` is used by shell procedures to parse
positional parameters. `optstring` contains the option characters to be recognized;
if a character is followed by a colon, the option is expected to have an argument,
which should be separated from it by white space." Options remain, technically,
positional parameters until parsed out by `getopts` or manual `case` logic —
Bash has no built-in concept of "option" distinct from a positional parameter;
it's a convention enforced by the script author.

**Validate:** options parsed with `getopts` (not manual `[ "$1" = "-x" ]` string checks,
which are error-prone and don't handle combined short opts like `-xz`);
required option arguments checked for presence
(`optstring` uses `:` correctly for args that require a value);
`--` used to signal end-of-options if the script also takes positional args
that could start with `-`.

---

# Python Rules

## Overview
Python treats "parameter" and "argument" as distinct, well-defined terms tied
to function definitions (`def`) vs. function calls — this is documented explicitly
in the official Python glossary. `argparse` (the standard CLI-parsing library)
then maps this same positional/keyword split onto command-line scripts:
positional arguments are declared as bare names, options are declared with a
`-`/`--` prefix. Everything below is grounded in `docs.python.org/3/glossary.html`
and `docs.python.org/3/library/argparse.html`.

### The `argparse` module
docs.python.org/3/library/argparse.html: "The `argparse` module makes it easy
to write user-friendly command-line interfaces." A script builds a parser,
declares each expected positional argument and option on it, then calls
`parse_args()` to read `sys.argv` and produce a `Namespace` object with one
attribute per argument.

- `ArgumentParser(...)` — construct the parser; optional `prog`, `description`,
  `epilog` control the auto-generated `--help` text.
- `add_argument(name_or_flags, ...)` — declare one argument:
  - a bare name (e.g. `'filename'`) → positional argument.
  - one or more flags (e.g. `'-c', '--count'`) → optional argument (option).
  - `action='store_true'` (or `'store_false'`) → boolean on/off flag,
    no value expected.
- `parse_args()` — parses `sys.argv[1:]`, identifies options by their `-`/`--` prefix,
  treats everything else as positional, and errors out (printing usage) on
  unrecognized or missing required arguments.

**Typical usage** (from the official docs):

```python
import argparse

parser = argparse.ArgumentParser(
                    prog='ProgramName',
                    description='What the program does',
                    epilog='Text at the bottom of help')

parser.add_argument('filename')           # positional argument
parser.add_argument('-c', '--count')      # option that takes a value
parser.add_argument('-v', '--verbose',
                    action='store_true')  # on/off flag

args = parser.parse_args()
print(args.filename, args.count, args.verbose)
```

Run as `python prog.py notes.txt -c 3 -v` → prints `notes.txt 3 True`.
Run as `python prog.py -c 3` (no `filename`) → argparse prints a usage error
and exits, since `filename` is a required positional argument.

## Variable
Python's glossary doesn't define "variable" as a standalone term — informally,
it's a name bound to an object via assignment (`x = 5`),
living in some namespace (local, global, enclosing).

**Validate:** no shadowing builtins; consistent naming (snake_case per PEP 8);
no reuse of a variable name for unrelated purposes within the same scope.

## Parameter
docs.python.org/3/glossary: "A named entity in a function (or method) definition
that specifies an argument (or in some cases, arguments) that the function can accept."
Five kinds, per the glossary:

- **positional-or-keyword** — can be supplied either way
- **positional-only** — only by position
- **keyword-only** — only by keyword
- **var-positional** — arbitrary extra positional args (`*args`)
- **var-keyword** — arbitrary extra keyword args (`**kwargs`)

**Validate:** parameter kind (positional-only / keyword-only / either) matches
how the function is actually meant to be called; `*args`/`**kwargs` used only
when genuinely variadic, not as a substitute for explicit parameters.

## Argument
docs.python.org/3/glossary: "A value passed to a function (or method)
when calling the function." Two kinds:

- **positional argument** — not preceded by a keyword identifier;
  matched to parameters by order (e.g. `complex(3, 5)`).
- **keyword argument** — preceded by an identifier in the call,
  e.g. `complex(real=3, imag=5)`.

**Validate:** number/order of args passed matches the function's declared parameters;
required args aren't silently defaulted; calls don't rely on positional order for
parameters that are logically independent/optional
(prefer keyword args there for readability).

## Positional Argument
See **Argument** above. In `argparse` (docs.python.org/3/library/argparse.html):
"The first arguments passed to `add_argument()` must therefore be either a series
of flags, or a simple argument name" — a bare name (e.g. `parser.add_argument('bar')`)
creates a positional argument, identified at parse time by its position, not a flag.

**Validate:** positional args in a CLI script are the ones that are always required
and don't need a flag name at the call site; order matters — don't reorder
without updating all call sites and help text.

## Keyword Argument / Keyword-only Parameter
A **keyword argument** is passed as `name=value` at call time.
A **keyword-only parameter** (per the glossary's "Parameter" entry,
kind: *keyword-only*) can only be supplied by keyword —
declared after a bare `*` (or after `*args`) in the `def` signature:

```python
def f(a, *, b):   # b is keyword-only
    ...
f(1, b=2)         # valid
f(1, 2)           # TypeError
```

**Validate:** keyword-only params come after `*` or `*args`; don't silently allow
positional calling of something meant to be keyword-only
(defeats the purpose — usually clarity for optional/config-like args).

## Option (a.k.a. optional argument)
docs.python.org/3/library/argparse.html: "The `add_argument()` method must know
whether an optional argument, like `-f` or `--foo`, or a positional argument,
like a list of filenames, is expected." At parse time: "optional arguments will
be identified by the `-` prefix, and the remaining arguments will be assumed
to be positional."

```python
parser.add_argument('-f', '--foo')   # optional argument (option)
parser.add_argument('bar')           # positional argument
```

**Validate:** `add_argument` calls with `-`/`--` prefix = options;
bare names = positional; boolean flags use `action='store_true'`/`'store_false'`
(not a dangling required value); mutually exclusive options grouped via
`add_mutually_exclusive_group()` where relevant.

---

# Sources
The above definitions & rules were take form these official sources:

- [GNU Bash Reference Manual][01]
- [Python 3 official docs — Glossary][02]
- [Python 3 official docs — `argparse`][03]



[01]:https://www.gnu.org/software/bash/manual/bash.html
[02]:https://docs.python.org/3/glossary.html
[03]:https://docs.python.org/3/library/argparse.html

