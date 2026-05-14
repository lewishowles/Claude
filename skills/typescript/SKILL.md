---
name: typescript
description: Use this skill when writing, editing, or debugging TypeScript in *.ts, *.tsx, and *.vue files with lang="ts". Covers type errors, interfaces, generics, type aliases, simple types, when as any is acceptable, and avoiding type gymnastics. Pair with vue for Vue files.
related-skills:
  - code-style
---

# Typescript

- No complex type gymnastics; manual runtime checks for external data
- Simplest acceptable types, not clever/complex ones
- Prefer built-in types over framework-specific when no meaningful safety gained
- `as any` / `as unknown` OK as named local escapes, but smelly. May need for proper input validation
- Always explain why type error occurs — never silently fix
