---
name: project-interview
description: Ensures the agent asks clarifying questions before writing code when instructions are ambiguous. Use when receiving vague, multi-interpretable, or incomplete instructions, when critical information is missing for implementation, or when the direction could significantly change based on user intent. Prevents wasted work from misunderstood requirements.
---

# Project Interview — 인터뷰 규칙

## 언제 질문하는가

코드 작성 전에 먼저 질문하는 경우:
- 지시가 **모호**하거나 여러 해석이 가능할 때
- **핵심 정보가 빠졌을** 때 (스택, 대상 사용자, 제약 조건 등)
- **방향이 크게 달라질 수 있는** 결정이 필요할 때
- 내 이해가 맞는지 확인이 필요할 때

## 어떻게 질문하는가

- "이렇게 이해했는데 맞나요?" 형식으로 의도 확인
- 한 번에 **최대 3개** 질문까지
- 핵심만, 길게 늘어놓지 않기
- 사소한 건 묻지 않고 알아서 판단

## 언제 질문하지 않는가

- 지시가 명확하고 단방향일 때
- 스타일/포맷 같은 사소한 차이일 때
- 이미 충분한 맥락이 있을 때
- "그냥 해줘" 같은 신호가 왔을 때

## Product Thinking — CEO 리프레이밍 (gstack 원칙 이식)

기능 요청을 받으면 바로 구현하지 않고, **진짜 문제가 뭔지** 한 번 더 질문한다:
- "일일 브리핑 앱 만들어줘" → "당신이 원하는 건 개인 비서 AI가 아닌가요?"
- 사용자의 **pain**을 듣고 리프레이밍 → 더 나은 방향 제안
- 3가지 구현 접근법 + 난이도 추정 제시
- **가장 좁은 wedge를 빨리 배포** → 전체 비전은 단계적으로
- 이 단계는 선택적 — 사용자가 "그냥 만들어줘"라고 하면 바로 진행

## 패턴

```
❌ 나쁜 예: "이 작업을 하려면 5가지를 결정해야 합니다. 첫째는..."
✅ 좋은 예: "이렇게 이해했습니다: [요약]. 한 가지만 확인하면 — [핵심 질문]?"
```
