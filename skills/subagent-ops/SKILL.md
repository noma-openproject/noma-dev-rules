---
name: subagent-ops
description: Subagent and async agent operation contracts for Claude Code, Codex, Cursor, and Copilot. Use when spawning subagents, delegating tasks, using parallel execution, configuring TOML custom agents, setting up advisor pattern, configuring agent memory or skills preload, implementing orchestrator+checker, recording agent run ledgers, routing verifier agents, or when the user mentions subagent, multi-agent, spawn, delegate, Scout, Mutator, Verifier, Explorer, Worker, advisor, agent memory, agent skills, Cursor Cloud Agents API, Copilot Debugger agent, MultiAgentV2, spawn_agents_on_csv, or agent_teams.
---

# Subagent Operations — 서브에이전트 운영 계약 (v2.4.0)

## 4단계 전략

**사람 병목 최소화를 위한 Level 구조:**

| Level | 전략 | 언제 사용 |
|---|---|---|
| 1 | 단순 역할 분리 (Scout/Mutator/Verifier) | 대부분의 일상 작업 |
| 2 | **Agent Run Ledger** (agent/run/status/artifacts/verifier) | 장시간 작업, 비동기 cloud agent |
| 3 | **Advisor Pattern** (한 API 요청 안 executor + advisor) | 반복 작업 + 가끔 판단 포인트 |
| 4 | **Orchestrator + Checker** (두 세션 공유 task list) | Merge 게이트, Phase 전환 |

## Spawn 규칙

- **explicit spawn only** — 자동 fan-out 금지
- max_depth: 기본 1 (서브에이전트가 서브에이전트를 만들지 않음)
- max_threads: 프로젝트별 상한 명시 (권장: 5 이하)
- wait-time 또는 timeout 명시. 무한 대기 금지
- spawn 시 owned files, permission profile, expected artifacts, verifier를 같이 지정
- critical path 바로 다음 작업은 직접 처리하고, sidecar 작업만 병렬 위임

## 3가지 역할

| 역할 | 권한 | 용도 |
|---|---|---|
| **Scout** (read-only) | 파일 읽기, 검색만 | 탐색, 코드 분석, 정보 수집 |
| **Mutator** | 파일 읽기/쓰기 | 코드 생성, 수정, 리팩터링 |
| **Verifier** (read-only) | 파일 읽기, 테스트 실행만 | 코드 리뷰, 테스트, 시각 검증 |

- Mutator는 반드시 worktree 분리
- Verifier는 코드 수정 권한 없음

## Agent Run Ledger (v2.4.0 신규)

모든 agent/subagent/cloud-agent 실행은 아래 형식으로 보고한다.

```yaml
agent: browser-verifier
run: session-or-run-id
status: verified
scope: "read-only, http://localhost:3000"
permission_profile: "read-only + browser"
branch_or_pr: null
artifacts:
  - screenshots/390.png
  - screenshots/1440.png
verifier_result: "console 0, failed requests 0, layout pass"
cost_limit_note: "1 verifier, 3 viewports, no parallel fan-out"
next_action: "ship"
```

규칙:
- cloud agent는 PR URL 또는 run id를 반드시 남긴다.
- 로컬 subagent는 changed files 또는 inspected files를 남긴다.
- `status=completed`와 `status=verified`를 구분한다.
- verifier 결과가 없으면 "구현 완료"까지만 말한다.

## Runtime별 운영 계약 (v2.4.0 신규)

