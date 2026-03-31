#!/bin/bash
# browser-cleanup.sh — Stop hook
# 세션 종료 시 남아있는 Chrome/Chromium 프로세스를 정리합니다.
#
# 사용법: hooks/browser-cleanup.sh
# Hook 설정: Stop 이벤트에 연결

echo "🧹 Browser cleanup..."

# Chrome Helper 프로세스 정리 (macOS)
if pgrep -f "Chrome Helper" > /dev/null 2>&1; then
    pkill -f "Chrome Helper" 2>/dev/null
    echo "✅ Chrome Helper processes cleaned"
fi

# Chromium 프로세스 정리 (Linux)
if pgrep -f "chromium" > /dev/null 2>&1; then
    pkill -f "chromium --headless" 2>/dev/null
    echo "✅ Headless Chromium processes cleaned"
fi

# Playwright 서버 정리
if pgrep -f "playwright" > /dev/null 2>&1; then
    pkill -f "playwright" 2>/dev/null
    echo "✅ Playwright processes cleaned"
fi

echo "🧹 Browser cleanup complete."
