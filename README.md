# Global Claude configuration

A central repository for Claude Code configuration, based on constant tinkering to get the best output. This repository includes baseline rules, skills, hooks, and project templates.

## What's inside

- **CLAUDE.md** — global rules applied to all work: decision-making philosophy, execution standards, communication style, tech stack choices
- **skills/** — skill folders covering specific areas: Vue, testing, TypeScript, accessibility, writing, and more. Each is a folder containing `SKILL.md` with frontmatter and instructions
- **hooks/** — shell scripts that fire automatically during sessions to enforce standards and trigger skills
- **settings.json** — global Claude Code settings, symlinked to `~/.claude/settings.json`
- **AGENTS.md.template** — starting point for per-project instructions
- **CREDITS.md** — attribution for skills or content adapted from external sources
- **docs/** — deeper reference: [hooks](docs/hooks.md), [skills](docs/skills.md), [commands](docs/commands.md), [agents](docs/agents.md), [plugins](docs/plugins.md)

## Initial setup (one-time)

Replace `/path/to/repository` with the actual path to this repository throughout.

### 1. Skills

Symlink the whole `skills/` directory so new skills appear automatically:

```bash
ln -s /path/to/repository/skills ~/.claude/skills
```

Verify:

```bash
ls -la ~/.claude/skills
# Should point back to this repository's skills folder
```

### 2. Settings

Symlink the settings file to set up the hooks, enabled plugins, and marketplaces.

```bash
# Back up any existing settings first
cp ~/.claude/settings.json ~/.claude/settings.json.bak 2>/dev/null

ln -sf /path/to/repository/settings.json ~/.claude/settings.json
```

Any changes made during a Claude session are written here and tracked by this repository.

### 3. Hooks

Symlink the whole `hooks/` directory so `settings.json` can reference scripts via a stable path:

```bash
ln -s /path/to/repository/hooks ~/.claude/hooks
```

Verify:

```bash
ls -la ~/.claude/hooks
# Should point back to this repository's hooks folder
```

### 4. Hook dependency

The skill-trigger hooks require `jq`:

```bash
brew install jq
```

`skill-autotrigger.sh` will block prompts and report an error if `jq` is missing. `skill-file-trigger.sh` silently skips instead, so writes are never blocked.

### 5. Shell helper (optional)

Add to `~/.zshrc` to streamline new-project setup:

```bash
function setup:claude() {
	echo ""

	if [ ! -f ".claude/CLAUDE.md" ]; then
		ln -s /path/to/repository/CLAUDE.md .claude/CLAUDE.md
		echo "${GREEN}✓${RESET_COLOUR} Symlinked ${PURPLE}CLAUDE.md${RESET_COLOUR}"
	else
		echo "${PURPLE}CLAUDE.md${RESET_COLOUR} already exists. No link was made."
	fi

	if [ ! -f ".claude/AGENTS.md" ]; then
		echo ""
		echo "${YELLOW}Important:${RESET_COLOUR} Set up project-specific instructions in ${PURPLE}AGENTS.md${RESET_COLOUR}. See AGENTS.md.template for an example."
	fi

	echo ""
}
```

## Per-project setup

Each project needs its own `.claude/AGENTS.md`. Use the template:

```bash
cd your-project
mkdir -p .claude
cp /path/to/repository/AGENTS.md.template .claude/AGENTS.md
setup:claude
```

Edit `.claude/AGENTS.md` to document:

- **Purpose & functionality** — what does this project do?
- **Tech choices** — anything specific to this project
- **Architecture notes** — key patterns, structure, how things fit together
- **Gotchas & constraints** — tricky parts, known issues, limitations

## Going deeper

- [docs/hooks.md](docs/hooks.md) — how hooks work, event types, skill triggering, adding new hooks
- [docs/skills.md](docs/skills.md) — full skills reference with auto-trigger keywords, adding new skills
- [docs/commands.md](docs/commands.md) — built-in commands, skill commands, and plugin commands
- [docs/agents.md](docs/agents.md) — available agent types and when to use each
- [docs/plugins.md](docs/plugins.md) — installed plugins (caveman, claude-mem) and how to manage them
