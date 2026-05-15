# Global Claude configuration

Baseline rules for all projects. Project-specific rules live in AGENTS.md.

**Each project must have AGENTS.md at the project root.** Run `scripts/setup-project.sh --claude` from this repo, or create one with: purpose, functionality, tech choices, architecture notes, gotchas. AGENTS.md lives at the project root, not in `~/.claude/`.

## General configuration

Rules are authoritative. Apply every rule every time. In-conversation request conflicts with rules: follow request, flag the conflict. No silent relaxation.

Multi-step processes: one step at a time unless told otherwise. Explain, wait for confirmation.

### Interacting with the user

- Batch clarifying questions — minimise back and forth
- Propose changes as a plan; get review before proceeding

### Think before coding

**Surface confusion. State tradeoffs. Don't assume.**

- State assumptions explicitly; ask if unsure
- Multiple interpretations? Present all, don't pick silently
- Simpler approach exists? Say so; push back when warranted
- Unclear? Stop and name what's confusing
- Never install packages, run API calls, or use external tools without permission
- Admit mistakes; rewind and restart from first principles

### When expectations break

**Unexpected state — stop and ask. Don't dig.**

- File missing? Symlink broken? Output unexpected? Stop.
- Don't workaround, retry, or dig deeper — state what you expected vs. what you found
- Example: "I expected `CLAUDE.md` in `.claude/`, but it's missing. Should I create one or symlink it?"
- Recovers faster than chasing wrong paths. You know the system; I don't.

### Simplicity first

**Minimum code. Nothing speculative.**

- No features beyond request, no single-use abstractions
- No unasked flexibility, configurability, or error handling for impossible scenarios

### Surgical changes

**Touch only what's necessary. Clean up only your own mess.**

When editing:

- Don't improve adjacent code, comments, or formatting
- Don't refactor what works
- Match existing style
- Spot unrelated dead code? Mention it, don't delete

When your changes create orphans:

- Remove unused imports, variables, functions you created
- Don't remove pre-existing dead code unless asked

Rule: every changed line traces directly to the request

## Communication

- **UK spelling** — colour, organise, behaviour, grey, etc.
- **Titles**: sentence case
- **No preamble/summary** unless asked

## Git & version control

- Never commit automatically
- Update docs when changes require documentation

## Identity & expertise

Designer, front-end dev, strong full-stack. Focus: accessible design (WCAG AA, AAA where feasible), maintainable/scalable code, dev experience. UK-based. Exploring freelance, tooling, accessibility audits.

## Skill use policy

Skills are authoritative when their trigger conditions match. Before coding, editing prose, changing config, or reviewing files, inspect the task and file paths, then load and use every matching skill. If multiple skills match, use all relevant skills — especially `code-style` plus language/framework skills. Do not wait for explicit slash-command invocation.

## File discovery

Do not inspect generated, vendored, cached, build, dependency, or large binary directories unless explicitly asked. Prefer `rg` / `rg --files`, which respects `.gitignore` and `.rgignore`. Avoid `find`, broad `ls -R`, or reading ignored paths such as `node_modules`, `dist`, `build`, `.git`, coverage, caches, lockfile-heavy generated output, and local secrets.

## Global skills

Apply across all projects. See individual skills for detailed rules. Per-project `.claude/settings.json` can disable skills via `skillOverrides` — useful if a skill's tech (Vue, Swift) isn't used in that project.

- `/accessibility` — When building interfaces, WCAG AA baseline, accessible design
- `/agentic-engineering` — When building with Claude API, Anthropic SDK, or managed agents
- `/architecture-decision-records` — When documenting significant architectural decisions
- `/bash` — When writing shell scripts, bash config, patterns
- `/code-style` — When formatting code, covering naming, comments, arrays, objects
- `/dependencies` — When adding packages, what to choose, when to add
- `/e2e-testing` — When writing end-to-end tests with Playwright
- `/error-handling` — When validating input, graceful fallbacks, error handling
- `/readme` — When writing a README, structure, what to include/cut
- `/session-management` — When saving/resuming sessions, tracking multi-session work, token efficiency, goal-driven execution
- `/swift` — When writing Swift, style, SwiftUI patterns, concurrency
- `/swift-ui` — When writing/reviewing SwiftUI code, views, state management
- `/typescript` — When using TypeScript, type safety, escape hatches
- `/ui-copy` — When writing microcopy, buttons, errors, empty states, CTAs
- `/unit-testing` — When writing unit tests, Vitest, philosophy, what to skip
- `/vite-patterns` — When configuring vite.config.ts, Vite project patterns
- `/vue` — When writing Vue code, formatting, patterns, composables, components
- `/vue-project-stack` — When working in Vue + Bun + Vitest + Tailwind + Gitflow stack
- `/writing` — When writing prose/documentation, voice, tone, structure, style
