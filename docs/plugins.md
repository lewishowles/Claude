# Plugins

Plugins extend Claude Code with additional skills, hooks, and capabilities. They're installed globally and available in every session.

Plugins differ from skills: skills are files in this repository that you maintain directly; plugins are versioned packages installed from a marketplace (GitHub-based) and managed by Claude Code.

## Installed plugins

### caveman (`caveman@caveman`)

**Source:** `github:JuliusBrussee/caveman`

Activates ultra-compressed communication mode, cutting filler and reducing response verbosity without losing technical substance. Useful for keeping sessions tight and reducing token usage.

**Skills provided:**

| Skill | What it does |
|-------|-------------|
| `/caveman` | Activate caveman mode. Levels: `full` (default), `lite`, `ultra` |
| `/caveman-help` | Quick-reference card for all modes, skills, and shortcuts |
| `/caveman-review` | Ultra-compressed code review comments |
| `/caveman-commit` | Ultra-compressed commit message generator |
| `/compress` | Compress natural-language memory files (CLAUDE.md, todo lists, notes) |

**Modes:**

| Mode | What changes |
|------|-------------|
| `lite` | Drop filler and pleasantries; keep full sentences |
| `full` | Drop articles, fragments OK, short synonyms — classic caveman |
| `ultra` | Maximum compression; symbols and abbreviations |

Activate: `/caveman` or `/caveman lite\|full\|ultra`. Deactivate: type "stop caveman" or "normal mode".

---

### claude-mem (`claude-mem@thedotmack`)

**Source:** `github:thedotmack/claude-mem`

Persistent cross-session memory for Claude Code. Captures observations during sessions and stores them so future sessions can recall past work, decisions, and context — even after the conversation context is cleared.

**Skills provided:**

| Skill | What it does |
|-------|-------------|
| `/mem-search` | Search the persistent memory database |
| `/how-it-works` | Explain how claude-mem captures and stores observations |
| `/learn-codebase` | Prime a codebase by reading every source file — builds a searchable corpus |
| `/smart-explore` | Token-optimised structural code search using tree-sitter |
| `/make-plan` | Create a detailed, phased implementation plan with documented steps |
| `/do` | Execute a phased plan using subagents |
| `/pathfinder` | Map a codebase into feature-grouped flowcharts |
| `/knowledge-agent` | Build and query AI-powered knowledge bases |
| `/babysit` | Watch a pull request until it's ready to merge |
| `/version-bump` | Automated semantic versioning and release workflow |
| `/timeline-report` | Generate a narrative history of a project |
| `/wowerpoint` | Turn a document into a slide deck |

**Getting started with claude-mem:**

1. In a new project, run `/learn-codebase` to prime the memory corpus
2. Use `/mem-search` at the start of a session to recall past context
3. claude-mem captures observations automatically during sessions — no manual saving needed
4. Use `/make-plan` + `/do` to run phased multi-step work across session boundaries

---

## Installing a plugin

```
/plugins install <marketplace>/<plugin-name>
```

Plugins are installed globally (user scope) and registered in `settings.json` under `enabledPlugins`. Adding a new marketplace:

```json
"extraKnownMarketplaces": {
  "marketplace-name": {
    "source": {
      "source": "github",
      "repo": "owner/repo"
    }
  }
}
```

## Plugin vs skill

| | Plugins | Skills |
|-|---------|--------|
| Maintained by | Plugin author (versioned releases) | You (files in this repo) |
| Installed via | `/plugins install` | Already available via symlinked `skills/` |
| Updated via | `/plugins update` | `git pull` on this repo |
| Scope | User-global | User-global (via symlink) |
| Best for | General-purpose tools (memory, compression) | Project conventions, language standards |
