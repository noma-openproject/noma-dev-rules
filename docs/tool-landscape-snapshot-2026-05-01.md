# AI 개발 도구 현황 스냅샷

> 최종 갱신일: 2026-05-01
> 리서치 창: 2026-04-28 ~ 2026-05-01
> 이번 사이클 테마: 사람의 반복 지시, 상시 감시, auth 복구, 비용 감시를 agent/runtime 제어면으로 이동한다.

## 0. 이번 3일 Delta

### Critical

| 날짜 | 도구 | 변경 | 운영 함의 |
|---|---|---|---|
| 04-30 | Codex 0.128.0 | persisted `/goal`, app-server API, runtime continuation, TUI create/pause/resume/clear | 큰 작업은 목표를 한 번만 주고 run ledger로 이어간다. 사람이 매 turn 목표를 재주입하지 않게 한다. |
| 04-30 | Codex 0.128.0 | explicit permission profiles, sandbox CLI profile selection, cwd controls | `--full-auto` 대신 task별 permission profile을 선언한다. |
| 04-30 | Codex 0.128.0 | plugin-bundled hooks, hook enablement state, external-agent config import | hook은 "설치됨"과 "활성화됨"을 분리 기록한다. 검증 안 된 hook 자동 연결 금지. |
| 04-30 | Codex 0.128.0 | MultiAgentV2 thread caps, wait-time controls, root/subagent hints | parallel fan-out 전 max thread, wait-time, depth를 문서화한다. |
| 04-28~05-01 | Claude Code 2.1.122~2.1.126 | OAuth/Bedrock/Vertex 안정성, `/resume` PR URL 검색, remote-control retry/error 개선, subagent creation model option | auth와 session recovery는 장시간 작업의 preflight로 승격한다. |
| 04-29 | Cursor SDK/API | durable `agent` + per-prompt `run`, SSE streaming/reconnect, archive/delete lifecycle | agent 실행을 관찰 가능한 run 단위로 관리한다. |
| 04-28 | Gemini CLI preview | secure `.env` loading, workspace trust in headless mode, restricted rules fail closed | headless는 explicit trust 없이는 project env/config를 읽지 않는다. |
| 04-30 | GitHub Copilot VS update | cloud agent from IDE, user-level custom agents, Debugger agent, extra skill discovery paths | issue 기반 cloud agent와 debugger verifier 흐름을 bug workflow에 반영한다. |

## 1. 사람 병목을 줄이는 v2.4 운영 패턴

### 1-1. Persistent Goal

한 번 합의한 목표는 대화 문장에만 두지 말고 goal artifact로 남긴다.

필수 필드:
- `goal_id`
- `source_request`
- `success_criteria`
- `constraints`
- `current_run`
- `resume_hint`

완료 조건:
- goal이 report에 닫히고, verify 결과가 연결되어야 한다.

### 1-2. Agent Run Ledger

모든 agent run은 아래 최소 필드를 남긴다.

| 필드 | 예시 |
|---|---|
| `agent` | `codex-worker`, `browser-verifier`, `cursor-cloud-agent` |
| `run` | CLI session id, cloud run id, PR URL, branch |
| `status` | queued/running/blocked/verified/failed |
| `scope` | 읽기/쓰기 범위, owned files |
| `permission_profile` | sandbox, approval, cwd, network |
| `artifacts` | diff, screenshots, logs, report |
| `verifier_result` | tests, browser, security, review |
| `cost_limit_note` | quota window, model multiplier, thread cap |

### 1-3. Verifier 분리

구현자는 고치고, 검증자는 읽고 증거를 모은다.

- `Mutator`: worktree/branch를 소유하고 파일을 수정한다.
- `Verifier`: 테스트, screenshot, console/network, security scan만 수행한다.
- `Checker`: task list에서 완료 표시된 항목만 역검증하고 follow-up task를 만든다.

### 1-4. Trust Gate

headless 실행은 사람의 감시가 약한 경로이므로 interactive보다 더 보수적으로 둔다.

기본값:
- workspace trust 확인 전 `.env` 로드 금지
- project config, MCP server, shell allowlist 로드 금지
- shell parsing 실패 시 fail closed
- network는 allowlist 기반
- auth preflight는 runtime별 safe-degrade

