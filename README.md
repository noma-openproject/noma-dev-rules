# noma-dev-rules

**AI agent project operation rules as a plugin.** Tool landscape, security, frontend pipeline, browser automation, subagent contracts, headless lane — all auto-triggered.

[한국어](README.ko.md)

## What this is

A skills-based plugin that gives your coding agent **operational awareness** — not just how to write code, but *which tools to use, what's broken this week, how to stay secure, and when to fall back*.

Works alongside [Superpowers](https://github.com/obra/superpowers) (coding discipline) and [oh-my-claudecode](https://github.com/Yeachan-Heo/oh-my-claudecode) (execution modes). No conflicts — different layers.

```
[oh-my-claudecode]  → Execution engine (autopilot, parallel, ecomode)
[Superpowers]       → Coding discipline (brainstorm, TDD, plan, review)
[noma-dev-rules]    → Operation rules (tools, security, design, known issues)
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
| **frontend-pipeline** | Building UI, implementing designs, CSS/React work |
| **browser-automation** | Running E2E tests, visual verification, scraping sites |
| **subagent-ops** | Spawning subagents, delegating tasks, parallel execution |
| **headless-lane** | Setting up CI, scheduled tasks, non-interactive automation |
| **project-interview** | Receiving vague or ambiguous instructions |

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
- **This week's changes** (7-day window, strict)
- **Known regressions & workarounds** (with severity)
- **Model comparison** (Gemini / GPT-5.4 / Claude Opus)
- **Pricing** (Antigravity / Cursor / Claude Code / Codex)
- **Korean/Windows caveats**

## Full reference docs

The `docs/` folder contains complete operation rules (~1,400 lines), tool snapshot (~290 lines), and Antigravity frontend policy (~330 lines). Skills auto-reference these when needed — you don't have to read them manually.

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
