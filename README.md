# noma-dev-rules

**v2.4.0** — "Persistent goals + observable agent runs" theme.

A Claude Code plugin providing operating rules for AI-agent-driven development. Built for solo developers and small teams who want to **stop being the bottleneck** and let agents ship features as planned.

## What's new in v2.4.0 (2026-05-01)

**Full refresh based on the latest 3-day window (2026-04-28 ~ 2026-05-01):**

### Critical 5
- **Codex 0.128.0** — persisted `/goal`, app-server APIs, runtime continuation, explicit permission profiles, plugin-bundled hooks, and MultiAgentV2 thread caps/wait controls.
- **Claude Code 2.1.122~2.1.126** — OAuth/Bedrock/Vertex stability, PR URL resume search, remote-control retry/error clarity, and subagent/model improvements.
- **Cursor SDK + Cloud Agents API** — durable `agent` objects and per-prompt `run` objects with SSE streaming, reconnect, cancellation, and lifecycle controls.
- **Gemini CLI trust fixes** — secure `.env` loading, enforced workspace trust in headless mode, and fail-closed restricted rule parsing.
- **Copilot agent economics** — long-running and parallel agent workflows now require explicit cost, quota, and model-multiplier guardrails.

### High 5
- **Agent Run Ledger**: every agent run records `agent`, `run`, `status`, `branch/PR`, `artifacts`, `verifier_result`, and cost/limit notes.
- **Verifier-first delivery**: implementation and verification are split; browser/debug/security verifier roles are read-only by default.
- **Explicit permission profiles**: prefer task-scoped permission profiles, sandbox, cwd, and network allowlists over convenience automation flags.
- **Copilot Debugger flow**: issue → reproduce → instrument → diagnose → targeted fix. No bug fix is done without reproduction evidence.
- **Upstream operating signals**: Superpowers session transcripts, gstack Step 0 smoke gates, Ruflo federation, and OpenCode release cadence all reinforce audit trails.

### Medium 5
- Record local CLI versions separately from the release snapshot; local tools may lag the current release.
- Auth preflight must be runtime-specific and safe-degrading; Claude auth failure must not block a Codex hook.
- Document ingestion, transcript compaction, and remote session recovery reduce manual copy/paste but do not replace run ledgers.
- `plugin-updates` explicitly tracks Noma v2.4 and Andrej Karpathy Skills.
- v2.3 Advisor, SDD, Orchestrator+Checker, and MCP STDIO mitigations remain valid under the v2.4 run-ledger and trust-gate model.

## Core principles

- **Goal → Plan → Run → Verify → Report** protocol. Large tasks close with state and verification artifacts.
- **TDD Iron Law**: No production code without a failing test
- **Done = tests pass + lint clean + typecheck clean**
- **Agent Run Ledger required**: record agent/run/status/branch or PR/artifacts/verifier result.
- **Headless trust gate**: do not load `.env`, config, MCP servers, or shell allowlists without explicit workspace trust.
- **"Don't stop at blocked"** — always offer workaround, reduced scope, next verification step
- **Three confidence tags**: confirmed / probable / requires verification
- **Honorific Korean** as primary communication language (can be overridden)

## 9 skills, 3 agents, 2 hooks

### Skills
- `tool-landscape` — current model/agent runtimes, known issues, cost/quota
- `security-ops` — external content handling, MCP STDIO mitigations, headless trust
- `frontend-pipeline` — design pipeline (Claude Design, Figma MCP, etc.)
- `browser-automation` — 4-tier browser automation (Playwright → agent-browser → Scrapling → Computer Use)
- `subagent-ops` — agent/run ledgers, verifier separation, MultiAgentV2/Cursor/Copilot contracts
- `headless-lane` — thin lane, workspace trust, permission profiles, parity tests
- `project-interview` — structured interview for ambiguous requests
- `upstream-tracker` — track Superpowers, gstack, Ruflo, OpenCode, Cursor/Copilot agent flows
- `maintainability` — `/ultrareview` + quantitative thresholds

### Agents
- `browser-verifier` — screenshot + responsive check
- `security-reviewer` — MCP/permissions/secrets
- `design-auditor` — generic AI aesthetic detector

### Hooks
- `auth-preflight.sh` — runtime-specific safe-degrade auth checks (Codex hook binding still requires re-verification)
- `browser-cleanup.sh` — Chrome cleanup

## Compatible with

- [Superpowers](https://github.com/obra/superpowers) — TDD, planning
- [gstack](https://github.com/garrytan/gstack) — YC-style multi-role governance
- [claude-code-spec-workflow](https://github.com/Pimzino/claude-code-spec-workflow) — SDD (Pimzino)
- [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills) — behavioral guidance for common LLM coding pitfalls

## Documentation

Full reference:
- `docs/project-operation-rules-v2.4.md` — v2.4 operating invariants
- `docs/project-operation-rules-v2.3.md` — v2.3 detailed principles archive
- `docs/tool-landscape-snapshot-2026-05-01.md` — latest 3-day tool snapshot
- `docs/tool-landscape-snapshot-2026-04-24.md` — weekly-refreshed tool status
- `docs/antigravity-frontend-policy.md` — Antigravity-specific policy

## Install

```bash
/plugin marketplace add noma-openproject/noma-dev-rules
/plugin install noma-dev-rules
```

## License

MIT
