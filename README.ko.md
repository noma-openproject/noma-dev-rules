# noma-dev-rules

**AI 에이전트 프로젝트 운영 규칙을 플러그인으로.** 도구 현황, 보안, 프론트 파이프라인, 브라우저 자동화, 서브에이전트 계약, headless lane, 유지보수 리뷰 — 전부 자동 트리거.

[English](README.md)

**v2.2.0 — 2026-04-18 업데이트:** Opus 4.7 (04-16), Claude Design (04-17), Codex 04-17 대규모, 유지보수 리뷰 스킬 신규, 정량 임계값 체계, 학습 루프.

## 이게 뭔가요

코딩 에이전트에게 **운영 감각**을 주는 스킬 기반 플러그인입니다. 코드를 어떻게 짜는가가 아니라, *어떤 도구를 쓰고, 이번 주 뭐가 깨졌고, 보안은 어떻게 지키고, 언제 fallback하는가, 기존 코드가 건강한가*를 알려줍니다.

[Superpowers](https://github.com/obra/superpowers)(코딩 규율)와 [gstack](https://github.com/garrytan/gstack)(역할 기반 스프린트)와 함께 사용 가능. 충돌 없음 — 레이어가 다릅니다.

```
[Ruflo/claude-mem]   → 실행 엔진 / 메모리 (선택)
[Superpowers]       → 코딩 규율 (brainstorm, TDD, 계획, 리뷰)
[noma-dev-rules]    → 운영 규칙 (도구 선택, 보안, 디자인, 유지보수, known issues)
```

## 빠른 시작

### Claude Code

```bash
/plugin marketplace add noma-openproject/noma-dev-rules
/plugin install noma-dev-rules
```

### Codex

```
Fetch and follow instructions from https://raw.githubusercontent.com/noma-openproject/noma-dev-rules/main/.codex/INSTALL.md
```

### 수동 설치

```bash
git clone https://github.com/noma-openproject/noma-dev-rules.git ~/.claude/plugins/noma-dev-rules
```

## 스킬 (자동 트리거)

| 스킬 | 트리거 조건 |
|---|---|
| **tool-landscape** | 도구 선택, 모델 비교, known issues 확인, quota 문제 |
| **security-ops** | 외부 콘텐츠 처리, 플러그인 설치, auth 이슈, 권한 설정 |
| **frontend-pipeline** | UI 구축, 디자인 구현, CSS/React 작업 (Stitch/Figma/v0/Claude Design/paper.design) |
| **browser-automation** | E2E 테스트, 시각 검증, 사이트 스크래핑, Computer Use |
| **subagent-ops** | 서브에이전트 spawn, 작업 위임, 병렬 실행 |
| **headless-lane** | CI 세팅, scheduled task, 비대화형 자동화 |
| **project-interview** | 모호하거나 불완전한 지시를 받았을 때 |
| **upstream-tracker** | 외부 프레임워크(Superpowers/gstack/Hermes) 변경 추적 |
| **maintainability** ⭐ v2.2.0 | 주요 merge 전, Phase 전환, 월 1회 감사 — `/ultrareview` + 정량 임계값 + 학습 루프 |

## 에이전트

| 에이전트 | 역할 | 권한 |
|---|---|---|
| **browser-verifier** | 스크린샷 + console + network 검증 | 읽기 전용 |
| **security-reviewer** | 외부 위협, 환각 API, 자격 증명 노출 검토 | 읽기 전용 |
| **design-auditor** | AI 느낌 체크, 디자인 시스템 준수 검토 | 읽기 전용 |

## Hooks

| Hook | 이벤트 | 목적 |
|---|---|---|
| **auth-preflight** | SessionStart | 장시간 세션 전 auth 상태 확인 |
| **browser-cleanup** | Stop | 고아 Chrome/Chromium 프로세스 정리 |

## 주간 스냅샷에 뭐가 있나

`tool-landscape` 스킬은 매주 갱신되는 스냅샷을 포함합니다:
- **이번 주 변경사항** (엄격한 7~10일 창)
- **알려진 이슈 & workaround** (심각도 포함)
- **모델 비교** (Gemini / GPT-5.4 / Claude Opus 4.6/4.7)
- **가격** (Antigravity / Cursor / Claude Code / Codex / Claude Design)
- **한국/Windows 주의사항**

## v2.2.0 주요 변경

- **Opus 4.7 대응** — xhigh effort level, task budgets, 새 토크나이저 1.0~1.35x, burn rate 2.4~2.6x 경고
- **`/ultrareview` 통합** — Claude Code 신규 슬래시 명령 활용
- **정량 임계값 체계** — 파일 1200줄, CC 15/25, lint 0, 커버리지 70%
- **학습 루프** — troubleshootings → feedback → CLAUDE.md 자동 주입 4단계
- **작업 디렉토리 구조** — orders/plans/working/report/feedback/troubleshootings 6폴더
- **Claude Design** (04-17) — 프론트 파이프라인 Stage 2c로 편입
- **Codex macOS Computer Use** — 보안 규칙에 2플랫폼 확장
- **Routines** — 월 1회 `/ultrareview` 자동화 가능

## 전체 레퍼런스 문서

`docs/` 폴더에 운영 규칙 전문(~2,000줄), 도구 스냅샷(~400줄), Antigravity 프론트 정책(~330줄)이 있습니다. 스킬이 필요할 때 자동 참조하므로 직접 읽지 않아도 됩니다.

## 호환성

| 플랫폼 | 상태 |
|---|---|
| Claude Code | ✅ 플러그인 마켓플레이스 |
| Codex | ✅ 수동 설치 |
| Cursor | ✅ 플러그인 마켓플레이스 |
| Claude.ai | ⚠️ docs/를 프로젝트 지식으로 사용 |
| Gemini CLI | 🔜 예정 |

## 라이선스

MIT
