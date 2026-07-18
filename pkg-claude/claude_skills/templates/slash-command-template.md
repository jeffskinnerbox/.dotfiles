---
name: {command-name}
description: *{What this command does and when Claude should auto-invoke it. Front-load the key use case — this field is capped at 1,536 chars and truncated under context pressure. Be explicit about trigger keywords.}*
argument-hint: *{[optional] Human-readable hint shown in autocomplete, e.g. [file-path] or [issue-number] [priority]. Omit if command takes no arguments.}*
allowed-tools: *{Comma-separated list of tools this command may use without per-use approval, e.g. Read, Grep, Glob, Bash(git diff:*), Edit. Omit to inherit session defaults.}*
model: *{Optional model override, e.g. claude-opus-4-6. Omit to use session default.}*
context: *{Optional. Set to "fork" to run in an isolated context so it doesn't pollute the main session.}*
agent: *{Optional. Subagent to delegate to, e.g. "general-purpose" or a custom agent name from .claude/agents/.}*
disable-model-invocation: *{true | false. Set true to prevent Claude from auto-invoking this skill without an explicit /command call. Default: false.}*
---

# {Command Name}

## Purpose

*{One paragraph explaining what this command does, what problem it solves, and when a user would reach for it. Think of this as the "why" — the frontmatter description covers "when to trigger", this covers intent.}*

## Instructions

*{The core prompt Claude follows when this command is invoked. Be direct and imperative. Structure as numbered steps if order matters. This is the main body of the command — make it specific enough that Claude produces consistent output without needing extra guidance from the user.}*

1. *{Step 1 — e.g., "Read the files matching $ARGUMENTS"}*
2. *{Step 2}*
3. *{Step 3}*

## Arguments

*{Describe what $ARGUMENTS (or $1, $2 for positional) maps to and how they affect behavior. Include examples. Omit section if the command takes no arguments.}*

| Placeholder | Meaning | Example |
|-------------|---------|---------|
| `$ARGUMENTS` | *{What the full argument string represents}* | `/command-name foo bar` |
| `$1` | *{First positional arg, if using positional syntax}* | *{e.g., file path}* |
| `$2` | *{Second positional arg}* | *{e.g., severity level}* |

## Output Format

*{Describe what Claude should produce: a summary, a patched file, a report, a checklist, etc. The more specific, the more consistent the output. Include an example output snippet if helpful.}*

## Examples

```
# Basic invocation
/{command-name}

# With arguments
/{command-name} {example-arg-1} {example-arg-2}
```

## Notes

*{Any caveats, edge cases, or "don't do X" reminders. E.g., "This command modifies files in-place — ensure changes are committed first." Keep it short.}*
