# Skills

Skills are focused instruction sets that tell Claude how to behave in a specific context — what patterns to follow, what to avoid, and what the conventions are. They're loaded on demand via the `Skill` tool, either manually or by the trigger hooks.

## User skills

Defined in `~/.claude/skills/` (this repo, symlinked). Available in every project.

| Skill | When to use | Auto-trigger keywords |
|-------|-------------|----------------------|
| `accessibility` | Building interfaces — WCAG AA baseline, colour contrast, keyboard access, semantic HTML | `wcag`, `a11y`, `aria`, `keyboard nav`, `screen reader`, `colour contrast`, `focus`, `button`, `form`, `label`, `heading` |
| `agentic-engineering` | Building with Claude API, Anthropic SDK, or managed agents — model selection, token budgeting, batch processing, prompt caching | `claude api`, `anthropic sdk`, `managed agent`, `llm cost`, `token budget`, `prompt caching`, `batch api` |
| `architecture-decision-records` | Documenting significant technical decisions — framework adoption, major refactors, architectural patterns | `adr`, `architecture decision`, `tech decision`, `decision record`, `framework adoption`, `major refactor` |
| `bash` | Shell scripts, zsh functions, `.env` files, config files | `.sh`, `bash`, `zsh`, `shell script`, `.env`, `alias`, `export`, `PATH`, `.zshrc`, `cron` |
| `claude-config` | Working in this config repo — editing CLAUDE.md, settings.json, skills, hooks, docs | `claude.md`, `skill`, `hook`, `settings.json`, `autotrigger`, `claude config` |
| `code-style` | All code in any language — formatting, naming, comments | `write`, `add`, `create`, `implement`, `fix`, `function`, `method`, `class`, `variable`, `file`, `code` |
| `dependencies` | Adding packages or considering a new library — when to add, what to avoid, @lewishowles libs | `package.json`, `npm install`, `bun add`, `yarn add`, `install package`, `new library`, `upgrade package` |
| `e2e-testing` | End-to-end tests with Playwright — browser automation, user journeys, test structure | `e2e`, `playwright`, `end-to-end test`, `user journey`, `data-test` |
| `error-handling` | Functions with parameters, API calls, response handling | `error handling`, `try-catch`, `validate`, `guard let`, `api call`, `fetch`, `async`, `throws`, `Result<` |
| `readme` | Writing or editing a README — structure, what belongs, what to cut | `readme`, `getting started guide` |
| `session-management` | Saving and resuming work sessions across Claude Code restarts | `save session`, `resume session`, `context snapshot`, `checkpoint`, `session management` |
| `swift` | Swift code — comment style, spacing, concurrency, `@Observable`/`@MainActor` | `.swift`, `swift`, `swiftui`, `xcode`, `@observable`, `@state`, `@mainactor`, `xctest` |
| `swift-ui` | SwiftUI code — state management, view composition, navigation, performance | (paired with `swift`; triggered by SwiftUI-specific APIs) |
| `typescript` | TypeScript files, type errors, type definitions, generics | `.ts`, `.tsx`, `typescript`, `type error`, `interface`, `generics`, `Record<`, `Partial<`, `keyof`, `typeof` |
| `ui-copy` | Microcopy — button labels, error messages, empty states, tooltips, CTAs | `ui copy`, `microcopy`, `error message`, `button label`, `cta`, `empty state`, `tooltip`, `placeholder` |
| `unit-testing` | Writing or reviewing unit tests — Vitest, XCTest, `@testing-library/vue` | `test`, `spec`, `coverage`, `.test.`, `.spec.`, `xctest`, `vitest`, `describe`, `mock`, `spy`, `assert` |
| `vite-patterns` | Configuring `vite.config.ts`, environment variables, build optimisation, security | `vite.config`, `VITE_`, `environment var`, `build.lib`, `rollup`, `esbuild` |
| `vue` | Vue 3 components, composables, templates — patterns and organisation | `.vue`, `vue`, `composable`, `<script setup`, `pinia`, `defineProps`, `ref(`, `computed(` |
| `vue-project-stack` | Vue projects using the wider stack: Bun, Vitest, Tailwind, Gitflow, `@lewishowles` libs | (always paired with `vue`; same triggers) |
| `writing` | Prose — blog posts, documentation, longform content, voice and tone | `documentation`, `docs`, `blog`, `changelog`, `article`, `reword`, `rephrase`, `proofread` |

## Built-in Claude Code skills

Provided by Claude Code itself. No SKILL.md files — managed by the application.

