---
description: Verify Claude's most recent claims and edits against the actual codebase
allowed-tools: Read, Grep, Glob, Bash(git diff:*)
---

Re-examine everything you just told me in this conversation against what
actually exists in the codebase right now. Specifically:

1. For every file you claim to have edited, read it again and confirm the
   change is actually present and matches what you described.
2. For every claim about existing code (a function's behavior, a config
   value, an import, a dependency version), verify it against the real
   file rather than your memory of reading it earlier in the session.
3. Run `git diff` and compare the actual diff against what you described
   changing.
4. Report back plainly: which claims checked out, which didn't,
   and exactly what the discrepancy was for anything that failed.
   Do not soften or hedge a discrepancy you find, state it directly.

