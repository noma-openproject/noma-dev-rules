---
name: upstream-tracker
description: Tracks upstream changes from Superpowers, oh-my-claudecode, and gstack repositories. Use when checking for upstream updates, during weekly snapshot refresh, or when the user asks about changes in external AI coding frameworks. Helps decide what to adopt and what to skip.
---

# Upstream Tracker — 외부 프레임워크 변경 추적

## 추적 대상

| 리포 | 역할 | 관심 영역 |
|---|---|---|
| [obra/superpowers](https://github.com/obra/superpowers) | 코딩 규율 | TDD, brainstorm, plan, subagent, review 스킬 변경 |
| [Yeachan-Heo/oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) | 실행 엔진 | 실행 모드, 모델 라우팅, rate limit 대기, 에이전트 추가 |
| [garrytan/gstack](https://github.com/garrytan/gstack) | 역할 기반 스프린트 | /office-hours, /qa, /browse, /design, /cso 변경 |

## 확인 방법

1. 각 리포의 **CHANGELOG.md** 또는 **Releases** 페이지 확인
2. 최근 1주일 커밋 중 skills/ 또는 agents/ 변경사항 필터링
3. 우리 문서에 영향 있는 변경만 추출

## 판단 기준

| 변경 유형 | 조치 |
|---|---|
| 우리가 이식한 원칙과 직접 관련 | 반영 검토 (예: Superpowers TDD 스킬 변경 → 9-5 업데이트) |
| 새로운 유용한 원칙 | 이식 검토 (원칙만, 코드는 원본에 위임) |
| 우리와 무관한 기능 | 스킵 |
| 호환성 깨지는 변경 | 즉시 known issues에 추가 |

## 주간 갱신 시 체크리스트

- [ ] Superpowers 최신 릴리스 확인 (현재: v5.0.6)
- [ ] OMC 최신 릴리스 확인 (현재: v3.10.3)
- [ ] gstack 최신 커밋 확인 (릴리스 없음, 커밋 기반)
- [ ] 우리 문서에 영향 있는 변경 요약
- [ ] 필요 시 스냅샷 또는 지침 업데이트

상세 추적 현황은 reference/tracked-repos.md 참조.
