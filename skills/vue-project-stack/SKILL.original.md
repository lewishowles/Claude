---
name: vue-project-stack
description: Use this skill when working in a Vue project that uses the wider Lewis Howles stack. Covers the chosen tools (Vue 3 with script setup, TypeScript, Tailwind, Vitest, Bun, Gitflow, GitHub Pages) with the *why* for each so suggestions can flag outdated choices, plus the @lewishowles/helpers and @lewishowles/components libraries that replace common packages.
related-skills:
  - vue
  - code-style
  - dependencies
---

# Vue project stack

The stack used across Vue projects in this configuration. Each choice carries a *why*. If a better option emerges or one of these tools becomes outdated, the rationale tells you whether the original reason still holds — and whether to suggest an alternative.

## Core stack

- **Vue 3 with `<script setup>`, Composition API**
  *Why:* better TypeScript inference than Options API, smaller runtime, easier to extract composables, `<script setup>` removes boilerplate
- **TypeScript-first**
  *Why:* catches errors at edit time, drives IDE autocomplete; pair with runtime validation for any external/untyped data
- **Tailwind (utility-first)**
  *Why:* colocates styles with markup, removes class-naming overhead, fast to iterate, easy to audit consistency
- **Vitest**
  *Why:* Vite-native (no dual config), fast watcher, modern API; the natural pairing for Vue 3 + Vite projects
- **Bun (package manager)**
  *Why:* fast installs, npm-compatible registry, drop-in replacement; if a specific workflow breaks, npm/pnpm remain valid fallbacks
- **Gitflow branching**
  *Why:* release/develop separation suits the static-hosted deployment style of these projects
- **GitHub Pages**
  *Why:* free static hosting, simple branch-based deploy, no extra infrastructure to maintain
- **Node.js (server-side) / vanilla JS (browser, VS Code extensions)**
  *Why:* Node for tooling and scripts; vanilla JS where bundle size or runtime constraints matter (e.g. VS Code extensions, embedded scripts)

## Helpers library — `@lewishowles/helpers`

Replaces ad-hoc utility packages with a single internal collection. Check this library before writing a helper or adding a new utility dependency. Full docs in the package's GitHub README.

Import path: `import { getNextIndex } from "@lewishowles/helpers/array"`

Key helpers:
- Type guards: `isNonEmptyArray`, `isNonEmptyString`, `isNonEmptyObject`, `isNonEmptySlot`
- Validation: `validateOrFallback`, `validateField`
- Object access: `get`, `set`, `forget`, `deepMerge`, `pick`, `omit`, `pluck`
- Array operations: `getNextIndex`, `chunk`, `compact`, `unique`
- Strings: `StringManipulator`
- URLs: `getUrlParameter`, `updateUrlParameter`
- Vue: `runComponentMethod`

If a needed helper is missing, discuss whether to add it to `@lewishowles/helpers` rather than inlining or pulling in a third-party dependency.

## Component library — `@lewishowles/components`

Opinionated UI component library with accessibility baked in. Documented at [components.howles.dev](https://components.howles.dev/) — reference the live docs, don't rely on memory. If a needed component is missing, discuss adding it there rather than inventing one-off duplicates.
