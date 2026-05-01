---
name: upstream-tracker
description: Tracks upstream changes from Superpowers, gstack, Ruflo, OpenCode, Cursor/Copilot agent workflows, and Karpathy Skills. Use when checking for upstream updates, during weekly snapshot refresh, when updating plugin-updates tracking, or when the user asks about changes in external AI coding frameworks. Helps decide what to adopt, what to record as a run-ledger/trust rule, and what to skip.
---

# Upstream Tracker — 외부 프레임워크 변경 추적

## 추적 대상

| 리포 | 역할 | 관심 영역 |
|---|---|---|
| [obra/superpowers](https://github.com/obra/superpowers) | 코딩 규율 | TDD, brainstorm, plan, subagent, review 스킬 변경 |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 역할 기반 스프린트 | /office-hours, /qa, /browse, /design, /cso 변경 |
| [ruvnet/ruflo](https://github.com/ruvnet/ruflo) | 멀티에이전트 스웜 오케스트레이션 | hive-mind, MCP 도구, 스웜 토폴로지, 메모리 시스템 변경 |
| [sst/opencode](https://github.com/sst/opencode) | 오픈소스 agent runtime | 세션 저장, provider/tool 안정성, 빠른 release cadence |
| [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) | LLM coding pitfalls 가이드 | 행동 규칙, skill payload, plugin-updates 추적 상태 |
| Cursor / Copilot official changelogs | cloud/async agent 운영 | agent/run lifecycle, verifier/debugger, quota/usage guard |

## 확인 방법

1. 각 리포의 **CHANGELOG.md** 또는 **Releases** 페이지 확인
2. 최근 3일과 최근 1주일 커밋 중 skills/agents/hooks/runtime 변경사항 필터링
3. 우리 문서에 영향 있는 변경만 추출
4. 영향이 있으면 run ledger, verifier, trust gate, cost guard 중 어느 원칙으로 이식할지 분류

## 판단 기준

| 변경 유형 | 조치 |
|---|---|
| 우리가 이식한 원칙과 직접 관련 | 반영 검토 (예: Superpowers transcript 요구 → run ledger 업데이트) |
| 새로운 유용한 원칙 | 이식 검토 (원칙만, 코드는 원본에 위임) |
| 우리와 무관한 기능 | 스킵 |
| 호환성 깨지는 변경 | 즉시 known issues에 추가 |

## 주간 갱신 시 체크리스트

- [ ] Superpowers 최신 릴리스 확인 (현재: v5.0.6)
- [ ] gstack 최신 커밋 확인 (릴리스 없음, 커밋 기반)
- [ ] Ruflo 최신 버전 확인 (현재: v3.5.65, npm: claude-flow@alpha)
- [ ] OpenCode 최신 릴리스/패치 확인
- [ ] Andrej Karpathy Skills upstream HEAD와 plugin-updates tracked_head 확인
- [ ] Cursor/Copilot official changelog에서 agent/run lifecycle 또는 quota 변경 확인
- [ ] 우리 문서에 영향 있는 변경 요약
- [ ] 필요 시 스냅샷 또는 지침 업데이트

상세 추적 현황은 reference/tracked-repos.md 참조.
