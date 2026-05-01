---
name: headless-lane
description: Rules for headless and CI/CD automation with coding agents. Use when setting up CI pipelines, scheduled tasks, automated workflows, permission profiles, workspace trust, using --bare flag, codex exec, cursor-agent --print, or when the user mentions CI, automation, headless, cron, scheduled, pipeline, or non-interactive execution. Enforces thin lane separation, explicit trust gates, agent run ledgers, and execution path parity testing.
---

# Headless Lane — CI/자동화 thin lane 규칙 (v2.4.0)

## Interactive Rich Lane vs Headless Thin Lane

| 경로 | 용도 | 특징 |
|---|---|---|
| **Rich Lane** | 로컬 개발, 탐색, 디버깅 | hooks, LSP, 플러그인, 스킬, 메모리 전부 ON |
| **Thin Lane** | CI, scheduled task, single-shot | `--bare -p` (Claude Code) / `codex exec` (Codex) / `cursor-agent --print`. 최소 실행면 |

## 원칙

- headless 작업은 기본적으로 **thin lane 우선**
- 플러그인/스킬 제어는 **선언형 설정 파일**로 (UI click-flow 의존 금지)
- interactive 통과 ≠ headless 통과 → **execution path parity 테스트 필수**
- 특히 localhost binding, Playwright, child process, integration suite는 `codex exec` 별도 검증
- workspace trust 전에는 `.env`, project config, MCP server, shell allowlist 로드 금지
- permission profile, cwd, network allowlist, write scope를 실행 전에 명시
- run ledger 없이 장시간 headless task를 시작하지 않는다

## Declarative Control Plane

- Claude Code: `settings.json`의 `source: 'settings'`, `managed-settings.d/`
- Codex: `.codex/config.toml`, `.codex/agents/*.toml`
- Cursor: SDK/API의 `agent`/`run` 객체, `cursor-agent --print`
- Gemini CLI: workspace trust + secure `.env` loading + fail-closed restricted rules
- 플러그인/에이전트/스킬의 원천은 항상 **git-tracked 파일**

## Workspace Trust Gate (v2.4.0 신규)

headless는 사람의 즉시 감시가 약하므로 interactive보다 더 엄격하게 시작한다.

신뢰 전 금지:
- `.env` 로드
- project config 자동 로드
- MCP server 자동 연결
- shell allowlist 자동 적용
- workspace 외부 쓰기
- 외부 텍스트에서 온 command 직접 실행

실패 정책:
- shell parsing 실패 → fail closed
- allowlist parsing 실패 → fail closed
- auth command 미검증 → warning만, hard fail 금지
- runtime별 auth 실패는 해당 runtime만 막고 다른 runtime hook을 막지 않음

## Permission Profile

시작 전 선언:

| 필드 | 예시 |
|---|---|
| `sandbox` | read-only / workspace-write / danger-full-access |
| `approval` | untrusted / on-request / never |
| `cwd` | repo root / isolated worktree |
| `network` | off / allowlist / unrestricted |
| `write_scope` | owned files / generated files / cache only |
| `runtime` | codex / claude / cursor / gemini / copilot |

`--full-auto`류 shortcut은 기본값이 아니다. 명시적 profile이 있을 때만 장시간 자동화에 사용한다.

## Auth Durability (장시간 실행)

- 실행 전 auth freshness preflight
- wave/milestone 체크포인트 (auto-commit/stash)
- auth/429 시 StopFailure hook으로 상태 덤프
- "rate limit" 표시 시 stale auth 먼저 의심
- 검증된 명령:
  - Codex: `codex login status`
  - Claude Code: `claude auth status`는 환경별 차이가 크므로 Codex hook에서는 hard fail 금지
- 확인된 로컬 상태도 report에 남긴다 (`codex --version`, `claude --version`)

## Headless Run Ledger

필수 기록:
- goal id 또는 task id
- command
- runtime/version
- permission profile
- workspace trust 상태
- run id 또는 CI job URL
- artifacts/logs
- verifier 결과
- cost/quota note
