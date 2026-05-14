---
name: code-style
description: Use this skill when formatting or reviewing every code change, including *.js, *.ts, *.vue, *.swift, *.sh, config files, and small snippets. Covers tabs, double quotes, semicolons, naming, comments, and documentation patterns. Pair with language-specific skills when they match.
related-skills:
  - vue
  - vue-project-stack
  - swift
  - typescript
---

# Code style

**Baseline for all code, all projects, all languages.** Working in specific language/framework: also consult language skill: `/vue` for Vue, `/swift` for Swift, `/typescript` for TypeScript. Those extend code-style with language patterns; code-style = foundation.

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
- Functions: JSDoc or equivalent blocks. Parameters: `@param  {type}  name` format, description indented four spaces on next line
- Repeated inline logic? Extract into named functions with JSDoc or equivalent, don't duplicate
- No banner/divider comments (`// ---`) — use JSDoc or equivalent and blank lines for structure
- In-code comments explain why, not what
- Block comments for functions explain purpose and why
