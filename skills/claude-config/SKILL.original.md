---
name: claude-config
description: Use this skill when working in the Claude configuration repository itself — editing CLAUDE.md, AGENTS.md, settings.json, skills/, hooks/, or docs/. Covers repo structure, skill and hook conventions, trigger pattern authoring, and how the pieces fit together.
related-skills:
  - bash
  - writing
---

# Claude config

This skill applies when working in `~/Dev/Configuration/Claude` — the repository that defines Claude's global behaviour.

## Repo structure

```
Configuration/Claude/
├── CLAUDE.md               # Global rules — applies to all projects
├── AGENTS.md.template      # Starting point for per-project .claude/AGENTS.md
├── CREDITS.md              # Attribution for externally-inspired content
├── README.md               # Setup guide for new installs
├── settings.json           # Global Claude Code settings (symlinked to ~/.claude/settings.json)
├── docs/
│   ├── agents.md           # Agent types reference
│   ├── commands.md         # Built-in, skill, and plugin commands
│   ├── hooks.md            # Hook reference and skill triggering explanation
│   ├── plugins.md          # Installed plugins (caveman, claude-mem)
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
    ├── claude-config/          # This skill
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

- **Folder name** = skill slug (used in `/slug` commands and hook pattern lists)
- Every skill folder contains exactly one `SKILL.md`
- Frontmatter fields: `name`, `description`, `related-skills` (optional list)
- `description` is shown in the skills list — one sentence, starts with "Use this skill when..."
- Content uses `#` for the title, `##` for sections — no banner comments or dividers
- UK spelling throughout

## Hook conventions

- All hooks live in `hooks/` and are symlinked to `~/.claude/hooks/`
- Registered in `settings.json` under the appropriate event key
- Each hook outputs JSON to stdout — Claude Code reads this, not stderr
- `UserPromptSubmit` hooks receive `{"prompt": "..."}` on stdin
- `PreToolUse` hooks receive the full tool input JSON on stdin
- Hooks should hard-fail (exit 2) only when blocking is intentional; otherwise exit 0

### skill-autotrigger.sh pattern authoring

Each skill block in `skill-autotrigger.sh` follows this pattern:

```bash
# ─── skill-name ───────────────────────────────────────────────────────────
# One-line comment: what this skill covers and why these keywords
if echo "$prompt" | grep -qiE 'keyword1|keyword2|\bterm\b'; then
    skills+=("skill-name")
fi
```

- Use `\b` word boundaries to avoid partial matches
- Case-insensitive (`-i`) always
- Pair related skills in the same block (e.g. `vue` always adds `vue-project-stack`)
- When adding a new skill, add it to the continuation catch-all list at the top too

### skill-file-trigger.sh extension mapping

Add new extensions to the `case` block:

```bash
case "$ext" in
    ext) skills+=("skill-name") ;;
esac
```

Filename-based rules (README, vite.config) go in the `if`/`shopt` block below the case.

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
`PreToolUse` supports a `matcher` field (regex against tool name).

## Installed plugins

| Plugin | Marketplace | What it adds |
|--------|-------------|-------------|
| `caveman` | `caveman@caveman` | Compressed communication mode + review/commit skills |
| `claude-mem` | `claude-mem@thedotmack` | Persistent cross-session memory + codebase exploration skills |

## When editing docs/

- Update `docs/skills.md` when adding or removing a skill
- Update `docs/hooks.md` when changing hook behaviour or adding a new hook
- Update `docs/commands.md` when a new skill or plugin command appears
- Keep `README.md` focused on setup — detail goes in `docs/`
