# AI 개발 도구 현황 스냅샷

> **스냅샷 날짜: 2026-04-18**
> 이 문서는 빠르게 변하는 도구 현황, 모델 비교, 가격, quota, 기능 상태를 담는 별도 문서입니다.
> 프로젝트 운영 지침(v2.2)의 원칙은 그대로 유지하면서, 이 문서만 주기적으로 갱신합니다.
> **갱신 주기: 최소 주 1회** (또는 주요 릴리스 발생 시 즉시)

---

## 0. 이번 주 Delta & Known Issues (2026-04-10~04-18)

> **실무 팀은 비교표보다 이 섹션을 먼저 본다.** "이번 주"는 엄격하게 7~10일 창. 그 이전 항목은 "최근 30일 notable"로 내린다.

### 🚨 긴급: Haiku 3 모델 retirement 2026-04-19 (내일)

**claude-3-haiku-20240307** 모델이 **04-19 retirement** 됩니다. 이후 요청은 에러 반환. **Haiku 4.5로 마이그레이션 필요**. (출처: Anthropic 공식 release notes, 확실)

### 🚨 긴급: Sonnet 4.5/4 1M 컨텍스트 베타 종료 예정

**2026-04-30**에 Sonnet 4.5 및 Sonnet 4의 1M 컨텍스트 베타가 종료됩니다. 이후 `context-1m-2025-08-07` 헤더는 효력 없음. 200K 초과 요청은 에러 반환. **Sonnet 4.6 또는 Opus 4.7으로 마이그레이션 필요** (표준 가격으로 1M 지원).

### 🚨 긴급: Sonnet 4 / Opus 4 모델 retirement 2026-06-15

`claude-sonnet-4-20250514`, `claude-opus-4-20250514` 모두 **06-15 retirement**. Sonnet 4.6 / Opus 4.7 권장.

### 이번 주 주요 변경

| 날짜 | 플랫폼 | 변경 | 영향도 |
|---|---|---|---|
| **04-17** | **Anthropic** | **Claude Design** 연구 프리뷰 출시. Opus 4.7 기반. 코드베이스/디자인 파일 읽어 팀 디자인 시스템 자동 구축. PDF/PPTX/HTML/Canva export + Claude Code handoff 번들. Pro/Max/Team/Enterprise (Enterprise 기본 off) | **높음** |
| **04-17** | **Codex** | in-app 브라우저, **macOS Computer Use**, Chats(프로젝트 폴더 없이 스레드), Memory(세션 간), 스케줄링 자동화, **90+ 신규 플러그인**, gpt-image-1.5 | **높음** |
| **04-16** | **Anthropic** | **Claude Opus 4.7 GA**. 모델명 `claude-opus-4-7`. 가격 동일 ($5/$25 per MTok). 1M 컨텍스트. 벤치: SWE-bench Verified 64.3%, ARC-AGI-2 77.1% | **매우 높음** |
| **04-16** | **Claude Code** | **v2.1.111, v2.1.112** — /ultrareview 명령, xhigh effort level, Auto mode for Max (Opus 4.7), /effort 인터랙티브 슬라이더, Auto(match terminal) 테마 | **매우 높음** |
| **04-16** | **Anthropic API** | **Opus 4.7 브레이킹 체인지**: extended thinking budgets 제거(`thinking.budget_tokens` 400 에러), temperature/top_p/top_k 제거, adaptive thinking only, thinking content 기본 숨김(`display: "summarized"` opt-in), 새 토크나이저 1.0~1.35x 토큰 증가, 고해상도 이미지 2576px/3.75MP | **높음 (API 직접 사용 시)** |
| **04-16** | **GitHub Copilot** | Opus 4.7 GA. Pro+ 기본. 7.5x 프리미엄 승수(04-30까지 프로모) | 중간 |
| **04-16** | **GitHub** | **`gh skill` 명령 + Agent Skills 공개 스펙** — 크로스 플랫폼 스킬 설치 표준. GitHub CLI v2.90.0+ | **높음** |
| 04-15 | Claude Code | 데스크톱 앱 재설계 — multi-session sidebar, side chats | 중간 |
| 04-14 | Claude Code | Routines — 스케줄링 자동화, 오프라인 지원 | 중간 |
| 04-14 | OpenClaw | 2026.4.14 — Active Memory, gpt-5.4-pro forward-compat | 중간 |
| 04-10 | OpenClaw | 2026.4.10 — Native Codex 통합 | 중간 |
| 04-08 | **Anthropic** | **Managed Agents** 공개 베타. `$0.08/세션-시간`, `managed-agents-2026-04-01` 헤더. API 직접 사용 시 대안 | 중간 |
| 04-07 | Anthropic | Claude Mythos Preview — 11개 기업에만 제한 공개 (Project Glasswing). 일반 출시 계획 없음 | 낮음 (일반 사용 불가) |

