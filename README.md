# noma-dev-rules

**v2.3.0** — "Reducing the human bottleneck + planning completeness" theme.

A Claude Code plugin providing operating rules for AI-agent-driven development. Built for solo developers and small teams who want to **stop being the bottleneck** and let agents ship features as planned.

## What's new in v2.3.0 (2026-04-24)

**17 updates across 7 days (2026-04-18 ~ 2026-04-24):**

### Critical 5
- **GPT-5.5 released** (2026-04-23) — Codex default. Model comparison updated. **Hallucination rate 86% warning** (Opus 4.7 is 36%).
- **Claude Advisor Tool** (2026-04-09, official beta) — Executor + Advisor pattern in one API call. Sonnet+Opus advisor: 11.9% cheaper than Sonnet solo, +2.7pp on SWE-bench Multilingual.
- **🚨 MCP STDIO design flaw** — 10 CVEs, 200K+ vulnerable instances. Anthropic declined to patch. **Each team must defend at application level** — 6 required mitigations.
- **Claude Code storm v2.1.92~v2.1.118** — `/ultraplan` (cloud 3+1 pattern), `/recap`, `/usage`, Prompt caching 1H TTL, vim visual mode.
- **AGENTS.md standard rewrite** — Linux Foundation AAIF. AGENTS.md = single source of truth. Princeton: -28.6% runtime, -16.6% tokens.

### High 5
- Cursor 3 + Composer 2 + Windsurf Wave 13 SWE-1.5 (model comparison table)
- Codex GPT-5.5 integration
- **Spec-Driven Development** section added (Requirements → Design → Tasks → Implementation, Hierarchical Context)
- **Orchestrator + Checker** pattern (Claude Code Task System, self-verification)
- Routines detail (3 triggers, 13+ GitHub events, daily limits)

### Medium 7
- Opus 4.7 AWS Bedrock availability (2026-04-20)
- Ecosystem growth: Superpowers 121K, Hermes v0.8.0, Paperclip 43K, CE 11K
- Computer Use expanded to 3 platforms (+ Cowork)
- **Subagent advanced fields**: `skills:` preload, `memory:` (user/project/local/none), `color:`, permissionMode inheritance
- Windsurf Cascade harness details
- OpenAI acquires Astral (uv+ruff, 2026-03-19)
- Korean/Japanese (CJK) fixes (v2.1.84+)

## Core principles

- **Explore → Plan → Execute** protocol. Use `/ultraplan` for multi-approach exploration
- **TDD Iron Law**: No production code without a failing test
- **Done = tests pass + lint clean + typecheck clean**
- **"Don't stop at blocked"** — always offer workaround, reduced scope, next verification step
- **Three confidence tags**: confirmed / probable / requires verification
- **Honorific Korean** as primary communication language (can be overridden)

## 9 skills, 3 agents, 2 hooks

### Skills
- `tool-landscape` — model comparison, pricing, known issues
- `security-ops` — external content handling, MCP STDIO mitigations
- `frontend-pipeline` — design pipeline (Claude Design, Figma MCP, etc.)
- `browser-automation` — 4-tier browser automation (Playwright → agent-browser → Scrapling → Computer Use)
- `subagent-ops` — Advisor pattern, Orchestrator+Checker, agent memory/skills/color
- `headless-lane` — thin lane (--bare -p, codex exec)
- `project-interview` — structured interview for ambiguous requests
- `upstream-tracker` — track Superpowers, GSD, Hermes, Paperclip, CE, etc.
- `maintainability` — `/ultrareview` + quantitative thresholds

### Agents
- `browser-verifier` — screenshot + responsive check
- `security-reviewer` — MCP/permissions/secrets
- `design-auditor` — generic AI aesthetic detector

### Hooks
- `auth-preflight.sh` — stale auth detection
- `browser-cleanup.sh` — Chrome cleanup

## Compatible with

- [Superpowers](https://github.com/obra/superpowers) — TDD, planning
- [gstack](https://github.com/garrytan/gstack) — YC-style multi-role governance
- [claude-code-spec-workflow](https://github.com/Pimzino/claude-code-spec-workflow) — SDD (Pimzino)

## Documentation

Full reference:
- `docs/project-operation-rules-v2.3.md` — invariant principles (~2660 lines)
- `docs/tool-landscape-snapshot-2026-04-24.md` — weekly-refreshed tool status
- `docs/antigravity-frontend-policy.md` — Antigravity-specific policy

## Install

```bash
/plugin marketplace add noma-openproject/noma-dev-rules
/plugin install noma-dev-rules
```

## License

MIT
