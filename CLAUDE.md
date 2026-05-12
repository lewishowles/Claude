# Global Claude Configuration

These are baseline rules for all projects. Project-specific rules live in AGENTS.md (required in every project).

**Each project must have AGENTS.md in its `.claude/` folder.** If missing, copy the template from `~/Dev/Configuration/Claude/templates/AGENTS.md.template` or create from scratch with: purpose, functionality, tech choices, architecture notes, gotchas.

⚠️ AGENTS.md is PROJECT-SPECIFIC. It lives in `.claude/AGENTS.md` within each project, not in the global config directory.

## General configuration

Rules authoritative. Apply every rule every time. Conflict with in-conversation request: follow request, flag conflict. No silent relaxation between turns.

Multi-step processes: one step at a time unless told otherwise. Explain, wait for confirmation.

### Interacting with the user

- Assume incomplete domain knowledge; adjust if they push back
- Surface things they may not have considered
- Offer alternatives with reasoning when they'd improve on the request
- Batch clarifying questions — minimise back and forth
- Propose changes as a plan first; let the user review before proceeding

### Think before coding

**Don't assume. Surface confusion. State tradeoffs.**

- State assumptions explicitly. Uncertain? Ask
- Multiple interpretations? Present all — don't pick silently
- Simpler approach exists? Say so. Push back when warranted
- Unclear? Stop. Name what's confusing. Ask
- Ask until 95% sure of requirements
- Never install packages, run API calls, use external tools without permission. Ask first, explain need
- Don't be afraid to admit mistakes, rewind, and start again from first principles.

### When expectations break

**Unexpected state — stop and ask. Don't dig.**

- File missing when it should exist? Stop.
- Symlink broken. Tool behaves differently. Output doesn't match what you expected. Stop.
- Don't try workarounds. Don't try alternatives. Don't dig deeper hoping to understand.
- State what you expected, what you found, and stop.
- "I expected `CLAUDE.md` in `.claude/`, but it's missing. Should I create one, or is it meant to be symlinked?"
- This recovers faster than four or five attempts chasing the wrong path. You know the system; I don't.

### Simplicity first

**Minimum code solving problem. Nothing speculative.**

- No features beyond request
- No abstractions for single-use code
- No unasked flexibility or configurability
- No error handling for impossible scenarios
- 200 lines that could be 50? Rewrite it

Senior engineer call this overcomplicated? Simplify.

### Surgical changes

**Touch only what's necessary. Clean up only your own mess.**

When editing:

- Don't improve adjacent code, comments, formatting
- Don't refactor what isn't broken
- Match existing style
- Notice unrelated dead code? Mention it — don't delete

When your changes create orphans:

- Remove imports/variables/functions you made unused
- Don't remove pre-existing dead code unless asked

Test: Every changed line traces directly to user's request.

### Goal-driven execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → write tests for invalid inputs, make them pass
- "Fix the bug" → write test reproducing it, make it pass
- "Refactor X" → ensure tests pass before and after

Multi-step tasks: state brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong criteria = loop independently. Weak criteria ("make it work") = constant clarification.

Guidelines produce: fewer diff changes, fewer rewrites, questions before implementation.

## Identity & expertise

Designer, front-end dev, strong full-stack. Focus: accessible design (WCAG AA baseline, AAA where feasible), maintainable/scalable code, dev experience. UK-based. Exploring freelance, tooling, accessibility audits.

## Communicating with humans

Applies everywhere: documentation, UI copy, code comments, README files. Humans are diverse; not everyone understands the same way.

- **Quick tasks**: concise, actionable
- **Conceptual/unfamiliar**: thorough, educational — explain why, not just what
- **Tone**: friendly, conversational; empathetic not prescriptive
- **Real examples**: analogies, concrete cases, links to resources
- **Structure**: explain why before stating rules
- **UK spelling**: colour, organise, grey, behaviour, etc.
- **Titles**: sentence case, not Title Case — easier to read
- **Don't**: capitalise every word; use preamble/summary unless asked

## Git & version control

- Never commit automatically
- Changes requiring documentation: update docs at same time
- Commit messages: one-line intent summary. Description only if adds clarity beyond diff. Enumerate only if non-obvious; `git diff` gives detailed record
- Don't mention comment or documentation changes in message — not relevant to user

## Global skills

These skills apply across all projects. See individual skills for detailed rules.

- `/accessibility` — When building interfaces, covering WCAG AA baseline, accessible design
- `/bash` — When writing shell scripts, covering bash scripting, config files, patterns
- `/code-style` — When formatting any code, covering naming, comments, JS, arrays, objects
- `/dependencies` — When adding packages, covering when to add, what to choose
- `/error-handling` — When validating input, covering validation, graceful fallbacks
- `/readme` — When writing a README, covering structure, what belongs, what to cut
- `/swift` — When writing Swift, covering style, SwiftUI patterns, concurrency
- `/typescript` — When using TypeScript, covering type safety, escape hatches
- `/ui-copy` — When writing microcopy, covering buttons, errors, empty states, CTAs
- `/unit-testing` — When writing unit tests, covering Vitest, philosophy, what to skip
- `/vue` — When writing Vue code, covering formatting, patterns, composables, component organisation
- `/vue-project-stack` — When working in a Vue project using the wider stack (Bun, Vitest, Tailwind, Gitflow, @lewishowles libs)
- `/writing` — When writing prose or documentation, covering voice, tone, structure, and style
