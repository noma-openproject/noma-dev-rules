# AI 개발 도구 현황 스냅샷

> 스냅샷 날짜: 2026-05-01
> 상세 문서: `docs/tool-landscape-snapshot-2026-05-01.md`
> 이전 상세 스냅샷: `docs/tool-landscape-snapshot-2026-04-24.md`

이 파일은 skill 로딩 시 빠르게 읽는 축약본이다. 긴 근거, 출처, 도구별 세부는 `docs/tool-landscape-snapshot-2026-05-01.md`를 우선 확인한다.

## 0. 최근 3일 Delta (2026-04-28~2026-05-01)

| 도구 | 핵심 변경 | Noma v2.4 반영 |
|---|---|---|
| Codex 0.128.0 | persisted `/goal`, permission profiles, plugin-bundled hooks, MultiAgentV2 thread caps/wait controls | Goal→Plan→Run→Verify→Report, permission profile, run ledger |
| Claude Code 2.1.122~2.1.126 | OAuth/Bedrock/Vertex 안정성, PR URL resume 검색, remote-control retry/error 개선, PDF `/context`, subagent `--model` | auth/session preflight, model routing, reportable recovery |
| Cursor SDK/API | durable `agent`, per-prompt `run`, SSE streaming/reconnect, archive/delete lifecycle | agent/run 분리와 terminal state 기록 |
| Gemini CLI preview | secure `.env`, workspace trust in headless, fail-closed restricted rules | headless trust gate |
| GitHub Copilot | cloud agent from IDE, Debugger agent, usage limits/AI Credits 방향 | issue/PR 기반 async run, cost/quota guard |

## 1. v2.4 선택 원칙

- 지속 작업: Codex `/goal` 또는 동등한 goal artifact를 우선한다.
- 비동기 agent: `agent`와 `run`을 분리하고 status/artifacts/verifier 결과를 남긴다.
- headless: workspace trust 전 `.env`, config, MCP, shell allowlist 로드 금지.
- 병렬 실행: thread cap, wait-time, model/effort, usage window를 먼저 선언.
- 검증: Mutator와 Verifier를 분리하고 verifier는 read-only 기본값을 유지.

## 2. Runtime별 빠른 판단

| Runtime | 잘 맞는 일 | 주의 |
|---|---|---|
| Codex | 로컬 repo 구현, 지속 goal, permission profile 기반 자동화 | 로컬 CLI가 최신 릴리스보다 뒤처질 수 있으므로 version drift 기록 |
| Claude Code | 장시간 세션, Advisor/Checker, PR URL resume 중심 워크플로우 | auth status 실패를 다른 runtime hook의 hard fail로 묶지 않음 |
| Cursor | SDK/API 기반 agent orchestration, cloud/local run streaming | run-scoped status와 cancellation을 report에 남김 |
| Copilot | issue/PR 기반 cloud agent, debugger verifier | usage limit과 model multiplier 확인 |
| Gemini CLI | headless trust와 fail-closed reference | trust 전 `.env` 로드 금지 원칙만 이식 |

## 3. Known Issues 유지

- MCP STDIO 설계 결함 완화책은 계속 유효하다: manifest-only execution, sandboxing, explicit opt-in, invocation monitoring, publisher allowlist.
- Playwright/browser automation은 interactive 통과 후에도 headless parity test가 필요하다.
- cloud/parallel agent는 비용과 quota를 빠르게 소모한다. "더 많은 agent"보다 "관찰 가능한 run + verifier"가 우선이다.

## 4. 출처

- OpenAI Codex releases: https://github.com/openai/codex/releases
- Claude Code changelog: https://code.claude.com/docs/en/changelog
- Cursor changelog: https://cursor.com/changelog
- Gemini CLI releases: https://github.com/google-gemini/gemini-cli/releases
- GitHub Copilot Visual Studio update: https://github.blog/changelog/2026-04-30-github-copilot-in-visual-studio-april-update/
- GitHub Copilot plan/usage update: https://github.blog/news-insights/company-news/changes-to-github-copilot-individual-plans/

## 변경 이력

| 날짜 | 변경 |
|---|---|
| 2026-05-01 | v2.4 축약 스냅샷으로 교체. 최근 3일 delta, run ledger, headless trust, cost/quota guard 반영. |
