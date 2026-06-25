# Claude Assisted LazyVim Debugging

## What I Asked Claude
**Claude Prompt:**
I'm currently using LazyVim for my coding.
Its working well form me but I minor problems with it and I wish to fix them.
My problem is that LazyVim is complicated and difficult to  isolate where the bugs might be.
Can Claude Code help me fix my problems?  How should I approach this problem using Claude code?
Can Claude Code experience / observe the status of LazyVim to help me?

**Claude's Response:**
Yes, Claude Code is well-suited for this.
Think of it like having a senior developer sitting at your terminal
— it can read your config files, run commands, observe output, and iterate.
Specifically relevant to LazyVim debugging:

* Claude Code runs in your terminal and can use all your CLI tools,
  meaning it can run `nvim --startuptime`, inspect `:checkhealth output`,
  read your `~/.config/nvim/` tree, and run `lazy.nvim` commands directly.
* **Practical approach**:
    1. Start Claude Code in your Neovim config directory (`cd ~/.config/nvim && claude`)
    1. Describe the symptom precisely — what triggers it, what you expect vs. what happens.
    1. Let it read your plugin specs and run diagnostic commands.
    1. It can propose minimal reproductions (disabling plugins one-by-one) and make targeted edits.
* **One limitation:**
  It can't directly observe a running Neovim instance's visual state — it can't "see" your screen.
  But it can inspect all the config, logs, and CLI output.
  So symptoms that manifest as terminal-observable errors
  (messages, startup logs, LSP logs) are much easier than pure visual glitches.

---

## LazyVim Diagnostic Sequence
Claude recommended diagnostic procedures.
Work top to bottom. Commit after each phase that makes changes.

### Phase 1: Baseline Measurement (no Claude Code yet)

1. Profile startup time and sort by slowest plugins:

   ```bash
   nvim --startuptime /tmp/nvim-startup.log +qa && sort -k2 -rn /tmp/nvim-startup.log | head -20
   ```

2. Inside nvim, run a full health check:

   ```
   :checkhealth
   ```

   Captures LSP, plugin manager, and dependency issues in one shot.

3. Surface recent plugin errors:

   ```bash
   nvim --headless "+Lazy log" +qa 2>&1 | head -50
   ```

> Save all three outputs to files — these are your "before" snapshots.

### Phase 2: Isolate Plugin Conflicts

4. Temporarily disable all custom plugin specs:

   ```bash
   mv ~/.config/nvim/lua/plugins ~/.config/nvim/lua/plugins.bak
   ```

   Launch nvim. If problems disappear, the conflict is in your custom plugins.

5. Re-enable specs one file at a time:

   ```bash
   # Move files back one at a time from plugins.bak/ to plugins/
   ```

   Relaunch nvim after each one until the problem reappears — classic binary search.

### Phase 3: Isolate Keybinding Collisions

6. Inside nvim, check what's bound to a specific key and which script set it:

   ```
   :map <key>
   ```

7. List all custom keybinding definitions:

   ```bash
   grep -r "keymap\|keys\s*=" ~/.config/nvim/lua/plugins/ | grep -v ".bak"
   ```

   Cross-reference against LazyVim defaults to spot collisions.

### Phase 4: Hand Everything to Claude Code

8. Start Claude Code in your config directory:

   ```bash
   cd ~/.config/nvim && claude
   ```

9. Share the outputs from steps 1–3 and note which plugin in step 5 triggered the conflict.

10. Claude Code reads your full config in context and proposes targeted fixes.

### Notes

* **Phases 1–3** are cheap information gathering that dramatically narrows the search space before Claude Code gets involved.
* You're doing the bisection manually; Claude Code then does the precise surgery.
* Keep `git` commits between each change so you can bisect further if something breaks.

---

## LazyVim Debugging Skill
I asked Claude to create CLaude Code SKILL.md file for me,
to be call `/lazyvim-debug`.

This has never been used/tested and will need refinement.

---
name: lazyvim-debug
description: >
  Use this skill whenever a user mentions LazyVim problems, Neovim issues, slow
  startup, plugin conflicts, broken keybindings, LSP errors, or anything related
  to debugging or fixing a LazyVim configuration. Trigger even for vague
  descriptions like "my nvim is broken" or "something's wrong with my neovim
  setup". This skill provides a structured diagnostic and repair workflow for
  LazyVim configs using Claude Code or manual terminal steps
---

# LazyVim Debugging Skill

A structured workflow for diagnosing and fixing LazyVim configuration problems.
Covers the three most common issue classes: startup performance, plugin conflicts,
and keybinding collisions.

---

## Step 0: Orient Before Acting

Before running any diagnostics, establish:

1. **Where is the config?** Default is `~/.config/nvim/`. Confirm with:

   ```bash
   ls ~/.config/nvim/lua/plugins/
   ```

2. **Is this a fresh LazyVim install or a customized one?** Ask the user if
   unclear — the diagnostic path differs.
3. **Is the config under git?** If not, recommend initializing it now:

   ```bash
   cd ~/.config/nvim && git init && git add -A && git commit -m "baseline before debugging"
   ```

   This is the safety net. Don't skip it.

---

## Step 1: Capture Baseline Snapshots

Run all three and save output. These are the "before" state.

