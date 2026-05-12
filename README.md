# Global Claude configuration

A central repository for Claude Code configuration, based on constant tinkering to get the best output. This repository includes baseline rules, skills, hooks, and project templates.

## What's inside

- **CLAUDE.md** — global rules applied to all work: decision-making philosophy, execution standards, communication style, tech stack choices
- **skills/** — skill folders covering specific areas: Vue, testing, TypeScript, accessibility, writing, and more. Each is a folder containing `SKILL.md` with frontmatter and instructions
- **hooks/** — shell scripts that fire automatically during sessions to enforce standards and trigger skills
- **settings.json** — global Claude Code settings, symlinked to `~/.claude/settings.json`
- **templates/** — starting points for new projects: `AGENTS.md.template` for per-project instructions, `settings.json` with stack-specific skills suppressed by default
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
	local repo="/path/to/repository"

	echo ""
	mkdir -p .claude

	# Symlink the global config (not a template, lives in repo root)
	if [ ! -f ".claude/CLAUDE.md" ]; then
		ln -s "$repo/CLAUDE.md" .claude/CLAUDE.md
		echo "${GREEN}✓${RESET_COLOUR} Symlinked ${PURPLE}CLAUDE.md${RESET_COLOUR}"
	else
		echo "${PURPLE}CLAUDE.md${RESET_COLOUR} already exists. No link was made."
	fi

	# Copy config files from templates. Format: .claude/<file> → templates/<file>
	local -a targets=(
		".claude/AGENTS.md"
		".claude/settings.json"
		".claude/.claudeignore"
	)

	local -A copy_messages=(
		[AGENTS.md]="edit it to document this project"
		[settings.json]="enable stack-specific skills as needed"
		[.claudeignore]="edit to customise which directories to skip"
	)

	for target in "${targets[@]}"; do
		local filename=$(basename "$target")
		local source="$repo/templates/$filename"

		if [ ! -f "$target" ]; then
			cp "$source" "$target"
			local msg="${copy_messages[$filename]}"
			if [ -n "$msg" ]; then
				echo "${GREEN}✓${RESET_COLOUR} Copied ${PURPLE}$filename${RESET_COLOUR} — $msg"
			else
				echo "${GREEN}✓${RESET_COLOUR} Copied ${PURPLE}$filename${RESET_COLOUR}"
			fi
		else
			echo "${PURPLE}$filename${RESET_COLOUR} already exists. No changes made."
		fi
	done

	echo ""
}
```

## Optional: Recommended tools

These tools are optional but recommended for enhanced workflows.

### Graphify — Knowledge graphs

Build knowledge graphs from your codebase to understand structure, dependencies, and relationships at scale.

**One-time setup (macOS):**

Install via `uv`:

```bash
uv tool install graphify
graphify install
```

Requires:

- `uv` (install via `brew install uv` if needed)
- `ANTHROPIC_API_KEY` environment variable set

**Per-project setup:**

From your project root:

```bash
graphify claude install
```

Then run:

```bash
/graphify .
```

This generates a knowledge graph of the current directory.

**Workflow notes:**

- **When to use**: Understanding a large codebase, mapping dependencies, identifying patterns
- **Output**: Interactive graph visualization + exportable JSON
- **Customization**: Edit `.graphifyrc` in your project to customize what gets indexed (e.g., ignore certain directories, focus on specific file types)

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

Run `setup:claude` from the project root:

```bash
cd your-project
setup:claude
```

Copy `.claudeignore` to the project root (optional but recommended):

```bash
cp /path/to/repository/templates/.claudeignore .
```

This tells Claude Code which directories to skip during analysis (node_modules, build artifacts, locks, databases, etc.). Edit as needed for your project.

Edit `.claude/AGENTS.md` to document:

- **Purpose & functionality** — what does this project do?
- **Tech choices** — anything specific to this project
- **Architecture notes** — key patterns, structure, how things fit together
- **Gotchas & constraints** — tricky parts, known issues, limitations

In `.claude/settings.json`, set stack-specific skills to `"on"` for whatever this project uses. See [docs/skills.md](docs/skills.md) for the full list of override values.

## Going deeper

- [docs/hooks.md](docs/hooks.md) — how hooks work, event types, skill triggering, adding new hooks
- [docs/skills.md](docs/skills.md) — full skills reference with auto-trigger keywords, adding new skills
- [docs/commands.md](docs/commands.md) — built-in commands, skill commands, and plugin commands
- [docs/agents.md](docs/agents.md) — available agent types and when to use each
- [docs/plugins.md](docs/plugins.md) — installed plugins (caveman, claude-mem) and how to manage them
