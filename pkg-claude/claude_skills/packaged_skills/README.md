

# Install These Plugin

```text
/plugin install skill-creator@claude-plugins-official
```


I'm using Claude Code, Claude Desktop, Claude Coworker, etc. Where are all the places where SKILL.md files are stored?

For the Claude ecosystem (Claude Code, Desktop, and Coworker),
`SKILL.md` files are primarily organized into two scopes:
Global (available everywhere)
and Project (local to a specific repository).

## Primarily Organized for Ubuntu 24.04
1. **Claude Code (CLI) & Claude Desktop**
   Claude Code and the Desktop app share a unified configuration structure.
   They look for skills in the following order of precedence:
* **Global / Personal Skills:**
  * **Path:** `~/.claude/skills/<skill-name>/SKILL.md`
  * **Usage:** These are your "power user" tools that follow you across all projects.
    If you create a skill via the CLI without a project context, it typically lands here.
* **Project-Scoped Skills:**
  * **Path:** `<your-project-root>/.claude/skills/<skill-name>/SKILL.md`
  * **Usage:** These are committed to Git.
    They allow anyone working on the repo to use the same custom capabilities (e.g., a `/review-pr` skill).
2. **Claude Coworker (Cloud & Local Agent Mode)**
   Coworker handles skills differently depending on how they were initiated.
   Because Coworker often runs in a sandboxed or VM-like environment,
   the storage can be more fragmented:
* **Persistent Personal Skills:**
  * **Path:** `~/.config/Claude/local-agent-mode-sessions/skills-plugin/`
  * **Usage:** Coworker is designed to eventually sync with `~/.claude/skills/`, but it primarily reads from its own config directory:
* **Ephemeral Session Skills:**
  * **Path:** `~/.config/Claude/local-agent-mode-sessions/local_<uuid>/.claude/skills/`
  * **Usage:** If you create a skill _during_ a Coworker session and don't "promote" it,
    it may be stored in a temporary UUID-based folder:
  * **Warning:** These files are often deleted when the session is cleaned up unless
      manually moved to the global `~/.claude/skills/` directory.

## Pro-Tips for Managing SKILL.md
* **Naming:** Each `SKILL.md` must be inside its own subfolder named after the skill
  (e.g., `skills/my-handy-tool/SKILL.md`). If the file is loose in the `skills/` root, it will be ignored.
* **Visibility:** You can quickly verify which skills are active by running `claude skills list` in your terminal
  or checking the **Customize > Skills** menu in the Desktop/Coworker UI.
* **The CLAUDE_CONFIG_DIR Variable:** If you have set the `CLAUDE_CONFIG_DIR` environment variable,
  all the `~/.claude/` paths mentioned above will move to that specific directory.

## Read a SKILL.md File
To read the details of a specific skill while working inside Claude Code,
you have three primary methods depending on whether you want the information displayed
in your terminal or if you want Claude to explain it to you.

1. **The Direct CLI Command**
The fastest way to output the contents of a SKILL.md file directly to your terminal
without leaving the Claude Code environment is the get command:

```bash
claude skills get <skill-name>
```

* **What it does:** This prints the full Markdown content of the skill, including the description, instructions, and any code blocks or examples.
* **Why use it:** It’s useful for a quick reference to the "system instructions" that govern how that specific skill behaves.
2. **Conversational Inspection**
Since Claude Code is an agentic interface,
you can simply ask the model to inspect its own capabilities.
This is often better if you want a summary rather than the raw Markdown.
Try prompts like:

```text
Show me the definition of the <skill-name> skill.

What are the specific instructions for the <skill-name> skill?

Explain how the <skill-name> skill handles [specific task].
```

Summary of Commands

| Action | Command |
|:-------|:--------|
| View Raw Content | `claude skills get <skill-name>` |
| Find File Path | `claude skills list --paths` |
| Ask Claude | "What does the <skill-name> skill do?" |
| Open for Editing | `!nvim <path-to-skill-md>` |

## A Note on MCP Skills
If the skill is provided by an MCP (Model Context Protocol) package rather than a local `SKILL.md` file,
the get command may not work.
In that case, use:

```bash
claude mcp list
```

This will show you which server provides the skill.
To see what that specific MCP server can do,
you can ask Claude:

```test
List the tools and resources available from the [server-name] MCP."
```

## What in My System

```bash
lsa ~/.claude/skills/
code-doc-writer/
generalize-knowledge/
skill-generator/
validate-your-work/
code-reviewer/
project-doc-writer/
test-generator/
```

```text
# in claude code, enter this on the commandline
claude skills list

Superpowers (workflow discipline)
- superpowers:using-superpowers — session startup, skill invocation rules
- superpowers:brainstorming — before any creative/feature work
- superpowers:writing-plans — planning multi-step tasks
- superpowers:executing-plans — executing written plans with review checkpoints
- superpowers:subagent-driven-development — parallel agent execution
- superpowers:dispatching-parallel-agents — 2+ independent tasks
- superpowers:test-driven-development — TDD for features/bugfixes
- superpowers:systematic-debugging — bug/test failure investigation
- superpowers:requesting-code-review — before merging/completing tasks
- superpowers:receiving-code-review — handling review feedback
- superpowers:verification-before-completion — verify before claiming done
- superpowers:finishing-a-development-branch — post-implementation integration
- superpowers:using-git-worktrees — isolated feature workspaces
- superpowers:writing-skills — create/edit/verify skills

Code quality
- code-reviewer — review for quality, security, maintainability
- code-simplifier — simplify/refine changed code
- simplify — reuse, quality, efficiency review
- security-review — security review of pending branch changes
- validate-your-work — run and verify output after implementation
- generalize-knowledge — extract lessons into memory/docs

Documentation
- project-doc-writer — README, setup guides, architecture docs
- code-doc-writer — docstrings, inline comments, API docs

Development
- test-generator — unit tests for functions/classes/modules
- claude-api — Claude API / Anthropic SDK apps
- skill-generator — create new skills

Design & planning
- grill-me — stress-test a plan via interview
- grill-with-docs — stress-test against existing domain model

Configuration
- update-config — hooks, permissions, settings.json
- keybindings-help — customize keyboard shortcuts
- init — initialize CLAUDE.md
- review — review a pull request
- loop — recurring tasks on an interval
- schedule — scheduled remote agents (cron)
- fewer-permission-prompts — reduce permission prompts
```



```text
# in claude code, enter this on the commandline
claude mcp list

● Based on what's visible in my session context, the active MCP servers are:
  - claude.ai Gmail — email read/send
  - claude.ai Google Calendar — calendar access
  - claude.ai Google Drive — Drive access
  - claude.ai Higgsfield — image/video generation
  - plugin:context7:context7 — library/framework docs lookup
  - sequential-thinking — structured reasoning tool
```