### 1a. Startup profile

```bash
nvim --startuptime /tmp/nvim-startup.log +qa
sort -k2 -rn /tmp/nvim-startup.log | head -20
```

Look for any single plugin taking >50ms. Anything >100ms is a strong suspect.

### 1b. Health check

```bash
nvim -c ":checkhealth" -c "w /tmp/nvim-health.txt" -c "qa"
cat /tmp/nvim-health.txt
```

Flag any `ERROR` or `WARNING` lines — especially in `lazy`, `lsp`, and
`treesitter` sections.

### 1c. Plugin error log

```bash
nvim --headless "+Lazy log" +qa 2>&1 | head -60
```

Any stack traces here point directly at the offending plugin.

---

## Step 2: Isolate Plugin Conflicts (Binary Search)

If step 1 reveals errors or suspicious plugins, use this isolation protocol:

```bash
# Disable all custom plugins
mv ~/.config/nvim/lua/plugins ~/.config/nvim/lua/plugins.bak

# Launch nvim — if clean, the conflict is in your custom plugins
nvim
```

Re-enable plugins one file at a time:

```bash
# Move back a single spec file, relaunch, repeat
mv ~/.config/nvim/lua/plugins.bak/myplugin.lua ~/.config/nvim/lua/plugins/
nvim
```

Stop when the problem reappears. That file is the culprit.

**Common conflict patterns to look for inside the offending file:**
* Overriding a LazyVim default plugin's `opts` in a way that wipes LazyVim's
  defaults (use `opts = function(_, opts)` pattern, not `opts = {}`)
* Disabling a plugin that another depends on
* Duplicate plugin specs (same plugin declared in two files)

---

## Step 3: Diagnose Keybinding Collisions

### 3a. Check what's bound to a specific key (inside nvim)

```
:map <leader>x      " replace x with the key you're testing
:verbose map <key>  " shows which script last set this mapping
```

### 3b. Grep all custom key definitions

```bash
grep -rn "keymap\|keys\s*=\|vim\.keymap" ~/.config/nvim/lua/plugins/ \
  | grep -v ".bak" \
  | sort
```

### 3c. Check which-key for conflicts
Inside nvim: `<leader>` — if which-key is active, missing or broken keys will
often show as `[No Name]` or simply not appear.

**Common keybinding issues in LazyVim:**
* Defining `keys` in a plugin spec without checking LazyVim's existing bindings
  at <https://www.lazyvim.org/keymaps>
* Using `<leader>` mappings that shadow LazyVim's which-key groups
* Setting `vim.keymap.set` in `init.lua` that fires before plugin mappings load
  (use `VeryLazy` event or plugin `keys` table instead)

---

## Step 4: Performance Fixes

After startup profiling in Step 1a, apply these targeted fixes:

| Symptom | Fix |
|---|---|
| Plugin loads on startup unnecessarily | Add `event = "VeryLazy"` or `ft = "..."` to its spec |
| LSP slow to attach | Check mason-installed servers; disable unused ones |
| Treesitter slow | Limit `ensure_installed` to languages you actually use |
| General slowness after disabling plugins | Run startup profile again to re-baseline |

Lazy-loading pattern example:

```lua
{
  "some-plugin",
  event = "VeryLazy",   -- defer until after UI loads
  -- or:
  ft = { "python", "cpp" },  -- only load for specific filetypes
}
```

---

## Step 5: Hand Off to Claude Code

Once you've narrowed the problem to a specific file or symptom, Claude Code can
do the precise repair work.

```bash
cd ~/.config/nvim && claude
```

Suggested opening prompt:
> "I have a LazyVim config here. I've isolated a conflict to `lua/plugins/foo.lua`
> and my startup log shows `bar.nvim` taking 200ms. Read my full config and
> propose fixes for both issues."

Provide Claude Code with:
* Output of the startup log (step 1a)
* Output of `:checkhealth` (step 1b)
* The specific plugin file identified in step 2
* The keybinding grep output (step 3b)

---

## Reference: LazyVim Plugin Spec Patterns

### Safe opts override (preserves LazyVim defaults)

```lua
{
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- modify opts table in place; don't replace it
    opts.sections.lualine_c = { "filename" }
    return opts
  end,
}
```

### Unsafe opts override (wipes LazyVim defaults)

```lua
{
  "nvim-lualine/lualine.nvim",
  opts = {
    -- This replaces ALL of LazyVim's lualine config
    sections = { lualine_c = { "filename" } }
  },
}
```

### Correct event-based loading

```lua
{ "folke/todo-comments.nvim", event = "BufReadPost" }
```

---

## Quick Reference: Key Files in a LazyVim Config

```
~/.config/nvim/
├── init.lua                  -- entry point, usually just bootstraps lazy.nvim
├── lua/
│   ├── config/
│   │   ├── options.lua       -- vim options
│   │   ├── keymaps.lua       -- global keymaps (load order matters here)
│   │   └── autocmds.lua      -- autocommands
│   └── plugins/
│       └── *.lua             -- your custom plugin specs (one per file is best)
```

LazyVim's own defaults live inside the `LazyVim` plugin itself
(`~/.local/share/nvim/lazy/LazyVim/`). Read these to understand what you're
overriding.
