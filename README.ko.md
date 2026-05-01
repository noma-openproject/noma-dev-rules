# noma-dev-rules (한국어)

**v2.4.0** — "지속 목표 + 관찰 가능한 에이전트 실행" 테마

AI 에이전트 주도 개발을 위한 Claude Code 플러그인. 솔로 개발자와 소규모 팀이 **병목이 되지 않고**, 에이전트가 기획대로 기능을 완성하게 만들기 위한 운영 규칙.

## v2.4.0 업데이트 (2026-05-01)

**최근 3일(2026-04-28 ~ 2026-05-01) 리서치 기반 전체 재정리:**

### Critical 5
- **Codex 0.128.0** — persisted `/goal`, app-server API, runtime continuation, explicit permission profiles, plugin-bundled hooks, MultiAgentV2 thread caps/wait controls. 큰 작업은 사람이 반복 지시하지 않아도 `goal → run → verify → report`로 이어지게 설계한다.
- **Claude Code 2.1.122~2.1.126** — OAuth/Bedrock/Vertex 안정성, `/resume` PR URL 검색, remote-control retry/error 표시, subagent/model 관련 개선. 장시간 실행 전 auth freshness와 session recovery를 필수 체크로 둔다.
- **Cursor SDK + Cloud Agents API** — durable `agent`와 per-prompt `run` 분리, SSE streaming/reconnect, archive/delete lifecycle. 에이전트 실행은 항상 run-scoped status와 terminal state를 남긴다.
- **Gemini CLI trust fixes** — headless mode에서 secure `.env` loading + workspace trust 강제, restricted rules 파싱 실패 시 fail closed. 모든 headless 자동화는 명시적 trust 없이는 config/env를 읽지 않는다.
- **Copilot agent economics** — 장시간/병렬 agent가 usage limit과 비용 구조를 흔든다는 공식 설명. parallel fan-out은 사전 예산/쿼터/모델 multiplier 선언 후 사용한다.

### High 5
- **Agent Run Ledger**: 모든 agent run은 `agent`, `run`, `status`, `branch/PR`, `artifacts`, `verifier_result`, `cost/limit note`를 기록.
- **Verifier-first delivery**: 구현 에이전트와 검증 에이전트 분리. browser/debug/security verifier는 기본 read-only.
- **권한 프로파일 명시화**: `full-auto`류 편의 옵션보다 task별 permission profile, sandbox, cwd, network allowlist를 먼저 선언.
- **Copilot Debugger agent 흐름 반영**: issue → reproduce → instrument → diagnose → targeted fix 제안. 버그 작업은 재현/계측 산출물 없이 완료 처리 금지.
- **upstream 운영 신호 반영**: Superpowers transcript 요구, gstack Step 0 smoke 강화, Ruflo federation 확장, OpenCode 빠른 release cadence는 audit trail과 smoke gate의 필요성을 강화.

### Medium 5
- local Codex CLI가 최신 릴리스보다 뒤처질 수 있으므로 `codex --version`과 release snapshot을 분리 기록.
- Claude/Codex/Gemini/Cursor auth preflight는 런타임별로 독립 실행. Claude 실패가 Codex hook을 막지 않게 설계.
- PDF/문서 context ingestion, transcript compaction, remote session recovery는 수동 복붙 병목을 줄이는 보조 수단으로만 사용.
- plugin-updates에는 `noma-dev-rules` v2.4와 `andrej-karpathy-skills` 추적 상태를 명시.
- 기존 v2.3의 Advisor, SDD, Orchestrator+Checker, MCP STDIO 완화책은 유지하되 v2.4의 run ledger와 trust gate 아래로 재정렬.

## 핵심 원칙

- **Goal → Plan → Run → Verify → Report** 프로토콜. 큰 작업은 실행 상태와 검증 산출물로 닫는다
- **TDD Iron Law**: 실패하는 테스트 없이 프로덕션 코드 금지
- **완료 = 테스트 통과 + lint clean + 타입체크 clean**
- **Agent Run Ledger 필수**: agent/run/status/branch·PR/artifacts/verifier result 기록
- **Headless trust gate**: 명시적 workspace trust 없이 `.env`, config, MCP, shell allowlist를 로드하지 않는다
- **"안 된다"로 끝내지 말기** — 우회안, 축소판, 다음 검증 단계 필수
- **세 단계 신뢰도 태그**: 확실 / 추측 / 확인필요
- **한국어 존댓말** 기본 소통 언어

## 9개 스킬, 3개 에이전트, 2개 훅

### 스킬
- `tool-landscape` — 최신 모델/agent 런타임, known issues, 비용/쿼터
- `security-ops` — 외부 컨텐츠 처리, MCP STDIO 완화책, headless trust
- `frontend-pipeline` — 디자인 파이프라인 (Claude Design, Figma MCP 등)
- `browser-automation` — 브라우저 4계층 (Playwright → agent-browser → Scrapling → Computer Use)
- `subagent-ops` — agent/run ledger, verifier 분리, MultiAgentV2/Cursor/Copilot 운영 계약
- `headless-lane` — thin lane, workspace trust, permission profile, parity test
- `project-interview` — 모호한 요청 구조화 인터뷰
- `upstream-tracker` — Superpowers, gstack, Ruflo, OpenCode, Cursor/Copilot agent 흐름 추적
- `maintainability` — `/ultrareview` + 정량 임계값

### 에이전트
- `browser-verifier` — 스크린샷 + 반응형 체크
- `security-reviewer` — MCP/권한/시크릿
- `design-auditor` — 제너릭 AI 미감 탐지기

### 훅
- `auth-preflight.sh` — 런타임별 safe-degrade auth 점검 (Codex hook 직접 연결 전 재검증)
- `browser-cleanup.sh` — Chrome 정리

## 호환 프레임워크

- [Superpowers](https://github.com/obra/superpowers) — TDD, 계획
- [gstack](https://github.com/garrytan/gstack) — YC 스타일 다역할 거버넌스
- [claude-code-spec-workflow](https://github.com/Pimzino/claude-code-spec-workflow) — SDD (Pimzino)
- [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) — LLM coding pitfalls를 줄이는 행동 가이드

## 문서

전체 레퍼런스:
- `docs/project-operation-rules-v2.4.md` — v2.4 운영 불변식
- `docs/project-operation-rules-v2.3.md` — v2.3 상세 원칙 아카이브
- `docs/tool-landscape-snapshot-2026-05-01.md` — 3일 이내 최신 도구 현황
- `docs/tool-landscape-snapshot-2026-04-24.md` — 주 1회 갱신 도구 현황
- `docs/antigravity-frontend-policy.md` — Antigravity 전용 정책

## 설치

```bash
/plugin marketplace add noma-openproject/noma-dev-rules
/plugin install noma-dev-rules
```

## 라이선스

MIT
