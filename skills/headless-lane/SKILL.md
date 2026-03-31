---
name: headless-lane
description: Rules for headless and CI/CD automation with coding agents. Use when setting up CI pipelines, scheduled tasks, automated workflows, using --bare flag, codex exec, or when the user mentions CI, automation, headless, cron, scheduled, pipeline, or non-interactive execution. Enforces thin lane separation and execution path parity testing.
---

# Headless Lane — CI/자동화 thin lane 규칙

## Interactive Rich Lane vs Headless Thin Lane

| 경로 | 용도 | 특징 |
|---|---|---|
| **Rich Lane** | 로컬 개발, 탐색, 디버깅 | hooks, LSP, 플러그인, 스킬, 메모리 전부 ON |
| **Thin Lane** | CI, scheduled task, single-shot | `--bare -p` (Claude Code) / `codex exec` (Codex). 최소 실행면 |

## 원칙

- headless 작업은 기본적으로 **thin lane 우선**
- 플러그인/스킬 제어는 **선언형 설정 파일**로 (UI click-flow 의존 금지)
- interactive 통과 ≠ headless 통과 → **execution path parity 테스트 필수**
- 특히 localhost binding, Playwright, child process, integration suite는 `codex exec` 별도 검증

## Declarative Control Plane

- Claude Code: `settings.json`의 `source: 'settings'`, `managed-settings.d/`
- Codex: `.codex/config.toml`, `.codex/agents/*.toml`
- 플러그인/에이전트/스킬의 원천은 항상 **git-tracked 파일**

## Auth Durability (장시간 실행)

- 실행 전 auth freshness preflight
- wave/milestone 체크포인트 (auto-commit/stash)
- auth/429 시 StopFailure hook으로 상태 덤프
- "rate limit" 표시 시 stale auth 먼저 의심
