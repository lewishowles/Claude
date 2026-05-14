---
name: vue-project-stack
description: Use this skill when working in Vue projects using the Lewis Howles stack, including *.vue, *.ts, Tailwind, Vitest, Bun, Gitflow, GitHub Pages, @lewishowles/helpers, and @lewishowles/components. Covers why each tool is used and flags outdated alternatives. Pair with vue.
related-skills:
  - vue
  - code-style
  - dependencies
---

# Vue project stack

Stack used across Vue projects. Each choice has *why*. Better option emerges or tool goes stale — rationale tells you if original reason holds, whether to suggest alternative.

## Core stack

- **Vue 3 with `<script setup>`, Composition API**
  *Why:* better TypeScript inference than Options API, smaller runtime, easier composable extraction, `<script setup>` cuts boilerplate
- **TypeScript-first**
  *Why:* catches errors at edit time, drives IDE autocomplete; pair with runtime validation for external/untyped data
- **Tailwind (utility-first)**
  *Why:* colocates styles with markup, removes class-naming overhead, fast iteration, easy consistency audit
- **Vitest**
  *Why:* Vite-native (no dual config), fast watcher, modern API; natural pairing for Vue 3 + Vite
- **Bun (package manager)**
  *Why:* fast installs, npm-compatible registry, drop-in replacement; npm/pnpm valid fallbacks if workflow breaks
- **Gitflow branching**
  *Why:* release/develop separation suits static-hosted deployment style
- **GitHub Pages**
  *Why:* free static hosting, simple branch-based deploy, no extra infrastructure
- **Node.js (server-side) / vanilla JS (browser, VS Code extensions)**
  *Why:* Node for tooling/scripts; vanilla JS where bundle size or runtime constraints matter

## Helpers library — `@lewishowles/helpers`

Replaces ad-hoc utility packages with single internal collection. Check before writing helper or adding utility dependency. Full docs in package's GitHub README.

Import path: `import { getNextIndex } from "@lewishowles/helpers/array"`

Key helpers:
- Type guards: `isNonEmptyArray`, `isNonEmptyString`, `isNonEmptyObject`, `isNonEmptySlot`
- Validation: `validateOrFallback`, `validateField`
- Object access: `get`, `set`, `forget`, `deepMerge`, `pick`, `omit`, `pluck`
- Array operations: `getNextIndex`, `chunk`, `compact`, `unique`
- Strings: `StringManipulator`
- URLs: `getUrlParameter`, `updateUrlParameter`
- Vue: `runComponentMethod`

Missing helper — discuss adding to `@lewishowles/helpers` rather than inlining or pulling third-party dep.

## Component library — `@lewishowles/components`

Opinionated UI component library, accessibility baked in. Documented at [components.howles.dev](https://components.howles.dev/) — use live docs, not memory. Missing component — discuss adding there, not one-off duplicates.