### 1-5. Cost/Quota Guard

parallel agent는 비용과 rate limit을 빨리 소모한다.

시작 전 선언:
- 모델/effort
- 예상 thread 수
- max wait-time
- usage window
- fallback model
- 중단 조건

## 2. 도구별 메모

### Codex 0.128.0

운영 채택:
- `/goal`을 장기 작업의 single source로 사용.
- permission profiles를 task type별로 나눈다: `read-only`, `workspace-write`, `headless-ci`, `release`.
- MultiAgentV2의 thread cap과 wait-time을 task plan에 적는다.
- plugin-bundled hooks는 설치/활성/검증 상태를 분리한다.

주의:
- 로컬 CLI가 최신 릴리스보다 뒤처질 수 있다. 실행 전 `codex --version`을 기록한다.
- Codex auth 확인 명령은 `codex login status`로 검증됨. `codex auth status`는 이 환경에서 유효하지 않았다.

### Claude Code 2.1.122~2.1.126

운영 채택:
- PR URL로 session resume 검색 가능성을 run ledger에 연결한다.
- OAuth/Bedrock/Vertex 오류는 auth/session preflight 항목으로 둔다.
- remote-control retry와 error reason은 long-running automation failure report에 기록한다.
- subagent 생성 시 model routing을 명시한다.

주의:
- 이 환경의 로컬 `claude`는 2.1.39였고 `claude auth status`가 API key 오류를 냈다. Codex hook에 Claude auth를 hard fail로 묶지 않는다.

### Cursor SDK / Cloud Agents API

운영 채택:
- Cursor의 `agent`와 `run` 분리를 일반 패턴으로 사용한다.
- streaming/reconnect가 가능한 run은 terminal state를 report에 남긴다.
- archive/delete lifecycle을 run retention policy에 반영한다.

### GitHub Copilot

운영 채택:
- cloud agent는 issue/PR 중심 비동기 run으로 취급한다.
- Debugger agent 흐름을 버그 작업의 기본 skeleton으로 둔다: reproduce -> instrument -> diagnose -> targeted fix.
- usage limit이 approaching이면 parallel workflow와 고 multiplier 모델을 줄인다.

### Gemini CLI

운영 채택:
- workspace trust와 secure `.env` loading을 headless lane의 일반 원칙으로 이식한다.
- YOLO/allowlist 파싱 실패 시 fail closed를 기본값으로 둔다.

## 3. Upstream Tracker Delta

| 대상 | 3일 내 관찰 | 반영 |
|---|---|---|
| Superpowers | new-harness PR에 session transcript 요구 | agent run ledger에 transcript/artifact 필드 추가 |
| gstack | plan-ceo-review Step 0 smoke 강화 | 큰 작업 전 Step 0 intent/smoke gate 추가 |
| Ruflo | federation/IoT plugin alpha 빠른 릴리스 | federation은 추적만, core 규칙에는 audit/fail-closed만 이식 |
| OpenCode | 빠른 patch/release cadence | local CLI version drift 기록 |
| Andrej Karpathy Skills | plugin-updates에 추적 대상으로 등록됨 | Noma와 함께 업데이트 상태 확인 대상 |

## 4. 출처

- OpenAI Codex 0.128.0 release: https://github.com/openai/codex/releases
- Claude Code changelog: https://code.claude.com/docs/en/changelog
- Cursor changelog: https://cursor.com/changelog
- Gemini CLI releases: https://github.com/google-gemini/gemini-cli/releases
- GitHub Copilot in Visual Studio April update: https://github.blog/changelog/2026-04-30-github-copilot-in-visual-studio-april-update/
- GitHub Copilot Individual plan changes: https://github.blog/news-insights/company-news/changes-to-github-copilot-individual-plans/
- GitHub Copilot usage-based billing announcement: https://github.blog/news-insights/company-news/github-copilot-is-moving-to-usage-based-billing/

## 변경 이력

| 날짜 | 변경 |
|---|---|
| 2026-05-01 | v2.4 스냅샷 신설. Persistent goal, agent/run ledger, verifier 분리, workspace trust, cost/quota guard 추가. |
