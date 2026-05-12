---
name: code-style
description: Use this skill on every code change — even small snippets. Covers tabs vs spaces, quote style, semicolons, naming conventions, JSDoc comments, and documentation patterns. This is the baseline style guide for all code.
related-skills:
  - vue
  - vue-project-stack
  - swift
  - typescript
---

# Code style

**This is the baseline for all code, all projects, all languages.** When working in a specific language or framework, also consult the language-specific skill: `/vue` for Vue files, `/swift` for Swift, `/typescript` for TypeScript. These extend code-style with language-specific patterns; code-style provides the foundation.

## Formatting

- Tabs; double quotes; always semicolons
- No trailing spaces, no mixed tabs/spaces
- Comma-dangle always multiline; quote props consistent-as-needed
- No one-liner `if` statements — full block format with braces, body on new line
- Blank lines separate logical steps in functions

## Naming & imports

- Never abbreviate event parameter names — `event` not `e`
- Prefer "user" over "consumer"
- Destructured keys and imports: alphabetical

## Comments & documentation

- Every top-level variable: single-line comment describing what it does — all languages
- Functions: Include JSDoc or equivalent blocks. Parameters: `@param  {type}  name` format, description indented four spaces on next line
- Repeated inline logic? Extract into named functions with JSDoc or equivalent, don't duplicate
- No banner/divider comments (`// ---`) — use JSDoc or equivalent and blank lines for structure
- In-code comments explain why, not what.
- Block comments for functions explain the purpose, and include the why.