### 최근 30일 Notable (이번 주 창 이전이지만 여전히 유효)

| 날짜 | 플랫폼 | 변경 |
|---|---|---|
| 04-04 | Claude Code | `forceRemoteSettingsRefresh` fail-closed, `/cost` 모델별+캐시 히트 분석, PowerShell 보안 강화 |
| 04-02 | H Company | Holo3: OSWorld-Verified 78.85% (Computer Use SOTA). 10B 활성, Apache 2.0 |
| 04-02 | DeepMind | "AI Agent Traps" 논문: 서브에이전트 스포닝 함정 58-90% 성공률 |
| 04-02 | Alibaba | Qwen3.6-Plus: 1M 컨텍스트, $0.29/M, Claude Code 호환 |
| 04-01 | Claude Code | v2.1.89: PermissionDenied hook, PreToolUse defer, disableSkillShellExecution |
| 04-01 | Codex | Windows sandbox OS 레벨 네트워크 격리, device code 로그인, `codex exec` prompt-plus-stdin, 동적 bearer 토큰 |
| 03-27 | Claude Code | v2.1.86: `--bare`, `--channels`, `rate_limits`, effort frontmatter |
| 03-26 | Codex | 플러그인 1급 워크플로우, 서브에이전트 v2, app-server TUI 기본, 레거시 도구 제거 |
| 03-24 | Figma | MCP write beta + Skills 프레임워크 |
| 03-23 | Claude Desktop | Computer Use 연구 미리보기 |

### Known Regressions & Workarounds

| 플랫폼 | 이슈 | 심각도 | Workaround |
|---|---|---|---|
| **Claude Code v2.1.112** | **프록시(CLIProxyAPI 등) 환경에서 cache read 드롭/호환성 회귀** — 공식 데스크톱/CLI 환경 영향은 미확인. 커뮤니티 측정 3건 확인 | 중간 (프록시 사용자 한정, 유력) | 프록시 사용자는 v2.1.111 또는 v2.1.109 고정 + `DISABLE_AUTOUPDATER=1` 검토. 공식 Claude Code 앱/CLI는 최신 유지 |
| **Claude Code + Opus 4.7** | **평균 burn rate 2.4~2.6x 증가** 커뮤니티 측정 (유력). cold-start 페널티 12.5x 보고. xhigh 기본값 + 새 토크나이저(1.0~1.35x) 복합 영향 | 높음 (비용) | 단순 작업은 명시적 `/effort low` 또는 `/effort medium`. xhigh는 복잡 설계·대규모 리팩터에만. task budgets로 상한 설정 |
| **Opus 4.7 API** | extended thinking budgets 설정 시 400 에러 — 브레이킹 체인지 | 높음 (API 직접 사용 시) | `thinking: {type: "adaptive"}` + `output_config.effort`로 마이그레이션 |
| **Opus 4.7 API** | temperature/top_p/top_k 비기본값 설정 시 400 에러 | 중간 (API 직접 사용 시) | 해당 파라미터 제거. 프롬프트로 동작 제어 |
| **Opus 4.7 UX** | thinking content 기본 숨김 → 스트리밍 UX에서 "긴 pause"로 보일 수 있음 | 낮음~중간 | `display: "summarized"` opt-in |
| **Codex** | Playwright MCP 매 action마다 승인 요구 (03-19 이후) | 높음 | Smart Approvals guardian subagent |
| **Codex** | `approval_policy=never`가 raw MCP writes에 적용 안 됨 | 높음 | raw MCP 경로에는 항상 human gate 남을 수 있다고 가정 |
| **Codex** | Plugins surface 불안정 — "New Plugin" ↔ "Skills" 전환 이슈 | 중간 | 선언형 설정(.codex/config.toml)으로 관리 |
| **Codex** | `codex exec` vs interactive 권한 불일치 (Linux/WSL2 EPERM) | 중간 | interactive 통과해도 `codex exec` 별도 검증 필수 |
| **Codex** | 서브에이전트 model override 무시 | 중간 | spawn 후 실제 모델 확인 |
| **Claude Code** | stale auth → rate limit 오인식 | 중간 | `claude auth logout && claude auth login` |
| **Claude Code** | 병렬 에이전트 auth token 만료 시 partially applied state | 중간 | 장시간 병렬 실행 전 auth freshness preflight |
| **Claude Desktop** | Computer Use 연구 미리보기: 실제 OS 조작 | **높음 (보안)** | 전용 계정/VM, 민감 앱 차단 목록, 스크린샷 감사 로그 |
| **Codex macOS Computer Use** | 04-17 신규 — 네이티브 앱 조작. EEA/UK/스위스 출시 제외 | **높음 (보안)** | Claude Desktop 규칙과 동일 적용 (섹션 15-6) |
| **Antigravity** | 이중 한도 (스프린트 250/5h + 주간 2,800) | 높음 | AI Credits OFF, Flash 중심. 분석은 AG, 실행은 Claude Code |
| **Figma** | Complex component state/variant 코드 생성 불일치 | 중간 | 상태별 수동 검수 |

