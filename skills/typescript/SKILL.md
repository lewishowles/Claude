---
name: typescript
description: >
  Use this skill when working in TypeScript files (.ts, .tsx, .vue with lang="ts") or when type errors, type definitions, or generics are involved. Covers keeping types simple, when `as any` is acceptable, avoiding type gymnastics, and always explaining type errors rather than silently suppressing them.
related-skills:
  - code-style
---

# TypeScript

- No complex type gymnastics; manual runtime checks for external data
- Simplest acceptable types, not clever/complex ones
- Prefer built-in types over framework-specific when no meaningful safety gained
- `as any` / `as unknown` OK as named local escapes, but smelly. May need for proper input validation
- Always explain why type error occurs — never silently fix

```typescript
import { isNonEmptyObject } from "@lewishowles/helpers/object";

/**
 * Convert untrusted API data into a safe user record.
 *
 * @param  {unknown}  rawUser
 *     The raw user object returned by the API.
 */
function normaliseUser(rawUser: unknown) {
	if (!isNonEmptyObject(rawUser)) {
		return null;
	}

	const user = rawUser as Record<string, unknown>;

	return {
		id: typeof user.id === "string" ? user.id : null,
		name: typeof user.name === "string" ? user.name : "Unknown user",
	};
}
```
