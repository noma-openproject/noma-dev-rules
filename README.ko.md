# noma-dev-rules (한국어)

**v2.3.0** — "사람(나)이라는 병목 줄이기 + 기획 완성도" 테마

AI 에이전트 주도 개발을 위한 Claude Code 플러그인. 솔로 개발자와 소규모 팀이 **병목이 되지 않고**, 에이전트가 기획대로 기능을 완성하게 만들기 위한 운영 규칙.

## v2.3.0 업데이트 (2026-04-24)

**지난 7일간(2026-04-18 ~ 2026-04-24) 17건 업데이트:**

### Critical 5
- **GPT-5.5 출시** (2026-04-23) — Codex 기본 추천. 모델 비교표 갱신. **환각률 86% 경고** (Opus 4.7은 36%)
- **Claude Advisor Tool** (2026-04-09, 공식 베타) — 한 API 호출 안에서 Executor + Advisor 패턴. Sonnet+Opus advisor: solo 대비 11.9% 저렴, SWE-bench Multilingual +2.7pp
- **🚨 MCP STDIO 설계 결함** — 10 CVE, 20만 취약 인스턴스. Anthropic 패치 거부. **각 팀이 애플리케이션 레벨에서 방어** — 6가지 필수 완화책
- **Claude Code 폭풍 업데이트 v2.1.92~v2.1.118** — `/ultraplan` (클라우드 3+1 패턴), `/recap`, `/usage`, Prompt caching 1H TTL, vim visual mode
- **AGENTS.md 표준 재작성** — Linux Foundation AAIF. AGENTS.md = single source of truth. Princeton 연구: 런타임 -28.6%, 토큰 -16.6%

### High 5
- Cursor 3 + Composer 2 + Windsurf Wave 13 SWE-1.5 (모델 비교표)
- Codex GPT-5.5 통합
- **Spec-Driven Development 섹션 신설** (Requirements → Design → Tasks → Implementation, 계층적 컨텍스트 관리)
- **Orchestrator + Checker 패턴** (Claude Code Task System, 자기검증)
- Routines 세부 (트리거 3종, GitHub 이벤트 13+, 일일 한도)

### Medium 7
- Opus 4.7 AWS Bedrock 출시 (2026-04-20)
- 생태계 성장: Superpowers 121K, Hermes v0.8.0, Paperclip 43K, CE 11K
- Computer Use 3플랫폼 확장 (+ Cowork)
- **서브에이전트 고급 필드**: `skills:` preload, `memory:` (user/project/local/none), `color:`, permissionMode 상속
- Windsurf Cascade 하네스 세부
- OpenAI Astral 인수 (uv+ruff, 2026-03-19)
- 한국어/일본어 (CJK) 수정 (v2.1.84+)

## 핵심 원칙

- **탐색 → 계획 → 실행** 프로토콜. 여러 접근법 비교 시 `/ultraplan`
- **TDD Iron Law**: 실패하는 테스트 없이 프로덕션 코드 금지
- **완료 = 테스트 통과 + lint clean + 타입체크 clean**
- **"안 된다"로 끝내지 말기** — 우회안, 축소판, 다음 검증 단계 필수
- **세 단계 신뢰도 태그**: 확실 / 추측 / 확인필요
- **한국어 존댓말** 기본 소통 언어

## 9개 스킬, 3개 에이전트, 2개 훅

### 스킬
- `tool-landscape` — 모델 비교, 가격, known issues
- `security-ops` — 외부 컨텐츠 처리, MCP STDIO 완화책
- `frontend-pipeline` — 디자인 파이프라인 (Claude Design, Figma MCP 등)
- `browser-automation` — 브라우저 4계층 (Playwright → agent-browser → Scrapling → Computer Use)
- `subagent-ops` — Advisor 패턴, Orchestrator+Checker, 에이전트 memory/skills/color
- `headless-lane` — thin lane (--bare -p, codex exec)
- `project-interview` — 모호한 요청 구조화 인터뷰
- `upstream-tracker` — Superpowers, GSD, Hermes, Paperclip, CE 등 추적
- `maintainability` — `/ultrareview` + 정량 임계값

### 에이전트
- `browser-verifier` — 스크린샷 + 반응형 체크
- `security-reviewer` — MCP/권한/시크릿
- `design-auditor` — 제너릭 AI 미감 탐지기

### 훅
- `auth-preflight.sh` — stale auth 감지
- `browser-cleanup.sh` — Chrome 정리

## 호환 프레임워크

- [Superpowers](https://github.com/obra/superpowers) — TDD, 계획
- [gstack](https://github.com/garrytan/gstack) — YC 스타일 다역할 거버넌스
- [claude-code-spec-workflow](https://github.com/Pimzino/claude-code-spec-workflow) — SDD (Pimzino)

## 문서

전체 레퍼런스:
- `docs/project-operation-rules-v2.3.md` — 불변 원칙 (~2660줄)
- `docs/tool-landscape-snapshot-2026-04-24.md` — 주 1회 갱신 도구 현황
- `docs/antigravity-frontend-policy.md` — Antigravity 전용 정책

## 설치

```bash
/plugin marketplace add noma-openproject/noma-dev-rules
/plugin install noma-dev-rules
```

## 라이선스

MIT
