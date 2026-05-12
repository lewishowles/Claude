# Global Claude configuration

A central repository for Claude Code configuration, based on constant tinkering to get the best output. This repository includes baseline rules, skills, hooks, and project templates.

## What's inside

- **CLAUDE.md** — global rules applied to all work: decision-making philosophy, execution standards, communication style, tech stack choices
- **skills/** — skill folders covering specific areas: Vue, testing, TypeScript, accessibility, writing, and more. Each is a folder containing `SKILL.md` with frontmatter and instructions
- **CREDITS.md** — attribution for skills or content adapted from external sources
- **hooks/** — shell scripts registered as Claude Code hooks; they fire automatically during sessions to enforce standards and trigger skills
- **settings.json** — global Claude Code settings, symlinked to `~/.claude/settings.json`
- **AGENTS.md.template** — starting point for per-project instructions

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

### 4. Shell helper (optional)

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

## Hooks

Hooks are shell scripts that Claude Code runs automatically at specific points. They're registered in `settings.json` and live in `hooks/`.

| Hook | Event | What it does |
|------|-------|-------------|
| `skill-autotrigger.sh` | Every user message | Pattern-matches your prompt and tells Claude which skills to invoke before responding. Falls back to injecting all skills for short or ambiguous messages like "yes" or "let's continue". |
| `skill-file-trigger.sh` | Before every Write or Edit | Checks the file extension and reminds Claude which skills apply. Complements `skill-autotrigger` for cases where Claude independently decides what to write. |
| `check-claude.sh` | Before every tool use | Checks that a `CLAUDE.md` file is present in the project. Blocks and reports if missing. |
| `pre-stop-checks.sh` | When Claude finishes | Runs lint and test checks before the session closes. |

### How skill triggering works

Skills aren't invoked automatically by Claude Code — they need an explicit `Skill` tool call. The trigger hooks bridge that gap by injecting a strong instruction into Claude's context at the right moment.

`skill-autotrigger.sh` runs on your message and can detect intent from what you type. If you write something ambiguous, such as "Continue", it injects all skills and lets Claude pick what's relevant. `skill-file-trigger.sh` runs when Claude is about to write a file, so it catches cases where Claude decides independently what to create.

Neither hook is perfect as they are based on keywords, and by the time `skill-file-trigger` fires the file content is already planned. Together, however, they cover most cases without any manual invocation.

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

## Skills reference

All skills are available via `/skillname` in Claude Code (e.g. `/vue`, `/unit-testing`). They're also triggered automatically by the hooks above.

| Skill | When it applies |
|-------|----------------|
| `accessibility` | Building interfaces — WCAG AA baseline, colour contrast, keyboard access, semantic HTML |
| `architecture-decision-records` | Documenting significant technical decisions — framework adoption, major refactors, architectural patterns |
| `bash` | Shell scripts, zsh functions, `.env` files, config files |
| `code-style` | All code — formatting, naming, comments. Applies to every language |
| `dependencies` | Adding packages or considering a new library |
| `e2e-testing` | End-to-end tests with Playwright — browser automation, user interactions, test structure |
| `error-handling` | Functions with parameters, API calls, response handling |
| `readme` | Writing or editing a README — structure, what belongs, what to cut |
| `session-management` | Saving/resuming work sessions across Claude Code restarts — context snapshots, checkpoints |
| `swift` | Swift code — comment style, spacing, SwiftUI patterns, concurrency, `@Observable`/`@MainActor` |
| `swift-ui` | SwiftUI code — state management, view composition, navigation, performance optimisation |
| `typescript` | TypeScript files, type errors, type definitions, generics |
| `ui-copy` | Microcopy — button labels, error messages, empty states, tooltips, CTAs |
| `unit-testing` | Writing or reviewing unit tests — Vitest, XCTest, `@testing-library/vue`, test structure |
| `vite-patterns` | Configuring `vite.config.ts`, managing environment variables, build optimisation, security |
| `vue` | Vue 3 components, composables, templates — patterns and organisation |
| `vue-project-stack` | Vue projects using the wider stack: Bun, Vitest, Tailwind, Gitflow, `@lewishowles/helpers`, `@lewishowles/components` |
| `writing` | Prose — blog posts, documentation, longform content, voice and tone baseline |
