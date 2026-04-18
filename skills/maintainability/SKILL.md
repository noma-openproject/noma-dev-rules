---
name: maintainability
description: 기존 코드 유지보수 리뷰 — `/ultrareview` 결과에 정량 임계값과 반복 패턴 학습 루프를 덧붙여 architecture·security·performance·maintainability 4영역을 객관적으로 진단합니다. Dead code, God file(파일 집중도), 레이어 경계 위반, 중복 패턴을 찾고 troubleshootings→feedback 학습 루프로 연결합니다. 주요 merge 전, Phase 전환 전, 월 1회 정기 감사 시점에 사용하세요.
allowed-tools: [Read, Grep, Bash]
---

# Maintainability — 기존 코드 유지보수 리뷰

## 언제 쓰는가

- 주요 merge/PR 전 (기능 완료 시)
- Phase·마일스톤 전환 시
- 정기 감사 (월 1회 또는 스프린트 끝) — Routines로 자동화 가능
- 의심스러운 증상이 있을 때:
  - 같은 파일 수정 충돌 빈발
  - 신규 기능 추가 난이도 급증
  - 반복 버그 패턴
- 외부 감사·심사 대응

## 기본 도구: `/ultrareview` (Claude Code v2.1.111+, Opus 4.7)

Anthropic 공식 슬래시 명령. **4영역** 통합 분석:
1. **Architecture** — 레이어 경계, 모듈 결합도, 책임 분리
2. **Security** — 취약점, 입력 검증, 인젝션, 인증/권한
3. **Performance** — N+1, 불필요한 루프, 메모리 누수
4. **Maintainability** — god file, 복잡도, dead code, 중복

- Pro/Max: billing cycle당 3회 무료
- `max` effort로 실행
- 호출: `/ultrareview`

## 이 스킬이 추가하는 2개 레이어

`/ultrareview`는 영역을 커버하지만 정량 수치와 재발 방지는 주지 않는다. 이 스킬은 2개 레이어를 덧붙인다.

### Layer 1: 정량 임계값 체크

프로젝트 루트에서 다음을 측정해 `/ultrareview` 결과와 함께 보고한다.

**파일 줄 수:**
```bash
# 상위 20개 파일
find . -type f \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.py" -o -name "*.rs" -o -name "*.go" \) \
  -not -path "*/node_modules/*" -not -path "*/target/*" -not -path "*/dist/*" \
  -exec wc -l {} \; | sort -rn | head -20
```

기준:
- ≤ 1200 줄 → OK
- 1201~2000 → ⚠️ 경고 (역할 분리 검토)
- > 2000 → 🔴 즉시 대응 (기능 추가 중단 후 분해)

**Lint/Type warnings:**
- 언어별 실행 후 0 목표
- Rust: `cargo clippy --all-targets -- -D warnings`
- TS: `pnpm tsc --noEmit && pnpm eslint --max-warnings 0`
- Python: `ruff check . && mypy .`
- Go: `go vet ./... && staticcheck ./...`

**Cognitive Complexity:**
- Rust: `cargo clippy -W clippy::cognitive_complexity`
- TS/JS: `eslint-plugin-sonarjs` 규칙 활성화
- Python: `radon cc . -a -nb`
- Go: `gocognit -over 15 ./...`
- 기준: ≤15 목표 / 16~25 경고 / 26+ 즉시 대응

**테스트 커버리지:**
- 기준: ≥70% 목표 / 50~69% 경고 / <50% 즉시 대응
- 도메인·언어별 조정 가능 (UI 중심은 기준 하향 허용)

### Layer 2: 반복 패턴 학습 루프

리뷰에서 발견된 패턴은 `troubleshootings/` 또는 `feedback/`에 기록한다.

**1차 발견 → troubleshootings:**
```
troubleshootings/trouble_{YYYY-MM-DD}_{증상}.md

# 증상
<관찰된 것>

# 원인
<왜 그렇게 됐는지>

# 수정
<어떻게 고쳤는지>

# 재발 방지
<다음부터 피하는 방법>
```

**2~3회 누적 → feedback 승격:**
```
feedback/feedback_{주제}.md

# 규칙
<어떤 상황에서 무엇을 체크할지>

# 예시
- OK: <통과 케이스>
- NG: <실패 케이스>

# 관련 trouble
- troubleshootings/trouble_... (근거)
```

**자동 로드:**
- CLAUDE.md에 `@feedback/feedback_{주제}.md` 참조 추가
- 다음 세션부터 자동 로드 → 재발 방지