### 한국/Windows Caveats

| 이슈 | 상태 | 비고 |
|---|---|---|
| macOS+VS Code Korean IME | 수정됨 (v2.1.84+) | 커서가 IME 조합 인라인 추적 |
| Windows CRLF 기억/적용 | 알려진 이슈 | Git `core.autocrlf=true` 권장 |
| WSL thread resume | 간헐적 이슈 | fork 후 resume 권장 |
| Windows headless OAuth refresh 429 | 알려진 이슈 | API key 기반 인증 또는 토큰 갱신 간격 조정 |

---

## 1. 모델별 프론트엔드 강약점 비교

> 이 표는 2026-04-18 기준입니다. 모델 업데이트 시 재평가 필요.
> ⚠️ Sonnet 4.5/4의 1M 컨텍스트 베타가 04-30 종료. Haiku 3 모델 04-19 retirement. Sonnet 4/Opus 4 모델 06-15 retirement.

| 영역 | Gemini 3.1 Pro | GPT-5.4 / Codex | Claude Opus 4.7 | Claude Opus 4.6 | Cursor Composer 2 |
|---|---|---|---|---|---|
| 레퍼런스 → 구현 속도 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 무에서 디자인 창조 | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| DOM/CSS 구조 정확도 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| 인터랙티브 애니메이션 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| 복잡한 로직/아키텍처 | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 코드 품질/재작업 최소화 | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 대규모 코드베이스 | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 환각/일관성 | ⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| 장시간 자율 실행 | ⭐⭐ | ⭐⭐⭐⭐⭐ (7시간+) | ⭐⭐⭐⭐⭐ (self-verification) | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ |
| 비전/이미지 이해 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ (2576px) | ⭐⭐⭐⭐ (1568px) | ⭐⭐⭐ |
| 속도 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ (Spark 1000+ tok/s) | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| API 비용 (입력/M) | 무료~$1.25 | $2~$10 | $5~$25 | $5~$15 | $0.50 |

**Opus 4.7 vs 4.6 핵심 차이:**
- **가격 동일** ($5/$25)이지만 **토큰 소비가 1.0~1.35x 증가** (새 토크나이저)
- **Claude Code xhigh 기본값** — 단순 작업도 xhigh 돌면 burn rate 2.4~2.6x 보고
- **API 브레이킹**: extended thinking budgets 제거, temperature 등 파라미터 제거, thinking content 기본 숨김
- **self-verification 능력 향상** — 완료 보고 전 자체 검증 단계 설계
- **vision 해상도 3.75MP** (4.6의 1.15MP 대비 3.3x)
- **task budgets 베타** — 장시간 작업 토큰 상한 설정 가능

**벤치마크 참고 (04-18):**
- SWE-bench Verified: Opus 4.7 64.3%, GPT-5.4 ~62%
- ARC-AGI-2: Opus 4.7 77.1% (Gemini 3 Pro 상회)
- Terminal-Bench 2.0: GPT-5.4 75.1, Composer 2 61.7, Opus 4.6 58.0 (Opus 4.7 수치 확인 필요)