| Runtime | 계약 |
|---|---|
| **Codex MultiAgentV2** | thread cap, wait-time, root/subagent hint, depth를 plan에 명시. `spawn` 결과에 실제 모델/권한/changed files를 기록 |
| **Cursor SDK/API** | durable `agent`와 per-prompt `run` 분리. streaming/reconnect terminal state를 report에 기록. archive/delete lifecycle은 retention policy에 맞춤 |
| **Copilot Cloud Agent** | issue/PR 중심 비동기 run. PR URL, branch, status, requested review를 ledger에 기록 |
| **Copilot Debugger Agent** | bug workflow 기본형: reproduce -> instrument -> diagnose -> targeted fix. 재현 증거 없으면 완료 아님 |
| **Claude Code** | subagent 생성 시 model routing 명시. PR URL resume 가능성, OAuth/session 상태를 run report에 남김 |

## Advisor Pattern (v2.3.0 신규, 2026-04-09 공식 베타)

**공식 벤치마크 (Anthropic 자체):**
- Sonnet 4.6 + Opus 4.7 advisor: SWE-bench Multilingual 74.8% (solo 72.1% 대비 +2.7pp), 비용 11.9% 저렴
- Haiku 4.5 + Opus 4.7 advisor: BrowseComp 41.2% (solo 19.7%의 2배), Sonnet solo 대비 85% 저렴

**API 호출:**
```python
response = client.beta.messages.create(
    model="claude-sonnet-4-6",          # Executor
    betas=["advisor-tool-2026-03-01"],
    tools=[{
        "type": "advisor_20260301",
        "name": "advisor",
        "model": "claude-opus-4-7"      # Advisor
    }],
    messages=[...]
)
```

**사용 조건:**
- ✅ 장시간 에이전트 (대부분 routine, 가끔 판단)
- ✅ 코드 리뷰, 브라우저 자동화, 멀티스텝 research
- ❌ Single-turn Q&A (executor가 호출 안 함 → 오버헤드만)
- ❌ Bedrock/Vertex (미지원, 확인필요), LiteLLM 프록시 (현재 broken)

**Claude Code `/advisor` 토글 v2.4.0+ — 확인필요** (한 커뮤니티 출처만 주장)

## Orchestrator + Checker Pattern (v2.3.0 신규)

**세션을 분리해서 자기편향 제거:**

```bash
# 공유 task list ID로 멀티 세션 조율
claude --task-list <shared-id>
```

- **세션 A (Orchestrator)**: 메인 구현. Task 생성/갱신/완료 마크
- **세션 B (Checker)**: 완료된 Task를 별도 세션에서 읽어 품질 검증. 누락 발견 시 follow-up Task 추가. Checker는 run ledger의 verifier_result를 갱신

**해결하는 3가지 문제:**
1. Agent Amnesia (세션 끊김)
2. Self-bias (자기 코드 "잘 짜였다" 편향)
3. Partial completion (10/12 구현 후 "완료")

**Checker 프롬프트 템플릿:**
```
Read the task list (id: <shared-id>). For each task marked 'completed':
1. Read the actual commit diff
2. Verify the implementation matches the task description
3. Run relevant tests
4. If anything is missing/wrong, add a follow-up task
Do NOT mark anything as completed yourself.
```

## 서브에이전트 고급 필드 (공식 문서, v2.3.0 반영)

### `skills:` — 스킬 preload
```yaml
---
name: api-developer
description: Implement API endpoints following team conventions
skills:
  - api-conventions
  - error-handling-patterns
---
```
- **전체 스킬 내용이 컨텍스트에 주입됨** (단순 invocable 아니라 already-loaded)
- 서브에이전트는 부모 세션의 스킬을 **상속하지 않음** — 명시적 나열 필요
- `disable-model-invocation: true` 스킬은 preload 불가

### `memory:` — 세션 간 학습
```yaml
---
name: code-reviewer
memory: project
---
```

| Scope | 위치 | 적용 범위 |
|---|---|---|
| `user` | `~/.claude/agent-memory/<n>/` | 모든 프로젝트 |
| `project` | `.claude/agent-memory/<n>/` (git 커밋 가능) | 해당 프로젝트 — **권장 기본값** |
| `local` | `.claude/agent-memory/<n>/` (.gitignore) | 해당 프로젝트, 개인 |
| `none` | 없음 | 영구성 없음 |

