---
name: typescript
description: Use this skill when working in TypeScript files (.ts, .tsx, .vue with lang="ts") or when type errors, type definitions, or generics are involved. Covers keeping types simple, when `as any` is acceptable, avoiding type gymnastics, and always explaining type errors rather than silently suppressing them.
related-skills:
  - code-style
---

# Typescript

- Avoid complex type gymnastics; manual runtime checks for external data
- Use the simplest acceptable types, not clever, overly complex types
- Prefer built-in types over framework-specific when they add no meaningful safety
- `as any` / `as unknown` acceptable as named local escapes, but smelly. May be required to do proper input validation
- Always explain why a type error occurs — don't silently fix it
