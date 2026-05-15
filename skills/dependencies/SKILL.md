---
name: dependencies
description: >
  Use this skill whenever a package installation, npm/bun add, or new dependency is mentioned or considered — even if just suggesting a library. Covers when to add packages, what to avoid, the @lewishowles/helpers and @lewishowles/components libraries that replace common packages, and when to discuss before installing.
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