- 시스템 프롬프트에 MEMORY.md의 첫 200줄/25KB 자동 주입
- 초과 시 "curate하라"는 지시 자동 포함 → 에이전트가 스스로 정리
- Read/Write/Edit 도구 자동 활성화

### `color:` — UI 구분
```yaml
color: red
```
- 여러 서브에이전트 동시 실행 시 시각 구분

### `permissionMode` 상속 규칙 (중요)
- 부모 `bypassPermissions` / `acceptEdits` → 서브에이전트 **강제 상속** (override 불가)
- 부모 Auto mode → 서브에이전트도 Auto mode (자체 permissionMode 무시됨)
- `.git`, `.claude`, `.vscode`, `.idea`, `.husky` 쓰기는 여전히 승인 프롬프트 (단, `.claude/commands`, `.claude/agents`, `.claude/skills`는 예외)

## Agent Teams (실험 기능, v2.3.0 경고 업데이트)

**활성화:**
```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
```

- Lead agent가 공유 task list로 teammate 조율
- Teammate 간 직접 소통 (서브에이전트와 차이)
- 20~30초 spawn, 1분 내 결과 생산

**비용 경고:**
- 3 teammates = 단일 세션의 **3~4배 토큰**
- 의존성 강한 순차 작업에는 **과잉. 기본값으로 쓰지 말라**

**권장 사용처:**
- ✅ 경쟁 가설 디버깅
- ✅ 크로스 레이어 변경 (프론트/백/테스트 각 teammate)
- ✅ 대규모 분류/인벤토리
- ❌ 의존성 강한 순차 작업
- ❌ 같은 파일 동시 편집

## Ultraplan 3+1 (Cloud)

Claude Code v2.1.92~101 (2026-04-06~10):
- 3 parallel exploration agents + 1 critique agent
- `/ultraplan "<task>"` → 자동 cloud environment 생성 → 웹 에디터 리뷰 → 원격 실행 or 로컬 pull-back
- 커뮤니티 보고: 순차 14분 → 병렬 3분 40초 (확인필요)

## Codex 서브에이전트 GA 대응

| Codex 타입 | 우리 분류 |
|---|---|
| Explorer | Scout |
| Worker | Mutator |
| Default | 작업에 따라 |

- 커스텀 에이전트: `.codex/agents/*.toml`로 정의
- `spawn_agents_on_csv`: CSV 행당 Worker 1개, 결과 CSV export
- 서브에이전트 v2: 경로 주소 `/root/agent_a`
- v2.4 추가: MultiAgentV2 thread cap, wait-time, depth를 task plan에 기록
- persisted `/goal`이 있으면 subagent는 goal id를 result schema에 포함

## Result Schema

모든 서브에이전트는 반환 형식 사전 정의:
- 최소: `agent`, `run`, `status`, `summary`, `changed_files`, `issues_found`, `artifacts`, `verifier_result`, `cost_limit_note`, `next_action`
- 완료 조건을 spawn 시 명시

## Thread 소유권

- 같은 thread 동시 resume 금지 — fork
- 완료된 에이전트는 명시적 close
- stale agent: 1회 재시도, 이후 수동 개입
- cloud agent는 archive/delete lifecycle을 명시. 보존할 run artifact와 삭제할 ephemeral state를 구분

## 비용

- 경량 모델(Sonnet/Haiku/GPT-5.4 mini/Spark) 우선
- **Advisor Pattern 우선 고려** — 단순 분리보다 더 효과적
- model override 무시 이슈 → spawn 후 실제 모델 확인
- Agent Teams는 3~4x 토큰 — 명시적 정당화 없으면 피한다
- Copilot/Cursor/Codex parallel runs는 usage limit과 token multiplier를 빠르게 소모한다. 시작 전 thread cap, wait-time, fallback model을 선언한다
