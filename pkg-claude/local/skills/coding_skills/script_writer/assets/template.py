#!/usr/bin/env python3
"""<script-name>: <one paragraph on what the script does and why>.

Exit codes:
    0   success
    1   usage error (bad/missing arguments) -- raised by argparse itself
    2   <script-specific failure, e.g. input file not found>
    3   <script-specific failure, e.g. downstream call failed after retries>
"""

from __future__ import annotations

import argparse
import logging
import sys
import time
from pathlib import Path

log = logging.getLogger(Path(__file__).stem)


class ScriptError(Exception):
    """Raised for script-specific failures; caught once in main() to control exit codes."""

    def __init__(self, message: str, exit_code: int = 2) -> None:
        super().__init__(message)
        self.exit_code = exit_code


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        prog="<script-name>",
        description="<one paragraph: what the script does and why>",
        epilog=(
            "Examples:\n"
            "  %(prog)s -c 3 notes.txt\n"
            "  %(prog)s --verbose --count 5 notes.txt other.txt\n"
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "filenames",
        nargs="+",
        help="input file(s) to process",
    )
    parser.add_argument(
        "-c", "--count",
        type=int,
        default=1,
        help="<what this does> (default: %(default)s)",
    )
    parser.add_argument(
        "-v", "--verbose",
        action="store_true",
        help="enable verbose (DEBUG-level) logging",
    )
    return parser.parse_args(argv)


def retry(fn, *, attempts: int = 3, delay: float = 1.0):
    """Call fn() with exponential backoff; re-raise the last error if all attempts fail."""
    for attempt in range(1, attempts + 1):
        try:
            return fn()
        except Exception as exc:  # noqa: BLE001 -- intentionally broad: this is a generic retry wrapper
            if attempt == attempts:
                raise ScriptError(f"failed after {attempts} attempts: {exc}", exit_code=3) from exc
            log.warning("attempt %d failed (%s), retrying in %.1fs", attempt, exc, delay)
            time.sleep(delay)
            delay *= 2


def run(args: argparse.Namespace) -> None:
    """Main script logic. Raise ScriptError for expected, script-specific failures."""
    for name in args.filenames:
        path = Path(name)
        if not path.exists():
            raise ScriptError(f"input not found: {path}", exit_code=2)

    log.debug("count=%d filenames=%s", args.count, args.filenames)

    # --- main logic goes here ---
    # retry(lambda: some_flaky_call(path))


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    logging.basicConfig(
        level=logging.DEBUG if args.verbose else logging.INFO,
        format="%(name)s: %(levelname)s: %(message)s",
    )
    try:
        run(args)
    except ScriptError as exc:
        log.error(str(exc))
        return exc.exit_code
    except KeyboardInterrupt:
        log.error("interrupted")
        return 130
    return 0


if __name__ == "__main__":
    sys.exit(main())
