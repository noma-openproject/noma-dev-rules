# 프로젝트 운영 지침 및 규칙 v2.4.0

> 최종 갱신일: 2026-05-01
> 이번 사이클 테마: **"지속 목표 + 관찰 가능한 에이전트 실행"**
> v2.3 상세 원칙은 `docs/project-operation-rules-v2.3.md`에 보존한다. 이 문서는 v2.4에서 새로 승격된 운영 불변식만 다룬다.

## 1. v2.4 핵심 불변식

### 1-1. Goal -> Plan -> Run -> Verify -> Report

큰 작업은 대화만으로 닫지 않는다.

| 단계 | 필수 산출물 |
|---|---|
| Goal | 목표, 성공 기준, 제약, 제외 범위 |
| Plan | 실행 단계, 소유 파일/영역, 권한 프로파일, 검증 방법 |
| Run | agent/run 상태, branch/PR, artifacts |
| Verify | 테스트, lint/typecheck, browser/debug/security verifier 결과 |
| Report | 변경 요약, 남은 위험, 다음 액션 |

완료 판정:
- report가 verify 결과와 연결되지 않으면 완료가 아니다.
- verifier가 read-only로 확인하지 않은 multi-agent 결과는 "구현됨"이지 "검증됨"이 아니다.

### 1-2. Agent Run Ledger

에이전트 실행은 작업 단위가 아니라 관찰 가능한 run 단위로 관리한다.

필수 필드:
- `agent`: 실행 주체
- `run`: session id, run id, branch, PR URL 중 하나 이상
- `status`: queued/running/blocked/verified/failed
- `scope`: 읽기/쓰기 범위와 owned files
- `permission_profile`: sandbox, approval policy, cwd, network allowlist
- `artifacts`: diff, logs, screenshots, reports
- `verifier_result`: tests/browser/security/review 결과
- `cost_limit_note`: 모델, thread cap, wait-time, quota window

### 1-3. Verifier 분리

사람 병목을 줄이려면 "내가 눈으로 확인"을 read-only verifier에게 넘겨야 한다.

| 역할 | 권한 | 산출물 |
|---|---|---|
| Scout | read-only | 사실 조사, 후보 파일, 리스크 |
| Mutator | write | diff, migration, implementation report |
| Verifier | read-only + test | test/browser/security 증거 |
| Checker | read-only + task list | 누락 task, follow-up task |

규칙:
- Mutator와 Verifier를 같은 agent로 두지 않는다.
- Verifier는 수정하지 않고 증거만 남긴다.
- 실패한 verifier 결과는 새 goal이 아니라 기존 run의 follow-up이다.

## 2. Permission Profile과 Trust Gate

### 2-1. Permission Profile 우선

자동화 전에 아래를 선언한다.

| 항목 | 예시 |
|---|---|
| sandbox | read-only / workspace-write / danger-full-access |
| approval | untrusted / on-request / never |
| cwd | repo root 또는 isolated worktree |
| network | off / allowlist / unrestricted |
| write scope | owned files, generated files, cache only |

`--full-auto`류 편의 옵션은 기본값이 아니다. 장기 headless run은 명시적 프로파일을 먼저 만든다.

### 2-2. Headless Workspace Trust

headless는 사람이 보고 있지 않으므로 interactive보다 더 엄격하다.

신뢰 전 금지:
- `.env` 로드
- project config 자동 로드
- MCP server 자동 연결
- shell allowlist 자동 적용
- workspace 외부 쓰기

실패 정책:
- shell parsing 실패는 fail closed
- auth command가 검증되지 않았으면 warning만 출력하고 hard fail 금지
- 외부 텍스트 기반 command는 재구성 전 실행 금지

## 3. Runtime별 적용

### 3-1. Codex

- persisted `/goal`이 있는 환경에서는 goal을 장기 작업의 single source로 둔다.
- MultiAgentV2 사용 시 thread cap, wait-time, depth를 plan에 쓴다.
- plugin-bundled hooks는 설치 상태와 활성화 상태를 분리한다.
- Codex auth preflight는 검증된 `codex login status`를 사용한다.

### 3-2. Claude Code

- PR URL로 resume 가능한 session은 run ledger에 PR URL을 남긴다.
- OAuth/Bedrock/Vertex 오류는 auth/session preflight에 넣는다.
- subagent 생성 시 model routing을 명시한다.
- local Claude auth 실패는 Codex hook을 막지 않는다.

### 3-3. Cursor

- durable `agent`와 per-prompt `run`을 분리한다.
- streaming/reconnect 가능 run은 terminal state를 report에 남긴다.
- archive/delete lifecycle은 retention policy로 다룬다.

### 3-4. GitHub Copilot

- cloud agent는 issue/PR 중심 비동기 run으로 취급한다.
- Debugger agent 흐름을 버그 작업 기본형으로 둔다: reproduce -> instrument -> diagnose -> targeted fix.
- usage limit approaching 경고가 있으면 parallel workflow와 고 multiplier 모델을 줄인다.

### 3-5. Gemini CLI

- workspace trust 전 `.env`와 config를 읽지 않는다.
- YOLO/allowlist parsing 실패는 fail closed로 처리한다.

## 4. 기존 v2.3 원칙의 위치

아래 원칙은 유지하지만 v2.4 불변식 아래에서 사용한다.

- Advisor Pattern: 단순 fan-out보다 먼저 고려.
- Spec-Driven Development: Goal/Plan 산출물의 상위 워크플로우.
- Orchestrator + Checker: Run/Verify 분리의 구체 패턴.
- MCP STDIO 완화책: Trust Gate와 Security Ops의 기본 방어선.
- AGENTS.md single source: Goal/Plan/Run 규칙을 프로젝트별로 고정하는 위치.

## 5. Plugin Updates 반영

`plugin-updates`는 다음을 추적 대상으로 유지한다.

- `noma-dev-rules`: 이번 v2.4 source refresh와 local Codex wrapper 보존.
- `andrej-karpathy-skills`: 단일 `karpathy-guidelines` 스킬로 노출, Noma와 함께 업데이트 상태 점검.

Codex hook 직접 연결은 별도 검증 전까지 보류한다. 특히 `auth-preflight.sh`는 런타임별 safe-degrade policy만 제공한다.

## 변경 이력

| 날짜 | 변경 |
|---|---|
| 2026-05-01 | v2.4 운영 불변식 신설: goal/run/report, agent run ledger, verifier 분리, permission profile, workspace trust, cost/quota guard. |
