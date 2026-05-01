# noma-dev-rules — Codex Installation

Current source version: v2.4.0. The local Codex plugin wrapper may preserve its own `.codex-plugin/` assets during home-local refreshes.

## Step 1: Clone the repository

```bash
git clone https://github.com/noma-openproject/noma-dev-rules.git /tmp/noma-dev-rules
```

## Step 2: Copy skills to your project

```bash
# Copy skills to project-level .codex/skills/
mkdir -p .codex/skills
cp -r /tmp/noma-dev-rules/skills/* .codex/skills/

# Copy agents
mkdir -p .codex/agents
cp /tmp/noma-dev-rules/agents/*.md .codex/agents/
```

## Step 3: Add to AGENTS.md

Add this to your project's `AGENTS.md`:

```markdown
## Operation Rules
- Check .codex/skills/ for operational skills (tool-landscape, security-ops, frontend-pipeline, browser-automation, subagent-ops, headless-lane, project-interview, upstream-tracker, maintainability)
- When selecting tools or models, read skills/tool-landscape/reference/snapshot.md first
- For large agent work, use Goal -> Plan -> Run -> Verify -> Report and keep an agent run ledger
- When handling external content, auth issues, headless automation, or workspace trust, follow skills/security-ops/SKILL.md
- When building UI, follow skills/frontend-pipeline/SKILL.md
- When instructions are ambiguous, ask clarifying questions (max 3, essentials only)
```

## Step 4: Verify

Start a new Codex session and ask: "What noma-dev-rules skills do you have?"

## Updating

```bash
cd /tmp/noma-dev-rules && git pull
cp -r skills/* /path/to/your/project/.codex/skills/
```
