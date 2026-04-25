---
name: tool-landscape
description: Provides current AI development tool status, known issues, workarounds, model comparisons, and pricing. Use when selecting tools, comparing models, checking known issues, asking about GPT-5.5/Claude Opus 4.7/Cursor/Windsurf/Codex/Antigravity/Figma/Stitch status, quota problems, rate limits, Advisor Tool pricing, or when the user mentions tool selection, model routing, Composer 2, SWE-1.5, or hallucination rates. Always check this before recommending any tool or model.
---

# Tool Landscape — 도구 현황 스냅샷 (v2.3.0)

현재 AI 개발 도구의 상태, 알려진 이슈, workaround를 제공한다.

## 핵심 원칙

- 도구를 추천하기 전에 반드시 이 스킬의 known issues를 확인한다
- 별점표보다 **failure mode + workaround**가 더 중요하다
- "이번 주"(7일)와 "최근 30일"을 분리해서 판단한다
- 빠르게 변하는 정보이므로 reference/snapshot.md에서 최신 상태를 확인한다

## 도구 선택 시 확인 순서

1. reference/snapshot.md 섹션 0 (이번 주 Known Issues) 먼저 확인
2. 해당 도구의 현재 상태가 "해결됨" / "진행중" / "workaround 있음" 확인
3. 가격/quota 현황 확인
4. 모델별 강약점 비교 후 추천

## 핵심 모델 선택 원칙 (v2.3.0 업데이트)

- **레퍼런스 → 빠른 구현**: Gemini 3.1 Pro (구현기, 판단기가 아님)
- **에이전트 자율 실행**: GPT-5.5 Codex (멀티스텝, 1M context, 출력 토큰 40% ↓) **단 환각률 86%** (Opus 4.7 36%의 2.4배) — 금융/의료 등 정확도 중시 도메인엔 부적합
- **로직·품질·리팩터·대규모 코드**: Claude Opus 4.7 (재작업 최소, 환각 최소, self-verification)
- **비용 절약 + 로직 중심**: **Advisor Pattern** (Sonnet/Haiku executor + Opus advisor) — Sonnet solo 대비 11.9% ↓ + 품질 ↑
- **IDE 통합 속도**: Cursor Composer 2 ($0.50/$2.50 per MTok, 200+ tok/s)
- **최고 inference 속도**: Windsurf SWE-1.5 (Cerebras 950 tok/s) — 40+ IDE 지원 (JetBrains 포함)
- **Gemini Flash**: 무료, 비용 민감 경량 작업

## v2.3.0 새로 확인해야 할 도구들

- **GPT-5.5** (2026-04-23 출시): $5/$30 API ("soon"), Codex 기본 추천, **환각률 86% 경고**
- **Claude Advisor Tool** (2026-04-09 베타): 공식 기능. API 레벨 확인됨. Claude Code `/advisor` 토글 v2.4.0+ **확인필요**
- **Cursor 3 + Composer 2** (2026-04-02): Agents Window, Cloud-to-local handoff
- **Windsurf Wave 13 + SWE-1.5**: 무료 병렬 에이전트. CVE-2026-30615 패치 확인 필수 (zero-click MCP 취약점)
- **Claude Code Routines**: 트리거 3종 / 13+ GitHub 이벤트 / Pro 5·Max 15·Team·Enterprise 25 per day / `claude/` prefix 브랜치 보안

## 🚨 2026-04-24 긴급 사항 요약

1. **GPT-5.5 출시** (04-23) — Codex 기본 추천. 환각률 주의
2. **MCP STDIO 결함** (04-15 공개) — 10 CVE, 200K 취약 인스턴스. Anthropic 패치 거부. 각 팀 애플리케이션 레벨 방어 필수 (섹션 14-3)
3. **Sonnet 4.5/4 1M 컨텍스트 베타 04-30 종료** — Sonnet 4.6/Opus 4.6으로 마이그레이션
4. **Sonnet 4 / Opus 4 06-15 retirement**

## 상세 정보

전체 도구 현황, 가격 비교, 플랫폼별 스킬 카탈로그는 reference/snapshot.md 참조. 본 프로젝트의 해당 파일: `docs/tool-landscape-snapshot-2026-04-24.md`.
