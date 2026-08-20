#!/usr/bin/env python3

# place this in ~/.claude/hooks/block-dangerous-bash.py
import json, re, sys

DANGEROUS_PATTERNS = [
    r"\brm\s+.*-[a-z]*r[a-z]*f",
    r"sudo\s+rm",
    r"chmod\s+777",
    r"git\s+push\s+--force.*main",
    r"git push",
    r"git reset --hard",
    r"git clean -fd",
    r"git clean -f",
    r"git branch -D",
    r"git checkout \.",
    r"git restore \.",
    r"push --force",
    r"reset --hard",
]

input_data = json.load(sys.stdin)
if input_data.get("tool_name") == "Bash":
    command = input_data.get("tool_input", {}).get("command", "")
    for pattern in DANGEROUS_PATTERNS:
        if re.search(pattern, command, re.IGNORECASE):
            print(
                "BLOCKED: Command matches a dangerous command pattern.  The user has prevented you from doing this.",
                file=sys.stderr,
            )
            sys.exit(2)
sys.exit(0)
