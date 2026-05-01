#!/bin/bash
# auth-preflight.sh — optional SessionStart hook
#
# v2.4 policy:
# - Check only runtimes that were explicitly selected or safely verified.
# - Do not let a Claude-specific auth failure block a Codex hook by default.
# - Report the runtime that failed and the exact command that was used.
#
# Usage:
#   hooks/auth-preflight.sh
#   NOMA_AUTH_RUNTIMES=codex hooks/auth-preflight.sh
#   NOMA_AUTH_RUNTIMES=codex,claude NOMA_AUTH_STRICT_CLAUDE=1 hooks/auth-preflight.sh
#
# Defaults:
#   NOMA_AUTH_RUNTIMES=codex
#   NOMA_AUTH_SOFT_FAIL=0
#   NOMA_AUTH_STRICT_CLAUDE=0

set -u

RUNTIMES="${NOMA_AUTH_RUNTIMES:-codex}"
SOFT_FAIL="${NOMA_AUTH_SOFT_FAIL:-0}"
STRICT_CLAUDE="${NOMA_AUTH_STRICT_CLAUDE:-0}"
FAILURES=0

echo "Auth preflight check..."

selected() {
    local runtime="$1"
    case ",${RUNTIMES}," in
        *",auto,"*) command -v "$runtime" >/dev/null 2>&1 ;;
        *",${runtime},"*) return 0 ;;
        *) return 1 ;;
    esac
}

record_failure() {
    local runtime="$1"
    local command_used="$2"
    local output="$3"
    local hard_fail="$4"

    echo "Auth issue detected for ${runtime}."
    echo "Command: ${command_used}"
    echo "${output}" | sed 's/^/  /'

    if [ "$SOFT_FAIL" = "1" ] || [ "$hard_fail" != "1" ]; then
        echo "Continuing because this runtime is configured as soft-fail."
        return 0
    fi

    FAILURES=$((FAILURES + 1))
}

check_codex() {
    if ! selected "codex"; then
        return 0
    fi
    if ! command -v codex >/dev/null 2>&1; then
        record_failure "codex" "command -v codex" "codex command not found" "1"
        return 0
    fi

    echo "Codex: $(codex --version 2>/dev/null || echo 'version unknown')"
    local output
    if output=$(codex login status 2>&1); then
        echo "Codex auth OK"
    else
        record_failure "codex" "codex login status" "$output" "1"
    fi
}

check_claude() {
    if ! selected "claude"; then
        return 0
    fi
    if ! command -v claude >/dev/null 2>&1; then
        record_failure "claude" "command -v claude" "claude command not found" "$STRICT_CLAUDE"
        return 0
    fi

    echo "Claude Code: $(claude --version 2>/dev/null || echo 'version unknown')"
    local output
    if output=$(claude auth status 2>&1); then
        echo "Claude Code auth OK"
    else
        record_failure "claude" "claude auth status" "$output" "$STRICT_CLAUDE"
    fi
}

check_codex
check_claude

if [ "$FAILURES" -gt 0 ]; then
    echo "Auth preflight failed for ${FAILURES} runtime(s)."
    exit 1
fi

echo "Auth preflight complete."
