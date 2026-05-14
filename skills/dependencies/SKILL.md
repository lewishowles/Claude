---
name: dependencies
description: Use this skill when evaluating package installs, dependency changes, package.json edits, npm install, bun add, yarn add, and library recommendations. Covers when to add packages, what to avoid, @lewishowles/helpers, @lewishowles/components, and when to discuss before installing.
---

# Dependencies

## When to add packages

Add only for complex work needing real skill/effort:

- Framework/testing framework (Vue, Vitest, Tailwind)
- Authentication (JWT, OAuth handling)
- Specialised libraries (not trivial utilities)

## When NOT to add packages

- Single-function or trivial packages
- JS helper libraries — `@lewishowles/helpers` replaces them (discuss adding to helpers if missing)
- UI component libraries — `@lewishowles/components` replaces them (discuss adding to components if missing)
- Simple data manipulation — write in project or add to `@lewishowles/helpers`

## Before adding

Always discuss with team/user. Explain:

- What it solves
- Why worth dependency
- What existing approach would be

Never add without discussion/permission.
