# Skills

Skills are focused instruction sets that tell Claude how to behave in a specific context — what patterns to follow, what to avoid, and what the conventions are. They're loaded on demand via the `Skill` tool, either manually or by the trigger hooks.

## Skills reference

| Skill | When it applies | Auto-trigger keywords |
|-------|----------------|----------------------|
| `accessibility` | Building interfaces — WCAG AA baseline, colour contrast, keyboard access, semantic HTML | `wcag`, `a11y`, `aria`, `keyboard nav`, `screen reader`, `colour contrast`, `focus`, `button`, `form`, `label`, `heading` |
| `architecture-decision-records` | Documenting significant technical decisions — framework adoption, major refactors, architectural patterns | `adr`, `architecture decision`, `tech decision`, `decision record`, `framework adoption`, `major refactor` |
| `bash` | Shell scripts, zsh functions, `.env` files, config files | `.sh`, `bash`, `zsh`, `shell script`, `.env`, `alias`, `export`, `PATH`, `.zshrc`, `cron` |
| `code-style` | All code in any language — formatting, naming, comments | `write`, `add`, `create`, `implement`, `fix`, `function`, `method`, `class`, `variable`, `file`, `code` |
| `dependencies` | Adding packages or considering a new library | `package.json`, `npm install`, `bun add`, `yarn add`, `install package`, `new library`, `upgrade package` |
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

## Invoking a skill

**Manually:** type `/skill-name` in Claude Code (e.g. `/vue`, `/unit-testing`).

**Automatically:** the trigger hooks inject skills based on your prompt keywords and the file being written. See [docs/hooks.md](hooks.md) for how this works.

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
5. Add the skill to the `skills` table in this file and to [docs/commands.md](commands.md)

The skill appears in Claude Code's skill list immediately — no restart needed.
