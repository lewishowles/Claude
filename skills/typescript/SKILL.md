---
name: typescript
description: >
  Use this skill when working in TypeScript files (.ts, .tsx, .vue with lang="ts") or when type errors, type definitions, or generics are involved. Covers keeping types simple, when `as any` is acceptable, avoiding type gymnastics, and always explaining type errors rather than silently suppressing them.
related-skills:
  - code-style
---

# Typescript

- No complex type gymnastics; manual runtime checks for external data
- Simplest acceptable types, not clever/complex ones
- Prefer built-in types over framework-specific when no meaningful safety gained
- `as any` / `as unknown` OK as named local escapes, but smelly. May need for proper input validation
- Always explain why type error occurs — never silently fix