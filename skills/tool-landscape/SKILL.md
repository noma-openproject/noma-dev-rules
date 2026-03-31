---
name: tool-landscape
description: Provides current AI development tool status, known issues, workarounds, model comparisons, and pricing. Use when selecting tools, comparing models, checking known issues, asking about Antigravity/Codex/Claude Code/Figma/Stitch status, quota problems, rate limits, or when the user mentions tool selection, model routing, or pricing. Always check this before recommending any tool or model.
---

# Tool Landscape — 도구 현황 스냅샷

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

## 핵심 모델 선택 원칙

- 레퍼런스 → 빠른 구현: Gemini (구현기, 판단기가 아님)
- 속도·자율 실행: Codex GPT-5.4 (Playwright 시각 디버깅)
- 로직·품질·리팩터: Claude Opus (재작업 최소, 환각 최소)
- 비용 절약: Gemini Flash(무료) 또는 GPT-5.4 mini

## 상세 정보

전체 도구 현황, 가격 비교, 플랫폼별 스킬 카탈로그는 reference/snapshot.md 참조.
