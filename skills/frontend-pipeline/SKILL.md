---
name: frontend-pipeline
description: Frontend design pipeline with visual source of truth, agent choreography, browser verification, and degradation mode. Use when building UI components, pages, layouts, implementing designs from Figma/Stitch/screenshots, doing frontend work, or when the user mentions design, CSS, React components, responsive layout, or visual verification. Ensures AI-generated UIs avoid generic aesthetics.
---

# Frontend Pipeline — 프론트 디자인 파이프라인

## 핵심 원칙

- **visual source of truth 없이 UI 구현 시작 금지** (Figma, Stitch, 스크린샷, 레퍼런스 URL)
- **one-shot 금지** — `route → section → component` 단위로 분할 구현
- **AI 느낌 배제** — 제너릭한 Inter 폰트, 보라색 그라디언트, 카드 중첩 기피
- 브라우저 검증 없이 완료 아님

## Agent Choreography

권장 순서: **planner → ui_builder → browser_verifier → a11y_reviewer**

| 역할 | 하는 일 | 권한 |
|---|---|---|
| planner | 섹션 경계, 파일 목록, acceptance criteria | 읽기 전용 |
| ui_builder | 선택된 섹션만 구현 | 코드 수정 |
| browser_verifier | 390/768/1440 viewport 스크린샷, 불일치 수집 | 읽기 전용 |
| a11y_reviewer | 시맨틱, focus, contrast, aria, 키보드 | 읽기 전용 |

## 브라우저 검증 종료 조건

전부 충족해야 완료:
- 390px, 768px, 1440px 스크린샷 캡처
- console error: 0
- core flow network 4xx/5xx: 0
- reference vs actual mismatch list 작성
- a11y quick pass: heading 순서, alt text, focus visible, contrast

## 모델 선택

| 단계 | 최적 모델 |
|---|---|
| 디자인 탐색/프로토타입 | Gemini |
| UI 구현 (HTML/CSS) | Gemini 또는 GPT-5.4 |
| 비즈니스 로직/API | Claude 또는 GPT-5.4 |
| 리팩터링 | Claude |
| 시각 검증 | Codex Playwright 또는 agent-browser |

## 디자인 소스 우선순위

1. Figma write beta (양방향 동기화, 복잡한 variant는 사람 preflight)
2. Stitch project (고충실도, 안정성 주의)
3. screenshot (가장 안정적)
4. reference URL (저작권 주의)

## Degradation Triggers

| 트리거 | 전환 경로 |
|---|---|
| quota 대기 20분 초과 | Figma + Codex/Claude Code |
| Stitch unavailable | Figma 또는 스크린샷 |
| context overload 2회 | 새 세션 |
| browser action 승인 3회+ 반복 | 수동 검증 |

## 디자인 변형 동시 생성 비교 (gstack + Anthropic Labs 이식)

- 하나의 디자인만 만들지 않고 **2-3개 변형을 동시 생성**
- 각 변형을 4가지 기준으로 평가: Design Quality > Originality > Craft > Functionality
- 브라우저에서 나란히 비교 후 선택
- 선택 이유를 기록 → 이후 디자인 결정의 맥락으로 축적 (taste memory)
- 선택 안 된 변형의 좋은 요소를 최종 버전에 부분 차용 가능

상세 정책은 reference/antigravity-policy.md 참조.
