#!/usr/bin/env bash
#
# NAME
#   <script-name>.sh
#
# SYNOPSIS
#   <script-name>.sh [-h] [-v] -a VALUE [-b] [--] POSITIONAL [POSITIONAL ...]
#
# DESCRIPTION
#   <one paragraph: what the script does and why>
#
# OPTIONS
#   -a VALUE   <what it does, required/optional, default>
#   -b         <boolean flag meaning>
#   -v         Enable verbose logging.
#   -h         Show this help and exit.
#
# POSITIONAL ARGUMENTS
#   POSITIONAL   <what each one means, e.g. input files>
#
# EXIT CODES
#   0   success
#   1   usage error (bad/missing arguments)
#   2   <script-specific failure, e.g. input file not found>
#   3   <script-specific failure, e.g. downstream command failed>
#
# EXAMPLES
#   ./<script-name>.sh -a foo file1 file2
#   ./<script-name>.sh -a foo -b -- -file-that-looks-like-an-option

set -euo pipefail

PROG="$(basename "$0")"
readonly PROG

usage() {
  cat <<EOF
Usage: ${PROG} [-h] [-v] -a VALUE [-b] [--] POSITIONAL [POSITIONAL ...]

<one-line description>

Options:
  -a VALUE   <description> (required)
  -b         <description>
  -v         Verbose logging
  -h         Show this help and exit

Examples:
  ${PROG} -a foo file1 file2
EOF
}

log()  { printf '[%s] %s\n' "$PROG" "$*" >&2; }
die()  { log "ERROR: $1"; exit "${2:-1}"; }

verbose=0
aval=""
bflag=0

# --- cleanup on exit/error: remove temp files, kill background jobs, etc. ---
tmpdir="$(mktemp -d)"
cleanup() {
  local exit_code=$?
  rm -rf "$tmpdir"
  exit "$exit_code"
}
trap cleanup EXIT
trap 'die "interrupted" 130' INT TERM

# --- option parsing ---
while getopts ":a:bvh" opt; do
  case "$opt" in
    a) aval="$OPTARG" ;;
    b) bflag=1 ;;
    v) verbose=1 ;;
    h) usage; exit 0 ;;
    :) die "option -$OPTARG requires an argument" ;;
    \?) die "invalid option: -$OPTARG" ;;
  esac
done
shift $((OPTIND - 1))

# --- validate required inputs before doing any work ---
[[ -n "$aval" ]] || { usage; die "-a VALUE is required"; }
(( $# >= 1 )) || { usage; die "at least one positional argument is required"; }

for f in "$@"; do
  [[ -e "$f" ]] || die "input not found: $f" 2
done

(( verbose )) && log "aval=$aval bflag=$bflag args: $*"

# --- retry helper for flaky operations (network, transient IO) ---
retry() {
  local -i attempts=3 delay=1 n=0
  until "$@"; do
    n+=1
    (( n >= attempts )) && die "command failed after ${attempts} attempts: $*" 3
    log "attempt ${n} failed, retrying in ${delay}s: $*"
    sleep "$delay"
    delay=$(( delay * 2 ))
  done
}

# --- main logic goes here ---
# retry curl -fsS "https://example.com" -o "$tmpdir/out"

exit 0
