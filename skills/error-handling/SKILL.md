---
name: error-handling
description: Use this skill when validating inputs, API responses, async results, and error paths in *.js, *.ts, *.vue, and service code. Covers guard clauses, helper utilities, response validation, graceful fallbacks, and what not to handle. Pair with typescript when types are involved.
---

# Error handling

## Input validation

- JS: use helpers for basic input type validation (`isNonEmptyObject`, `isNonEmptyArray`, etc.)
- Critical params: validate + early return if invalid
- Non-critical params: default in signature, no explicit check
- Uncertain types: use `validateOrFallback` or similar

## API responses

- Validate structurally (is object, is array, etc.)
- Don't validate deep structure — use `get` helper to safely navigate missing props
- Missing prop: `get` returns null, decide how to continue based on context

## Graceful fallbacks

- Handle gracefully when possible. "No items" constructs surface in UI.
- User can't resolve failure → show fallback

## Don't handle

- Structurally impossible failures
- Cases where entire flow must change — crash loudly instead

## Logging

- No verbose logging by default. Noise, little benefit.