**핵심 결론:**
- 비주얼/애니메이션 → Gemini (레퍼런스 받아 빠르게 구현하는 "실행기")
- 속도/자율 실행 → Codex (GPT-5.4) (1000+ tok/s, 7시간+ 자율)
- 로직/품질/리팩터/대규모 코드베이스 → **Claude Opus 4.7** (self-verification, 환각 최소)
- 비용 민감 + 로직 중심 → Opus 4.6 (4.7로 자동 업그레이드 전 중간 단계)

---

## 2. 도구 현황

### 2-1. Claude Design (2026-04-17 신규)

- **Anthropic Labs 연구 프리뷰** — Claude Pro/Max/Team/Enterprise 구독자. Enterprise는 기본 off (admin enable)
- **Claude Opus 4.7 기반** — 최고 비전 모델
- 프로토타입, 슬라이드, 원페이저, 인터랙티브 프로토타입, 와이어프레임, 마케팅 자료
- **코드베이스 + 디자인 파일 읽어 팀 디자인 시스템 자동 구축** — 이후 모든 프로젝트가 해당 디자인 토큰 자동 사용
- 여러 디자인 시스템 병행 지원
- export: **Canva, PDF, PPTX, HTML, Claude Code handoff 번들**
- Claude Code 통합: Claude Design에서 만든 디자인을 Claude Code로 그대로 implementation 넘기기
- **별도 usage tracking** — 기존 Claude/Claude Code 한도와 독립
- Enterprise usage-based: 1회성 크레딧 (~20 프롬프트) 제공, 이후 organizational spend로 카운트
- Figma 주가 7% 하락 (출시 직후) — 시장 반응 지표

### 2-2. Figma MCP (2026-03-24 업데이트 — read/write beta)

- `use_figma` 도구로 에이전트가 캔버스에 직접 쓰기 가능 (beta, 무료 → 이후 usage-based 유료)
- `generate_figma_design` 도구로 라이브 HTML → 편집 가능한 Figma 레이어 변환
- Skills 체계: `/figma-use`, `/figma-generate-design`, `/apply-design-system`, `/sync-figma-token`
- 지원 클라이언트: Augment, Claude Code, Codex, Copilot CLI, Copilot in VS Code, Cursor, Factory, Firebender, Warp
- write to canvas: Full/Dev 시트 유료 플랜에서만 (Dev 시트는 drafts 외 읽기 전용)
- 주의: SVG 노드 → 웹 코드 변환 시 85-90% 스타일링 부정확성 보고 (SFAI Labs)
- 주의: 복잡한 component/variant/state 자동 생성 결과는 상태별 수동 검수 필수

### 2-3. Google Antigravity (2026-04-18 기준)

- 버전: v1.20.x (AI Credits 토글은 03-11 이후 도입)
- 모델: Gemini 3.1 Pro (High/Low), Gemini 3 Flash, Claude Sonnet 4.6, Claude Opus 4.6/4.7, GPT-OSS 120B
- AgentKit 2.0: 16개 에이전트, 40+ 스킬, 11개 커맨드
- AGENTS.md 지원 (v1.20.3부터)
- **가격 구조:**
  - 이중 한도: 250유닛 스프린트(5h 리셋) + 2,800유닛 주간 베이스라인(주 1회 리셋)
  - AI Credits: $25/2,500 크레딧 추가 구매 가능하나 소비 속도 불투명
  - Pro $19.99 → Flash 중심. Ultra $249.99 → premium 모델 일관 접근
- **운영 리스크:**
  - AI Credits ON 시 소비 급가속 — OFF 권장
  - Gemini 3.1 Pro 환각/품질 불일치 보고
  - 48GB RAM 소비 보고
  - Stitch 접근 불가/Generate 버튼 비활성화 간헐

### 2-4. Google Stitch (2026-03 기준)

- 자연어 → 고충실도 UI, 5화면 동시 생성, Voice Canvas, Vibe Design
- Stitch MCP 서버로 Claude Code, Gemini CLI, Cursor 연동
- DESIGN.md export 가능
- Experimental 모드(Gemini 2.5 Pro) 월 50회 제한
- 주의: Claude Design 출시로 포지셔닝 압박 예상 (추적 필요)

