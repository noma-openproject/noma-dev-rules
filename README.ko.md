# noma-dev-rules

**AI 에이전트 프로젝트 운영 규칙을 플러그인으로.** 도구 현황, 보안, 프론트 파이프라인, 브라우저 자동화, 서브에이전트 계약, headless lane — 전부 자동 트리거.

[English](README.md)

## 이게 뭔가요

코딩 에이전트에게 **운영 감각**을 주는 스킬 기반 플러그인입니다. 코드를 어떻게 짜는가가 아니라, *어떤 도구를 쓰고, 이번 주 뭐가 깨졌고, 보안은 어떻게 지키고, 언제 fallback하는가*를 알려줍니다.

[Superpowers](https://github.com/obra/superpowers)(코딩 규율)와 [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode)(실행 모드)와 함께 사용 가능. 충돌 없음 — 레이어가 다릅니다.

```
[oh-my-claudecode]  → 실행 엔진 (autopilot, 병렬, ecomode)
[Superpowers]       → 코딩 규율 (brainstorm, TDD, 계획, 리뷰)
[noma-dev-rules]    → 운영 규칙 (도구 선택, 보안, 디자인, known issues)
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
| **frontend-pipeline** | UI 구축, 디자인 구현, CSS/React 작업 |
| **browser-automation** | E2E 테스트, 시각 검증, 사이트 스크래핑 |
| **subagent-ops** | 서브에이전트 spawn, 작업 위임, 병렬 실행 |
| **headless-lane** | CI 세팅, scheduled task, 비대화형 자동화 |
| **project-interview** | 모호하거나 불완전한 지시를 받았을 때 |

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
- **이번 주 변경사항** (엄격한 7일 창)
- **알려진 이슈 & workaround** (심각도 포함)
- **모델 비교** (Gemini / GPT-5.4 / Claude Opus)
- **가격** (Antigravity / Cursor / Claude Code / Codex)
- **한국/Windows 주의사항**

## 전체 레퍼런스 문서

`docs/` 폴더에 운영 규칙 전문(~1,400줄), 도구 스냅샷(~290줄), Antigravity 프론트 정책(~330줄)이 있습니다. 스킬이 필요할 때 자동 참조하므로 직접 읽지 않아도 됩니다.

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
