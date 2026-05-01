---
name: tool-landscape
description: Provides current AI development tool status, known issues, workarounds, model comparisons, pricing, quota, and agent runtime changes. Use when selecting tools, comparing models, checking known issues, asking about Codex/Claude Code/Cursor/Copilot/Gemini CLI/Windsurf/Antigravity/Figma/Stitch status, quota problems, rate limits, permission profiles, agent run ledgers, Advisor Tool pricing, or when the user mentions tool selection, model routing, headless automation, Composer 2, SWE-1.5, or hallucination rates. Always check this before recommending any tool or model.
---

# Tool Landscape — 도구 현황 스냅샷 (v2.4.0)

현재 AI 개발 도구의 상태, 알려진 이슈, workaround를 제공한다.

## 핵심 원칙

- 도구를 추천하기 전에 반드시 이 스킬의 known issues를 확인한다
- 별점표보다 **failure mode + workaround**가 더 중요하다
- "최근 3일", "이번 주"(7일), "최근 30일"을 분리해서 판단한다
- 빠르게 변하는 정보이므로 reference/snapshot.md에서 최신 상태를 확인한다
- 사람 병목을 줄이는 기능인지 판단할 때는 "agent/run 상태가 관찰 가능한가", "권한/비용이 선언 가능한가", "검증 산출물이 남는가"를 먼저 본다

## 도구 선택 시 확인 순서

1. `docs/tool-landscape-snapshot-2026-05-01.md`가 있으면 섹션 0 (최근 3일 Delta) 먼저 확인
2. reference/snapshot.md 섹션 0 (이번 주 Known Issues) 확인
3. 해당 도구의 현재 상태가 "해결됨" / "진행중" / "workaround 있음" 확인
4. 가격/quota/usage window 현황 확인
5. agent run ledger와 verifier 산출물을 남길 수 있는지 확인
6. 모델별 강약점 비교 후 추천

## 핵심 런타임 선택 원칙 (v2.4.0 업데이트)

- **지속 목표 + 로컬 구현**: Codex 0.128.0+ (`/goal`, permission profiles, MultiAgentV2 controls). 로컬 CLI가 뒤처질 수 있으므로 `codex --version`을 먼저 확인
- **장시간 Claude 세션/원격 복구**: Claude Code 2.1.126+ (OAuth/session/retry 안정성, PR URL resume 검색)
- **프로그램 가능한 cloud/local agent**: Cursor SDK/API (`agent`와 `run` 분리, SSE streaming/reconnect)
- **IDE issue→PR 위임 + 디버거 verifier**: GitHub Copilot cloud/debugger agent
- **headless trust reference**: Gemini CLI v0.41 preview의 secure `.env` + workspace trust + fail-closed 규칙
- **로직·품질·리팩터·대규모 코드**: Claude Opus 계열 (재작업 최소, self-verification)
- **비용 절약 + 로직 중심**: **Advisor Pattern** (Sonnet/Haiku executor + Opus advisor) — Sonnet solo 대비 11.9% ↓ + 품질 ↑
- **IDE 통합 속도**: Cursor Composer 2 + Agents Window
- **최고 inference 속도**: Windsurf SWE-1.5 (Cerebras 950 tok/s) — 40+ IDE 지원 (JetBrains 포함)
- **Gemini Flash**: 무료, 비용 민감 경량 작업

## v2.4.0 새로 확인해야 할 도구들

- **Codex 0.128.0** (2026-04-30): `/goal`, permission profiles, plugin-bundled hooks, MultiAgentV2 controls
- **Claude Code 2.1.126** (2026-05-01): PDF `/context`, subagent creation `--model`, transcript compaction fix
- **Cursor SDK + Cloud Agents API** (2026-04-29): run-scoped streaming/status/cancel/lifecycle
- **Gemini CLI v0.41 preview** (2026-04-28): workspace trust in headless, secure `.env`, fail-closed restricted rules
- **Copilot Visual Studio April update** (2026-04-30): cloud agent from IDE, user-level custom agents, Debugger agent

## 🚨 2026-05-01 긴급 사항 요약

1. **Agent run은 ledger 없이 시작하지 않는다** — run id/status/artifacts/verifier 결과 필요
2. **Headless trust gate** — trust 전 `.env`, config, MCP, shell allowlist 로드 금지
3. **Permission profiles 우선** — `--full-auto`류 shortcut보다 task-scoped profile
4. **Parallel agent는 quota guard 필요** — thread cap, wait-time, usage window, fallback model 선언
5. **MCP STDIO 결함 완화책 유지** — app-level defense 필수

## 상세 정보

전체 도구 현황, 가격 비교, 플랫폼별 스킬 카탈로그는 reference/snapshot.md 참조. 본 프로젝트의 최신 파일: `docs/tool-landscape-snapshot-2026-05-01.md`. 이전 상세 파일: `docs/tool-landscape-snapshot-2026-04-24.md`.