## 4개 카테고리 체크리스트

### A. Dead code

- [ ] Unused imports/exports (lint로 검출)
- [ ] Unreachable code (early return 이후, `if false` 등)
- [ ] 호출되지 않는 private 함수/메서드
- [ ] 주석 처리된 코드 블록 (TODO 없이 3개월 이상 방치)
- [ ] 제거된 feature flag 분기 잔재

**도구 예시:**
- Rust: `cargo clippy -- -W dead_code`
- TS: `ts-prune`, `unimported`
- Python: `vulture`
- Go: `deadcode`, `unused`

### B. 파일 집중도 (God File 감지)

- [ ] 파일 줄 수 > 1200 → 분해 검토
- [ ] 한 파일에 2개 이상의 독립 책임 혼재 여부
- [ ] 파일명이 내용의 70% 이상 설명하는가 (예: `utils.ts` 도메인 로직 혼재)
- [ ] Import 팬아웃 확인: 20개 이상 파일에서 참조 → 변경 시 신중 필요
  ```bash
  grep -rn "from.*대상파일명" . | wc -l
  ```

### C. 경계 위반 (레이어/모듈)

- [ ] UI 레이어가 DB나 외부 API 직접 호출 (도메인/서비스 우회)
- [ ] 순환 참조 (A → B → A)
- [ ] 잘못된 import 방향 (하위 레이어가 상위 import)
- [ ] 외부 라이브러리가 도메인에 침투 (ORM/프레임워크 타입이 도메인 엔티티에 섞임)

**도구 예시:**
- Rust: workspace crate 간 의존성 그래프 (`cargo-depgraph`)
- TS: `madge --circular ./src`
- Python: `pydeps`
- Go: `go mod graph`

### D. 중복 패턴

- [ ] 유사 로직이 3회 이상 반복 (DRY 위반)
- [ ] 복붙 분기 (동일 시그니처·동일 흐름, 상수만 다름)
- [ ] 같은 검증 규칙이 여러 곳 산재 (중앙화 필요)

**도구 예시:**
- 언어 중립: `jscpd` (JavaScript Copy/Paste Detector, 다언어 지원)
- Python: `pylint --disable=all --enable=duplicate-code`
- Rust: `cargo clippy -- -W clippy::similar_names`

## 보고 템플릿

```
[Maintainability Review — YYYY-MM-DD]

## /ultrareview 요약
- Architecture: N건 (심각도별)
- Security: N건 (심각도별)
- Performance: N건
- Maintainability: N건

## 정량 지표
| 지표 | 현재 | 목표 | 상태 |
|---|---|---|---|
| 파일 줄 수 초과 | N개 | 0 | 🔴/⚠️/✅ |
| CC 초과 함수 | N개 | 0 | |
| Lint warnings | N | 0 | |
| 타입체크 에러 | N | 0 | |
| 커버리지 | N% | 70% | |

## 긴급 대응 필요 (🔴)
- <파일/함수> <지표> <값>

## 경고 항목 (⚠️)
- <파일/함수> <지표> <값>

## 학습 루프 반영
- 신규 troubleshootings: <파일 목록>
- feedback 승격 후보: <주제 + 근거 trouble 수>
- CLAUDE.md 반영 제안: <있다면>

## 권장 다음 액션
1. <긴급 대응 항목 처리>
2. <경고 항목 완화 계획>
3. <학습 루프 업데이트>
```

## 운영 원칙

- `/ultrareview` 결과만으로 판단하지 않는다 — 정량 지표와 함께 봐야 객관적
- "즉시 대응 필요" 항목은 **기능 추가 중단** 후 먼저 해결
- 레거시 코드베이스: 기준 초과 허용하되 **악화 방지**가 1순위 (건드리는 파일은 점진 개선)
- 월 1회 정기 수행은 Routines (섹션 20-4)으로 자동화 가능
- 리뷰 보고서는 `report/maintainability_{YYYY-MM-DD}.md`로 저장

## 연결된 섹션

- 섹션 5-6 — 규칙 위반 학습 루프 (troubleshootings → feedback)
- 섹션 6-3 — 프로젝트 작업 디렉토리 구조 (report/, feedback/, troubleshootings/)
- 섹션 10-2 — 빌드 통과 루프 + 정량 임계값
- 섹션 12-2 — 기존 코드 유지보수 리뷰 (이 스킬의 본체)
- 섹션 20-4 — Routines 자동화
