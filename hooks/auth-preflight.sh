#!/bin/bash
# auth-preflight.sh — SessionStart hook
# 세션 시작 시 auth 상태를 확인하여 stale auth로 인한 장애를 예방합니다.
# 
# 사용법: hooks/auth-preflight.sh
# Hook 설정: SessionStart 이벤트에 연결

echo "🔐 Auth preflight check..."

# Claude Code auth 상태 확인
if command -v claude &> /dev/null; then
    AUTH_STATUS=$(claude auth status 2>&1)
    if echo "$AUTH_STATUS" | grep -qi "not logged in\|expired\|error"; then
        echo "⚠️  Auth issue detected. Run: claude auth logout && claude auth login"
        exit 1
    fi
    echo "✅ Claude Code auth OK"
fi

# Codex auth 상태 확인
if command -v codex &> /dev/null; then
    CODEX_STATUS=$(codex auth status 2>&1)
    if echo "$CODEX_STATUS" | grep -qi "not logged in\|expired\|error"; then
        echo "⚠️  Codex auth issue. Please re-authenticate."
        exit 1
    fi
    echo "✅ Codex auth OK"
fi

echo "🔐 Auth preflight complete."
