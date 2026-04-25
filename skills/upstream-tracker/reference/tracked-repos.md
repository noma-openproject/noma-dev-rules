# Tracked Repositories — 추적 현황

> 마지막 확인: 2026-04-24

## Superpowers (obra/superpowers)

- **스타**: **121K** (04-18 시점, 피크 성장률 2,000/day)
- **2026-01 Anthropic 공식 플러그인 마켓플레이스 편입**
- **이식한 원칙**: TDD Iron Law, git worktree 격리
- **다음 확인 시 주의**: brainstorm/subagent-driven-development 스킬 변경, 새 스킬 추가

## GSD (TÂCHES/gsd) ⭐ v2.3.0 업데이트

- **최신 버전**: **v1.34.0**
- **스타**: **48.4K** (2026-04 Augment 보고)
- **12개 runtime 지원** (Claude Code, Codex, OpenCode, Gemini CLI, Cursor, Windsurf, Cline, Augment, Trae, Qwen Code 등)
- **v1.34.0 신규**: 4 canonical gate types (Pre-flight / Revision / Escalation / Abort)
- **이식한 원칙**: Wave-based parallel execution, plan-checker + verifier 서브에이전트, atomic commit per task, requirements traceability
- **다음 확인 시 주의**: gate 타입 확장, runtime 추가

## Ruflo (ruvnet/ruflo)

- **최신 버전**: v3.5.65 (npm: claude-flow@alpha)
- **스타**: 31.3K
- **성격**: 멀티에이전트 스웜 오케스트레이션. Claude Code + Codex 듀얼 모드. MCP 기반 87+ 도구
- **특징**: hive-mind (queen/worker), HNSW 벡터 메모리, 9개 RL 알고리즘, SWE-bench 84.8%
- **다음 확인 시 주의**: 스웜 토폴로지 변경, MCP 도구 추가, 메모리 시스템 변경

## gstack (garrytan/gstack)

- **스타**: **70-71K** (2026-04 기준)
- **이식한 원칙**: CEO 리프레이밍, cross-model review, 파괴적 명령 안전장치, 디자인 변형 비교, 회고+메트릭, headed Chrome+쿠키, "Boil the Lake" 원칙
- **다음 확인 시 주의**: /browse 개선, 새 스킬 추가, Conductor 통합 변경

## Hermes Agent (Nous Research) ⭐ v2.3.0 신규 추적

- **최신 버전**: **v0.8.0** (2026-04-08)
- **스타**: 38,700+
- **성격**: 자기 개선 메모리 루프. OpenClaw 대비 토큰 절반. 장기 fatigue 완화
- **특징**: Telegram 연동, 클라우드 VM 상주 에이전트, agentskills.io 표준 준수
- **이식 검토**: 자기 개선 loop 패턴만 (code 그대로 이식하지 않음)
- **다음 확인 시 주의**: v0.9, memory persistence 변경

## Paperclip (paperclipai) ⭐ v2.3.0 신규 추적

- **스타**: 43,000+
- **성격**: 멀티 에이전트 company OS. 20-30 Claude Code 세션 동시 관리
- **특징**: org chart 구조, immutable audit log, agent 월간 예산 + 자동 pause, 역할/보고라인
- **이식 검토**: 현재 noma-dev-rules는 **단일 프로젝트 규율** 스코프 — Paperclip은 **조직 레벨**이라 스코프 다름. 참고만

## Compound Engineering (Every Inc.) ⭐ v2.3.0 신규 추적

- **스타**: 11K
- **성격**: 실패 로그 중심 — 같은 실수 반복 방지
- **핵심 명령**: `/ce:compound`
- **패턴**: Explorer 4 + Critic 1 (Ultraplan 3+1과 유사)
- **이식 검토**: 우리 "규칙 위반 학습 루프"(섹션 5-7)와 철학 일치. 구체 패턴 참고

## claude-code-spec-workflow (Pimzino) ⭐ v2.3.0 신규 추적

- **성격**: Requirements → Design → Tasks → Implementation 4단계 자동화
- **핵심 명령**: `/spec-create`, `/spec-execute`
- **특징**: Hierarchical context management (60-80% 토큰 감소), Bug 4단계 워크플로우, 웹 대시보드
- **이식 검토**: 우리 SDD 섹션(9-6)에 원칙만 이식. 플러그인 자체는 보완재 (compatible_with에 추가)

## OpenCode (Anomaly Innovations) ⭐ v2.3.0 신규 추적

- **스타**: 112K+
- **성격**: MIT 오픈소스, 75+ LLM 지원
- **특징**: SQLite 세션 저장, multi-agent orchestration, Plan Agent (read-only)
- **Go plan**: $10/mo (최저 유료 옵션)
- **이식 검토**: 크로스 모델 호환성 원칙만
