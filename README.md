# Global agent configuration

A central repository for Claude Code and OpenAI Codex configuration. This repository includes shared baseline rules, skills, Claude hooks, agent-specific target files, and project templates.

## What's inside

- **shared/** — source files for shared rules used by both Claude and Codex
- **targets/claude/** — generated `CLAUDE.md`, Claude settings, and Claude hooks
- **targets/codex/** — generated `AGENTS.md` for Codex
- **skills/** — skill folders covering specific areas: Vue, testing, TypeScript, accessibility, writing, and more. Each is a folder containing `SKILL.md` with frontmatter and instructions
- **scripts/** — sync and setup scripts
- **templates/** — starting points for new projects: `AGENTS.md.template` for per-project instructions, `settings.json` with stack-specific skills suppressed by default
- **CREDITS.md** — attribution for skills or content adapted from external sources
- **docs/** — deeper reference: [hooks](docs/hooks.md), [skills](docs/skills.md), [commands](docs/commands.md), [agents](docs/agents.md), [plugins](docs/plugins.md)

## Initial setup (one-time)

Replace `/path/to/repository` with the actual path to this repository throughout.

### Claude, Codex, or both

```bash
cd /path/to/repository
scripts/setup-global.sh --both
```

Use `--claude` or `--codex` to set up one runtime only. With no flag, the script asks which agent(s) to configure.

The script runs `scripts/sync.sh`, then creates per-file and per-skill symlinks:

- `~/.claude/CLAUDE.md` → `targets/claude/CLAUDE.md`
- `~/.claude/settings.json` → `targets/claude/settings.json`
- `~/.claude/skills/<name>` → `skills/<name>`
- `~/.claude/hooks/<file>` → `targets/claude/hooks/<file>`
- `~/.codex/AGENTS.md` → `targets/codex/AGENTS.md`
- `~/.agents/skills/<name>` → `skills/<name>`

Existing files are backed up instead of overwritten.

### Hook dependency

The skill-trigger hooks require `jq`:

```bash
brew install jq
```

`skill-autotrigger.sh` will block prompts and report an error if `jq` is missing. `skill-file-trigger.sh` silently skips instead, so writes are never blocked.

### Shell aliases (optional)

Add aliases to `~/.zshrc` if you run global setup often:

```bash
alias setup:agents:global="/path/to/repository/scripts/setup-global.sh --both"
alias setup:claude:global="/path/to/repository/scripts/setup-global.sh --claude"
alias setup:codex:global="/path/to/repository/scripts/setup-global.sh --codex"
```

## Optional: Recommended tools

These tools are optional but recommended for enhanced workflows.

### Superpowers plugin — Structured workflows

Adds structured skills for TDD, debugging, code review, and architecture design.

**One-time setup:**

```bash
claude plugin install superpowers@claude-plugins-official
```

**Workflow notes:**

- **Auto-triggers**: Skills activate automatically based on context and keywords
- **Structured workflows**: TDD, debugging, code review, planning, architecture design
- **No per-project setup needed**: Works globally once installed
- **Access**: Type `/superpowers:*` to see available skills, or they auto-trigger in relevant contexts

## Per-project setup

Project setup is still manual until `scripts/setup-project.sh` lands.

Create an `AGENTS.md` file in the project root or `.claude/AGENTS.md` for Claude-only projects. Document:

- **Purpose & functionality** — what does this project do?
- **Tech choices** — anything specific to this project
- **Architecture notes** — key patterns, structure, how things fit together
- **Gotchas & constraints** — tricky parts, known issues, limitations

For Claude-only projects, copy `templates/settings.json` to `.claude/settings.json` and set stack-specific skills to `"on"` for whatever the project uses. See [docs/skills.md](docs/skills.md) for the full list of override values.

## Going deeper

- [docs/hooks.md](docs/hooks.md) — how hooks work, event types, skill triggering, adding new hooks
- [docs/skills.md](docs/skills.md) — full skills reference with auto-trigger keywords, adding new skills
- [docs/commands.md](docs/commands.md) — built-in commands, skill commands, and plugin commands
- [docs/agents.md](docs/agents.md) — available agent types and when to use each
- [docs/plugins.md](docs/plugins.md) — installed plugins (caveman, claude-mem) and how to manage them