### 2-5. paper.design (2026-03 기준)

- 버전: 0.1.10 (2026-03-26)
- 오픈 알파 상태 — Figma write beta + Claude Design 출시로 상대적 위상 추가 하락
- **위치: 1인/소규모 팀의 실험 레인**
- HTML/CSS 네이티브라는 구조적 장점은 유효

### 2-6. Codex 최신 기능 (2026-04-18 기준) ⭐ 대폭 업데이트

- GPT-5.4: 프론티어 모델, 1M 컨텍스트, 네이티브 computer use, 128K 출력
- GPT-5.4 mini: 경량 서브에이전트용, 비용 30%, 2x 이상 빠름
- GPT-5.3-Codex-Spark: 1000+ tok/s 실시간 코딩 (Pro 전용)
- gpt-image-1.5: 이미지 생성, 스크린샷+코드 통합

**04-17 대규모 업데이트 ⭐:**
- **In-app 브라우저** — Codex 앱 내에서 로컬/public 페이지 렌더. 페이지 위에 직접 코멘트 → Codex가 페이지 레벨 피드백 처리. 현재 프론트엔드/로컬호스트 게임 개발용. 브라우저 제어 범위는 점진 확대 예정
- **macOS Computer Use** — Codex가 맥 앱을 보고, 클릭하고, 타이핑. API 통합 없이 네이티브 앱 테스트, 시뮬레이터 플로우, 저위험 앱 설정, GUI 전용 버그 처리. **EEA/UK/스위스 출시 제외**. 여러 에이전트 동시 실행 가능
- **Chats** — 프로젝트 폴더 선택 없이 스레드 시작. 장기 작업 컨텍스트 유지 용이
- **Memory** — 세션 간 지식 보존
- **스케줄링 자동화** — 정기 작업 자동 실행
- **90+ 신규 플러그인** — 개발 라이프사이클 전체 커버
- **gpt-image-1.5 통합** — 제품 컨셉 비주얼, 프론트엔드 mockup, 게임 에셋

**03-26~04-01 주요:**
- 플러그인 1급 워크플로우: product-scoped sync, `/plugins` 탐색
- 서브에이전트 v2: 경로 기반 주소(`/root/agent_a`), 구조화된 메시징
- 서브에이전트 GA (03-16): Explorer/Worker/Default, `.codex/agents/` TOML
- Windows sandbox OS 레벨 네트워크 격리 (04-01)
- `codex exec` prompt-plus-stdin (04-01)
- device code 로그인 (04-01)

### 2-7. Claude Code 최신 기능 (2026-04-18 기준) ⭐ 대폭 업데이트

**04-16 Opus 4.7 대응 (v2.1.111, v2.1.112) ⭐:**
- **/ultrareview 슬래시 명령** — 전용 코드 리뷰 세션. **architecture, security, performance, maintainability 4영역** 통합 분석. "senior human reviewer 시뮬레이션". Pro/Max 사용자 **billing cycle당 3회 무료**, 이후 표준 Opus 4.7 레이트
- **xhigh effort level** — high와 max 사이. Opus 4.7에서 **Claude Code 기본값이 xhigh로 변경**. `/effort xhigh`, `--effort xhigh`, `CLAUDE_CODE_EFFORT_LEVEL=xhigh` 환경변수
- **`/effort` 인터랙티브 슬라이더** — 인자 없이 호출 시 화살표 키 네비게이션 + Enter 확정
- **Auto mode for Max** — Opus 4.7 사용 시 Max 구독자도 auto mode 접근 가능
- **Auto(match terminal) 테마** — 터미널의 dark/light 모드 자동 매칭
- permission prompts 감소 (safe bash/MCP 패턴 자동 허용 스킬 배포)
- Windows 지원 개선

**04-15 데스크톱 앱 재설계:**
- multi-session sidebar — 여러 세션 동시 관리
- side chats — 짧은 질문을 메인 세션 밖에서 처리

**04-14 Routines:**
- 스케줄링된 자동화 (cron 스타일)
- 오프라인 지원

**Opus 4.7 사용 시 주의:**
- 평균 burn rate 2.4~2.6x 증가 커뮤니티 측정 (유력)
- cold-start 12.5x 페널티 보고
- 새 토크나이저로 입력 토큰 1.0~1.35x 증가
- → 단순 작업은 명시적 `/effort medium` 또는 `/effort low`

