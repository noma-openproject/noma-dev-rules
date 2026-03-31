---
name: browser-automation
description: Three-tier browser automation framework with Playwright, agent-browser, and Scrapling. Use when running E2E tests, visual verification, scraping reference sites, extracting site structure, or when the user mentions Playwright, browser testing, screenshots, web scraping, site analysis, or DESIGN.md generation from existing sites. Enforces Verify/Operate/Scrape modes and completion artifacts.
---

# Browser Automation — 3계층 도구 체계

## 3가지 도구의 보완 관계

| 계층 | 도구 | 성격 |
|---|---|---|
| **정밀 자동화** | Playwright | 확정된 셀렉터 기반, CI/CD |
| **AI 시각 조작** | agent-browser (Vercel Labs) | AI가 "보고" 판단하며 조작 |
| **구조 추출** | Scrapling (+ MCP 서버) | 적응형 사이트 구조 이해 |

대체가 아니라 보완. Playwright는 "정밀 수술 도구", agent-browser는 "AI 눈 달린 로봇 팔", Scrapling은 "사이트 해부학자".

## 용도별 선택

| 용도 | 도구 |
|---|---|
| CI/CD E2E 테스트 | Playwright |
| AI 에이전트 시각 검증 (라운드트립) | agent-browser |
| 레퍼런스 사이트 구조 추출 → DESIGN.md | Scrapling MCP |
| 경쟁사 UI 분석 | Scrapling + agent-browser |
| 데이터 수집 (가격/기능 모니터링) | Scrapling Spider |

## 3가지 운영 모드

| 모드 | 용도 | 권한 |
|---|---|---|
| **Verify** (기본) | 스크린샷, console, network 수집 | 읽기 전용 |
| **Operate** | 폼 입력, 클릭, 네비게이션 | 제한적 쓰기 |
| **Scrape** | 사이트 구조/데이터 추출 | 읽기 전용 + 외부 네트워크 |

## 실행 규칙

- 대상: localhost / staging / test account만. production은 수동 승인 필수
- 1 run = 1 isolated browser context
- 1 loop당 최대 action: 30 (Playwright) / 50 (agent-browser)
- 승인 3회 반복 → 수동 검증 전환
- 세션 종료 시 browser subtree 정리 확인

## Headed Mode + 쿠키 Import (gstack 원칙 이식)

- **headed 모드**: 실제 Chrome 창을 띄워서 AI 조작을 눈으로 확인 가능 — 디버깅과 신뢰 구축에 유용
- **쿠키 import**: 실제 브라우저(Chrome, Arc, Brave, Edge)에서 쿠키를 가져와 인증된 페이지 테스트
- **handoff 패턴**: CAPTCHA/MFA/auth wall → AI가 멈추면 사람에게 브라우저 전달 → 해결 후 AI가 재개
- 3회 연속 실패 시 자동으로 handoff 제안

## 완료 산출물 (없으면 완료 아님)

- screenshot (390 / 768 / 1440 viewport)
- console error summary (0이 목표)
- failed network request summary (4xx/5xx 0이 목표)
- changed files list
- reference vs actual mismatch list

## 시각 회귀 테스트 (VRT) 원칙

스크린샷을 찍는 것만으로는 부족하다 — **이전 버전과 픽셀 단위 비교**가 핵심.

- **baseline**: 승인된 기준 스크린샷을 리포에 저장
- **비교**: PR마다 현재 렌더 결과를 baseline과 비교 (Playwright `toHaveScreenshot` 등)
- **threshold**: 0.1~0.5% 픽셀 차이를 보수적 시작점으로
- **수락(accept)**: 의도된 변경이면 새 baseline으로 갱신, 커밋에 기록
- **비결정성 제거**: 웹폰트 고정, 애니메이션/트랜지션 OFF, 날짜/랜덤값 고정
- Storybook 스토리 = 테스트 케이스. 스토리를 추가할수록 VRT 커버리지가 자연스럽게 증가
