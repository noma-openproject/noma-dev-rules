# noma-dev-rules

**AI agent project operation rules as a plugin.** Tool landscape, security, frontend pipeline, browser automation, subagent contracts, headless lane, maintainability review — all auto-triggered.

[한국어](README.ko.md)

**v2.2.0 — 2026-04-18 update:** Opus 4.7 (04-16), Claude Design (04-17), Codex 04-17 major update, new maintainability skill, quantitative thresholds, learning loop.

## What this is

A skills-based plugin that gives your coding agent **operational awareness** — not just how to write code, but *which tools to use, what's broken this week, how to stay secure, when to fall back, and whether the existing code is healthy*.

Works alongside [Superpowers](https://github.com/obra/superpowers) (coding discipline) and [gstack](https://github.com/garrytan/gstack) (sprint roles). No conflicts — different layers.

```
[Ruflo/claude-mem]   → Execution engine / memory (optional)
[Superpowers]       → Coding discipline (brainstorm, TDD, plan, review)
[noma-dev-rules]    → Operation rules (tools, security, design, maintainability, known issues)
```

## Quick Start

### Claude Code

```bash
/plugin marketplace add noma-openproject/noma-dev-rules
/plugin install noma-dev-rules
```

### Codex

```
Fetch and follow instructions from https://raw.githubusercontent.com/noma-openproject/noma-dev-rules/main/.codex/INSTALL.md
```

### Manual

```bash
git clone https://github.com/noma-openproject/noma-dev-rules.git ~/.claude/plugins/noma-dev-rules
```

## Skills (auto-triggered)

| Skill | Triggers when... |
|---|---|
| **tool-landscape** | Selecting tools, comparing models, checking known issues, quota problems |
| **security-ops** | Handling external content, installing plugins, auth issues, permissions |
| **frontend-pipeline** | Building UI, implementing designs, CSS/React work (Stitch/Figma/v0/Claude Design/paper.design) |
| **browser-automation** | Running E2E tests, visual verification, scraping sites, Computer Use |
| **subagent-ops** | Spawning subagents, delegating tasks, parallel execution |
| **headless-lane** | Setting up CI, scheduled tasks, non-interactive automation |
| **project-interview** | Receiving vague or ambiguous instructions |
| **upstream-tracker** | Tracking upstream frameworks (Superpowers/gstack/Hermes) |
| **maintainability** ⭐ v2.2.0 | Before major merges, phase transitions, monthly audits — `/ultrareview` + quantitative thresholds + learning loop |

## Agents

| Agent | Role | Permission |
|---|---|---|
| **browser-verifier** | Screenshot + console + network verification | Read-only |
| **security-reviewer** | External threats, hallucinated APIs, credential exposure | Read-only |
| **design-auditor** | Generic AI aesthetics check, design system compliance | Read-only |

## Hooks

| Hook | Event | Purpose |
|---|---|---|
| **auth-preflight** | SessionStart | Check auth freshness before long sessions |
| **browser-cleanup** | Stop | Kill orphaned Chrome/Chromium processes |

## What's in the weekly snapshot

The `tool-landscape` skill includes a weekly-updated snapshot with:
- **This week's changes** (7-10 day window, strict)
- **Known regressions & workarounds** (with severity)
- **Model comparison** (Gemini / GPT-5.4 / Claude Opus 4.6/4.7)
- **Pricing** (Antigravity / Cursor / Claude Code / Codex / Claude Design)
- **Korean/Windows caveats**

## v2.2.0 highlights

- **Opus 4.7 adaptation** — xhigh effort level, task budgets, new tokenizer 1.0–1.35x, burn rate 2.4–2.6x warning
- **`/ultrareview` integration** — Claude Code new slash command
- **Quantitative thresholds** — file ≤1200 lines, CC ≤15/25, lint 0, coverage ≥70%
- **Learning loop** — troubleshootings → feedback → CLAUDE.md auto-injection (4 stages)
- **Working directory structure** — orders/plans/working/report/feedback/troubleshootings
- **Claude Design** (04-17) — added as Stage 2c in frontend pipeline
- **Codex macOS Computer Use** — security rules extended to 2 platforms
- **Routines** — monthly `/ultrareview` automation

## Full reference docs

The `docs/` folder contains complete operation rules (~2,000 lines), tool snapshot (~400 lines), and Antigravity frontend policy (~330 lines). Skills auto-reference these when needed.

## Compatibility

| Platform | Status |
|---|---|
| Claude Code | ✅ Plugin marketplace |
| Codex | ✅ Manual install |
| Cursor | ✅ Plugin marketplace |
| Claude.ai | ⚠️ Use docs/ as project knowledge |
| Gemini CLI | 🔜 Planned |

## License

MIT