**04-04 주요:**
- `forceRemoteSettingsRefresh` fail-closed
- `/cost` 모델별 + 캐시 히트 분석
- PowerShell 보안 강화

**04-01 주요 (v2.1.89+):**
- `PermissionDenied` hook + `{retry: true}`
- PreToolUse "defer" → `--resume`으로 재평가
- `MCP_CONNECTION_NONBLOCKING=true`
- `disableSkillShellExecution`
- `/powerup` 인터랙티브 레슨

**v2.1.86 (03-27):**
- `--bare` 플래그 (headless thin lane)
- `--channels` 권한 릴레이
- `rate_limits` statusline
- effort frontmatter (스킬/커맨드별 오버라이드)

### 2-8. Managed Agents (2026-04-08 신규) ⭐

- **Anthropic 공개 베타** — API 기반, `managed-agents-2026-04-01` 헤더
- 가격: `$0.08/세션-시간`
- API 직접 사용하는 팀용. 세션 상태, MCP 연결, 도구 호출을 Anthropic이 관리
- Opus 4.7 브레이킹 체인지 **영향 없음** (Managed Agents 내부는 마이그레이션 완료)
- Claude Code 사용자는 직접 관련 없음

### 2-9. Agent Skills 공개 스펙 + GitHub `gh skill` (2026-04-16 신규) ⭐

- **크로스 플랫폼 스킬 설치 표준** — Claude Code, Cursor, Codex, Gemini CLI, Copilot 등 공통
- Agent Skills: 포터블한 지시/스크립트/리소스 번들
- **`gh skill` 명령 하나로 설치** — GitHub CLI v2.90.0+
- Anthropic 단독 마켓플레이스에서 **오픈 표준**으로 이동 중
- 기존 Claude Code `/plugin marketplace` 방식과 병존

---

## 3. 가격 비교 (2026-04-18 기준)

| 도구/플랜 | 월 비용 | 포함 내용 |
|---|---|---|
| Claude Code Pro | $20 | Sonnet 4.6 기본, 제한적 Opus 4.7 |
| Claude Code Max 5x | $100 | Opus 4.7 충분한 한도, Auto mode |
| Claude Code Max 20x | $200 | Opus 4.7 대규모 작업, Auto mode |
| **Claude Design** | 구독에 포함 | **별도 usage tracking**, 주간 한도. Enterprise 추가 usage-based |
| Claude Opus 4.7 API | $5/$25 per MTok | **토크나이저 1.0~1.35x** → 실질 비용 증가. task budgets로 상한 설정 가능 |
| Managed Agents | $0.08/세션-시간 | API 기반 세션 관리 |
| Cursor Pro | $20 | Composer 2 + Opus 4.7 / Gemini 3 / GPT-5.4, 8 병렬 에이전트 |
| Codex (ChatGPT Plus) | $20 | GPT-5.4, 웹/앱/CLI/IDE 접근 + **in-app 브라우저 + macOS Computer Use** |
| Codex (ChatGPT Pro) | $200 | GPT-5.4 Pro + Spark(1000+ tok/s) |
| GitHub Copilot Pro+ | $39 | Opus 4.7, 7.5x 프리미엄 승수 (04-30까지 프로모) |
| Antigravity 무료 | $0 | Gemini Flash 중심, 이중 한도로 실사용 제한적 |
| Antigravity Pro | $19.99 | 이중 한도. **AI Credits OFF 권장** |
| Antigravity Ultra | $249.99 | 고볼륨, premium 모델 일관 접근 |

**Opus 4.7 실질 비용 재계산:**
- 표면 가격: 4.6과 동일 ($5/$25)
- 실제 소비: 토크나이저 +0~35% + xhigh 기본값 효과 → **평균 2~2.6x burn rate 증가** 커뮤니티 측정
- → 동일 예산으로 작업량은 40~60% 감소할 수 있음
- 대응: 단순 작업 `/effort low|medium` 강제, task budgets 활용

---

## 4. 실전 조합 패턴

