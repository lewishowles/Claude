---
name: architecture-decision-records
description: Use this skill when writing architectural decision records for docs/adr/*.md, adr/*.md, major refactors, framework choices, and technical decisions. Covers the what, why, context, consequences, and team-facing record of a decision. Pair with writing for prose quality.
related-skills:
  - writing
  - code-style
---

# Architecture Decision Records

ADRs document significant technical decisions: why made, what considered, consequences.

## Format

Store ADRs in `docs/adr/` or `adr/` with sequential numbering:

- `0001-use-vue-for-ui.md`
- `0002-tailwind-for-styling.md`
- `0003-vitest-for-unit-tests.md`

## Template

```markdown
# ADR 0001: Use Vue 3 for UI framework

## Status

Accepted

## Context

We need to choose a UI framework for the web application. Options considered: React, Vue, Svelte.

## Decision

We will use Vue 3 with Composition API and `<script setup>`.

## Rationale

- Smaller learning curve than React for our team
- TypeScript support is first-class
- Official ecosystem tools (Vue Router, Pinia) are well-maintained
- Composition API matches our preference for functional patterns

## Consequences

- Team must learn Vue patterns and ecosystem
- Build tooling requires Vite (our choice anyway)
- Component library must follow Vue conventions

## Alternatives Considered

### React
- Pros: larger ecosystem, more jobs
- Cons: JSX syntax, more boilerplate

### Svelte
- Pros: compiler-based, small bundle size
- Cons: smaller ecosystem, less mature

## Related Decisions

- ADR-0002: Use Tailwind for styling (pairs with Vue)
- ADR-0003: Use Vite as build tool (Vue native)
```

## When to write

- New framework or tool adoption
- Major refactor or migration
- Architectural pattern introduction (monorepo, microservices, etc.)
- Significant trade-off decisions

## Status field

- **Proposed** — under discussion
- **Accepted** — made and implemented
- **Superseded** — replaced by later ADR

## Consequences matter

Document trade-offs: gains and losses. Helps future devs understand constraints.

## Linking

Reference ADRs in code comments and docs:

```typescript
// See ADR-0001: we chose Vue for specific TypeScript + DX reasons
// Revisit if those constraints change
```
