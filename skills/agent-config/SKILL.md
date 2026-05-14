---
name: agent-config
description: Use this skill when maintaining this agent configuration repository for Claude and Codex, including CLAUDE.md, AGENTS.md, settings.json, skills/*/SKILL.md, hooks/*.sh, scripts/*.sh, docs/**, and templates/**. Covers repo structure, skill conventions, hook conventions, trigger patterns, and generated target files. Pair with bash or writing as needed.
related-skills:
  - bash
  - writing
---

# Agent config

Skill applies in `~/Dev/Configuration/Claude` — repo defining shared Claude and Codex global behaviour.

## Repo structure

```
Configuration/Claude/
├── CLAUDE.md               # Current Claude global rules — Phase 3 moves generated output to targets/
├── templates/
│   ├── AGENTS.md.template  # Starting point for per-project .claude/AGENTS.md
│   └── settings.json       # Project template with stack-specific skills suppressed
├── CREDITS.md              # Attribution for externally-inspired content
├── README.md               # Setup guide for new installs
├── settings.json           # Current Claude Code settings (Phase 3 moves to targets/claude/)
├── docs/
│   ├── agents.md           # Claude agent types reference
│   ├── commands.md         # Built-in, skill, and plugin commands
│   ├── hooks.md            # Hook reference and skill triggering explanation
│   ├── plugins.md          # Installed plugins and agent-specific notes
│   └── skills.md           # Full skills reference with auto-trigger keywords
├── hooks/
│   ├── check-claude.sh         # PreToolUse — blocks if .claude/CLAUDE.md is missing
│   ├── pre-stop-checks.sh      # Stop — runs lint + unit tests before Claude finishes
│   ├── skill-autotrigger.sh    # UserPromptSubmit — keyword-matches prompt → injects skill list
│   └── skill-file-trigger.sh   # PreToolUse (Write|Edit) — extension-matches file → injects skill reminder
└── skills/
    ├── accessibility/
    ├── agentic-engineering/
    ├── architecture-decision-records/
    ├── bash/
    ├── agent-config/           # This skill
    ├── code-style/
    ├── dependencies/
    ├── e2e-testing/
    ├── error-handling/
    ├── readme/
    ├── session-management/
    ├── swift/
    ├── swift-ui/
    ├── typescript/
    ├── ui-copy/
    ├── unit-testing/
    ├── vite-patterns/
    ├── vue/
    ├── vue-project-stack/
    └── writing/
```

## Skill conventions

- **Folder name** = skill slug (used in `/slug` commands, hook pattern lists, and Codex skill discovery)
- Each skill folder: exactly one `SKILL.md`
- Frontmatter fields: `name`, `description`, `related-skills` (optional)
- `description` shown in skills list — starts with "Use this skill when", then includes action-led wording and relevant file globs
- Content: `#` title, `##` sections — no banner comments or dividers
- UK spelling

## Hook conventions

- All current hooks in `hooks/`, symlinked to `~/.claude/hooks/`; Phase 3 moves them to `targets/claude/hooks/`
- Registered in `settings.json` under appropriate event key
- Each hook outputs JSON to stdout — Claude Code reads this, not stderr
- `UserPromptSubmit` hooks receive `{"prompt": "..."}` on stdin
- `PreToolUse` hooks receive full tool input JSON on stdin
- Hard-fail (exit 2) only when blocking intentional; else exit 0

### skill-autotrigger.sh pattern authoring

Each skill block follows:

```bash
# ─── skill-name ───────────────────────────────────────────────────────────
# One-line comment: what this skill covers and why these keywords
if echo "$prompt" | grep -qiE 'keyword1|keyword2|\bterm\b'; then
    skills+=("skill-name")
fi
```

- Use `\b` word boundaries — avoid partial matches
- Case-insensitive (`-i`) always
- Pair related skills in same block (e.g. `vue` always adds `vue-project-stack`)
- New skill → add to continuation catch-all list at top too

### skill-file-trigger.sh extension mapping

Add new extensions to `case` block:

```bash
case "$ext" in
    ext) skills+=("skill-name") ;;
esac
```

Filename-based rules (README, vite.config) go in `if`/`shopt` block below case.

## settings.json structure

```json
{
  "env": {},
  "hooks": {
    "EventName": [{ "hooks": [{ "type": "command", "command": "...", "timeout": 30 }] }]
  },
  "enabledPlugins": { "plugin@marketplace": true },
  "extraKnownMarketplaces": { "marketplace": { "source": { "source": "github", "repo": "owner/repo" } } }
}
```

Hook event names: `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `Stop`, `SessionStart`.
`PreToolUse` supports `matcher` field (regex against tool name).

## Installed plugins

| Plugin | Marketplace | What it adds |
|--------|-------------|-------------|
| `caveman` | `caveman@caveman` | Compressed communication mode + review/commit skills |
| `claude-mem` | `claude-mem@thedotmack` | Persistent cross-session memory + codebase exploration skills |

## When editing docs/

- Update `docs/skills.md` when adding/removing skill
- Update `docs/hooks.md` when changing hook behaviour or adding hook
- Update `docs/commands.md` when new skill or plugin command appears
- Keep `README.md` focused on setup — detail in `docs/`

## When adding or changing skills and hooks

When adding, removing, or renaming a skill:
- Check `skill-autotrigger.sh` — add keyword patterns if the skill has clear trigger terms; add to the continuation catch-all list at the top
- Check `skill-file-trigger.sh` — add file extension or filename mappings if the skill applies to specific file types
- Update `docs/skills.md` with the new entry

When creating a new hook:
- Register it in `settings.json` under the correct lifecycle event
- Add a entry to `docs/hooks.md` with: event, purpose, stdin format, and what it outputs

## Progress tracking for meaningful work

See `session-management` skill — covers `PROGRESS.md` structure, when to create it, and how to update it across sessions. The template lives at `.claude/templates/PLAN.md.template` in each project.