| 패턴 | 도구 조합 | 비용 | 적합 대상 |
|---|---|---|---|
| **무료 최대화** | Claude Code 무료 + Antigravity Flash | $0 | 학습, 실험, POC |
| **프론트 특화** | Cursor(Composer 2 + Gemini) UI + Claude Code 로직 | $20~$40/월 | 프론트엔드 중심 |
| **디자인-코드 통합 (신규)** | **Claude Design + Claude Code Max** | $100+/월 | 디자인 시스템 보유 팀, 코드-디자인 양방향 루프 |
| **균형형 (권장)** | Stitch/Figma 디자인 + Cursor 구현 + Claude Code 아키텍처/리뷰 | $20~$60/월 | 풀스택 앱 |
| **품질 최우선** | Claude Code Max (Opus 4.7) + Codex(GPT-5.4) 병렬 + `/ultrareview` 정기 | $100~$200/월 | 프로덕션 앱 |
| **Opus 4.7 cost-aware** | Claude Code Max + xhigh는 선별 사용 + task budgets + 단순 작업은 Sonnet 4.6 라우팅 | $100/월 | Opus 4.7 burn rate 경감 |

---

## 5. 브라우저 자동화 & 시각 검증 & 구조 추출 도구

### 4계층 브라우저/시스템 도구 체계 (2026-04-18 업데이트)

| 계층 | 도구 | 성격 | 비용 |
|---|---|---|---|
| **정밀 자동화** | Playwright | 셀렉터 기반, CI/CD, E2E | 무료 (오픈소스) |
| **AI 시각 조작** | agent-browser (Vercel Labs) | AI가 "보고" 판단하며 조작 | 무료 (오픈소스) |
| **구조 추출** | Scrapling | 적응형 사이트 구조 이해, MCP 서버 | 무료 (오픈소스) |
| **OS 레벨 제어** | Claude Desktop Computer Use / **Codex macOS Computer Use** / Holo3 | 실제 데스크톱 마우스/키보드 | Computer Use: Pro/Max. Holo3: 무료 (Apache 2.0) |

**OS 레벨 제어 계층 2026-04 확장:**
- **Claude Desktop Computer Use** (03-23~) — macOS only, 연구 미리보기, Pro/Max
- **Codex macOS Computer Use** (04-17~) — 신규. API 통합 없이 네이티브 앱 조작. EEA/UK/스위스 출시 제외. ChatGPT Plus/Pro
- **Holo3** (04-02~) — 오픈소스, OSWorld-Verified 78.85% SOTA, 10B 활성

### agent-browser (github.com/vercel-labs/agent-browser)
- CLI 기반, Claude Code/Codex/Cursor/Gemini CLI/Copilot/Windsurf 통합
- 주석 달린 스크린샷, 인증 볼트, 콘텐츠 경계 마커
- 설치: `npm install -g agent-browser` + 스킬 연동

### Scrapling (github.com/D4Vinci/Scrapling)
- Python, 적응형 웹 스크래핑, GitHub 20K+ 스타
- 요소 핑거프린팅, MCP 서버 내장, StealthyFetcher
- 설치: `pip install "scrapling[all]"` + `scrapling install`

### 플랫폼 내장 시각 검증 도구

| 플랫폼 | 방법 | 설치 | 특징 |
|---|---|---|---|
| Codex | Screenshot Capture (내장) | 기본 | 풀스크린/앱/영역 캡처 |
| Codex | Playwright Interactive (내장) | `$skill-installer` | 빌드 중 실시간 시각 디버깅 |
| **Codex (04-17)** | **In-app 브라우저** | 기본 내장 | 페이지 위에 직접 코멘트, 페이지 레벨 피드백 |
| Antigravity | 내장 브라우저 서브에이전트 | 기본 | Gemini 비전으로 UI 검증 |
| Claude Code | Playwright MCP 서버 | `/plugin` | 브라우저 자동화 + 캡처 |

### 용도별 최적 도구 선택

| 용도 | 최적 도구 |
|---|---|
| CI/CD E2E 테스트 (확정 플로우) | Playwright |
| AI 에이전트 시각 검증 (라운드트립) | agent-browser 또는 Codex Playwright Interactive |
| 프론트엔드 프로토타입 검증 (로컬) | **Codex in-app 브라우저** |
| 레퍼런스 사이트 구조 추출 | Scrapling MCP |
| 네이티브 앱 테스트 (API 없음) | **Codex macOS Computer Use** 또는 Claude Desktop Computer Use |
| 오픈소스 컴퓨터 제어 연구/실험 | Holo3 |

