---
name: subagent-ops
description: Subagent operation contracts for Claude Code and Codex. Use when spawning subagents, delegating tasks to agents, using parallel execution, configuring TOML custom agents, or when the user mentions subagent, multi-agent, spawn, delegate, Scout, Mutator, Verifier, Explorer, Worker, or spawn_agents_on_csv.
---

# Subagent Operations — 서브에이전트 운영 계약

## Spawn 규칙

- **explicit spawn only** — 자동 fan-out 금지
- max_depth: 기본 1 (서브에이전트가 서브에이전트를 만들지 않음)
- max_threads: 프로젝트별 상한 명시 (권장: 5 이하)

## 3가지 역할

| 역할 | 권한 | 용도 |
|---|---|---|
| **Scout** (read-only) | 파일 읽기, 검색만 | 탐색, 코드 분석, 정보 수집 |
| **Mutator** | 파일 읽기/쓰기 | 코드 생성, 수정, 리팩터링 |
| **Verifier** (read-only) | 파일 읽기, 테스트 실행만 | 코드 리뷰, 테스트, 시각 검증 |

- Mutator는 반드시 worktree 분리
- Verifier는 코드 수정 권한 없음

## Codex 서브에이전트 GA 대응

| Codex 타입 | 우리 분류 |
|---|---|
| Explorer | Scout |
| Worker | Mutator |
| Default | 작업에 따라 |

- 커스텀 에이전트: `.codex/agents/*.toml`로 정의
- `spawn_agents_on_csv`: CSV 행당 Worker 1개, 결과 CSV export
- 서브에이전트 v2: 경로 주소 `/root/agent_a`

## Result Schema

모든 서브에이전트는 반환 형식 사전 정의:
- 최소: `status`, `summary`, `changed_files`, `issues_found`, `next_action`
- 완료 조건을 spawn 시 명시

## Thread 소유권

- 같은 thread 동시 resume 금지 — fork
- 완료된 에이전트는 명시적 close
- stale agent: 1회 재시도, 이후 수동 개입

## 비용

- 경량 모델(Sonnet/Haiku/GPT-5.4 mini/Spark) 우선
- model override 무시 이슈 → spawn 후 실제 모델 확인