| Skill | When to use |
|-------|-------------|
| `claude-api` | Building, debugging, or optimising Claude API / Anthropic SDK apps, including prompt caching and model version migrations |
| `fewer-permission-prompts` | Scan transcripts and add a permission allowlist to `.claude/settings.json` to reduce approval prompts |
| `init` | Initialise a new project with Claude Code conventions |
| `keybindings-help` | Customise keyboard shortcuts, rebind keys, or add chord bindings in `~/.claude/keybindings.json` |
| `loop` | Run a prompt or slash command on a recurring interval (e.g. `/loop 5m /foo`) |
| `review` | Run a code review of the current branch or changes |
| `schedule` | Create, update, list, or run scheduled remote agents on a cron schedule |
| `security-review` | Run a security-focused review of code changes |
| `simplify` | Review changed code for reuse, quality, and efficiency, then fix issues found |
| `update-config` | Modify Claude Code configuration via `settings.json` — hooks, permissions, env vars, plugins |

## Plugin skills — caveman

From the [caveman plugin](https://github.com/JuliusBrussee/caveman). Compressed communication mode.

| Skill | When to use |
|-------|-------------|
| `caveman:caveman` | Activate compressed caveman mode — drops articles, filler, hedging to cut output tokens ~75%. Levels: `lite`, `full` (default), `ultra` |
| `caveman:caveman-commit` | Write terse Conventional Commits commit messages — subject ≤50 chars, body only when the why isn't obvious |
| `caveman:caveman-help` | Display a reference card for all caveman modes, skills, and commands |
| `caveman:caveman-review` | Write ultra-compressed PR review comments — one line per finding: location, problem, fix |
| `caveman:compress` | Compress `.md` files (CLAUDE.md, todos, preferences) into caveman prose to save input tokens. Run: `/caveman:compress <filepath>` |

## Plugin skills — claude-mem

From the [claude-mem plugin](https://github.com/thedotmack/claude-mem). Persistent cross-session memory.

| Skill | When to use |
|-------|-------------|
| `claude-mem:babysit` | Monitor a PR until it is ready to merge — watches CI, resolves review threads, fixes issues in focused commits |
| `claude-mem:do` | Execute a phased implementation plan using subagents — typically used after `make-plan` |
| `claude-mem:how-it-works` | Explain how claude-mem captures observations, when memory injection kicks in, and where data lives |
| `claude-mem:knowledge-agent` | Build and query AI-powered knowledge bases from past observations — create focused "brains" about specific topics |
| `claude-mem:learn-codebase` | Prime a codebase by reading every source file in full — use when starting on an unfamiliar project |
| `claude-mem:make-plan` | Create a detailed, phased implementation plan with documentation discovery — use before `do` |
| `claude-mem:mem-search` | Search persistent cross-session memory — use when asking "did we solve this before?" or "how did we do X last time?" |
| `claude-mem:pathfinder` | Map a codebase into feature-grouped flowcharts, identify duplicated concerns, and propose a unified architecture |
| `claude-mem:smart-explore` | Token-optimised AST code search using tree-sitter — replaces Read/Grep/Glob for large codebases (4–18× token savings) |
| `claude-mem:timeline-report` | Generate a "Journey Into [Project]" narrative report analysing a project's entire development history |
| `claude-mem:version-bump` | Automated semantic versioning and release workflow for Claude Code plugins — bumps version across all manifests, publishes to npm, creates GitHub release |
| `claude-mem:wowerpoint` | Turn one document into a kawaii NotebookLM slide-deck PDF — use for "make a deck about \<file\>" |

## Controlling which skills load (skillOverrides)

Skills can be selectively suppressed in any `settings.json` using `skillOverrides`. This is the main tool for reducing token usage — skill descriptions are the bulk of the listing cost.

| Value | Effect |
|-------|--------|
| `"on"` | Default. Full description shown to model and user-invocable |
| `"name-only"` | Skill name listed only — no description. Model knows it exists but doesn't consume description tokens. `/skill-name` still works |
| `"user-invocable-only"` | Hidden from model entirely. `/skill-name` still works for manual use |
| `"off"` | Hidden from both model and user |

To re-enable a skill suppressed by a parent settings file, set it to `"on"` in the project or local settings file:

```json
{
  "skillOverrides": {
    "vue": "on",
    "vue-project-stack": "on"
  }
}
```

See `templates/settings.json` for a project template with non-universal skills set to `name-only`.

## Invoking a skill

**Manually:** type `/skill-name` in Claude Code (e.g. `/vue`, `/unit-testing`).

**Automatically:** the trigger hooks inject skills based on your prompt keywords and the file being written. See [docs/hooks.md](hooks.md) for how this works.

Plugin skills use namespaced slugs: `/caveman:compress`, `/claude-mem:mem-search`.

## Adding a new skill

1. Create a folder in `skills/` matching the slug you want (e.g. `skills/my-skill/`)
2. Add `SKILL.md` with frontmatter:

```markdown
---
name: my-skill
description: Use this skill when... (one sentence — shown in the skills list)
related-skills:
  - code-style
---

# My skill

Content here.
```

3. Register keyword triggers in `hooks/skill-autotrigger.sh` so the hook detects relevant prompts
4. Register file extension triggers in `hooks/skill-file-trigger.sh` if the skill maps to a file type
5. Add the skill to the skills table in this file and to [docs/commands.md](commands.md)

The skill appears in Claude Code's skill list immediately — no restart needed.