---

## 6. 플랫폼 스킬 카탈로그

### Agent Skills 공개 스펙 (2026-04-16 신규) ⭐

- 크로스 플랫폼 스킬 표준 — 한 번 만들면 Claude Code/Cursor/Codex/Gemini CLI/Copilot에서 동작
- GitHub CLI `gh skill install <repo>` 한 줄 설치 (v2.90.0+)
- 기존 Claude Code 독자 마켓플레이스와 병존

### Codex 내장 스킬 (developers.openai.com/codex/skills)

| 프로젝트 유형 | 필수 스킬 | 권장 스킬 |
|---|---|---|
| 웹 프론트엔드 | Frontend Skill, Figma, Figma Implement Design | Playwright Interactive, Screenshot Capture, **In-app Browser** |
| 풀스택 앱 | Frontend Skill, Security Best Practices | Deploy 스킬, Yeet |
| API/백엔드 | Security Best Practices, OpenAI Docs | Playwright CLI, Jupyter |
| 콘텐츠/마케팅 | Image Gen, Sora, Speech Generation, **gpt-image-1.5** | Slides, Word Docs, PDF |
| 네이티브 앱 테스트 | **macOS Computer Use** | 민감 앱 차단 목록 필수 |
| 프로젝트 관리 | Linear, Notion Spec to Implementation | Interview, Notion Knowledge Capture |
| 보안 강화 | Security Best Practices, Security Threat Model | Sentry |

### Claude Code 마켓플레이스

| 마켓플레이스 | 규모 | 설치 명령 |
|---|---|---|
| Anthropic 공식 | 문서+예제 스킬 | `/plugin marketplace add anthropics/skills` |
| jeremylongshore | 340+ 플러그인, 1300+ 스킬 | `/plugin marketplace add jeremylongshore/claude-code-plugins` |
| daymade | 43 프로덕션급 | `/plugin marketplace add daymade/claude-code-skills` |
| mhattingpete | 엔지니어링 워크플로우 | `/plugin marketplace add mhattingpete/claude-skills-marketplace` |

검색: tonsofskills.com / skillsmp.com / claudemarketplaces.com / `ccpi search [키워드]`

### Claude Code 신규 공식 스킬 (04-16~17)

- **Generate permission allowlist from transcripts** — 세션 이력 분석해 자주 쓰이는 safe bash/MCP 패턴 자동 허용 리스트에 추가
- **Model migration guide** — 모델 버전 업 시 코드 마이그레이션 단계별 가이드 (Opus 4.6→4.7 브레이킹 체인지 대응)

---

## 변경 이력

| 날짜 | 변경 |
|---|---|
| 2026-04-18 | **Opus 4.7 GA (04-16) + Claude Design (04-17) + Codex 04-17 대규모 업데이트 반영.** 모델 비교표에 Opus 4.7 열 추가. `/ultrareview` + xhigh + task budgets + breaking API changes 반영. 섹션 2에 Claude Design 신설, Codex/Claude Code 재작성. Managed Agents 신설. Agent Skills 공개 스펙 추가. OS 레벨 제어 계층에 Codex macOS Computer Use 추가. 토큰 비용 재계산. Haiku 3 retirement 04-19 긴급 경고. |
| 2026-04-06 | 날짜 창 03-30~04-06으로 롤링. Sonnet 4.5/4 1M 컨텍스트 04-30 종료 긴급 경고. Claude Code v2.1.89+ 4월 기능. Codex 04-01. Holo3. DeepMind Agent Traps. Qwen3.6-Plus. Cursor Composer 2 + Terminal-Bench. |
| 2026-03-28 | 날짜 창 03-21~28 롤링, "이번 주"와 "최근 30일" 분리. Codex 03-26 대규모. Claude Code v2.1.86. Antigravity 이중 한도 + AI Credits OFF. |
| 2026-03-27 | agent-browser + Scrapling. 4계층 브라우저 도구 체계. |
| 2026-03-27 | 이번 주 Delta & Known Issues 섹션 0 추가. 한국/Windows Caveats. |
| 2026-03-26 | 초판. Figma MCP write beta(3/24), NIST 보안(3/23), Codex GPT-5.4(3/5), Antigravity v1.20.3(3/5) 기준. |
