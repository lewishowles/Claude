---
name: error-handling
description: Use this skill when writing functions that accept parameters, making API calls, or handling any response data — even if errors aren't the main topic. Covers input validation with helper utilities, API response validation, graceful fallbacks, and what NOT to handle. Apply proactively when writing JavaScript/TypeScript functions.
---

# Error handling

## Input validation

- In Javascript, use helpers for basic validation of input types (`isNonEmptyObject`, `isNonEmptyArray`, etc.)
- Critical parameters: validate and early return if invalid
- Non-critical parameters: provide defaults in function signature, no explicit check needed
- For uncertain types, use `validateOrFallback` or similar helpers

## API responses

- Validate API responses structurally (check if object, if array, etc.)
- Don't validate deep structure — use `get` helper to safely navigate missing properties
- If property is missing, `get` returns null and, based on what we're doing, decide how to continue.

## Graceful fallbacks

- Handle gracefully when possible. If there's a "no items to show" construct, this will be used in the UI.
- If something fails that the user cannot resolve, show fallbacks.

## Don't handle

- Errors for structurally impossible scenarios (e.g., can't fail if function call succeeds)
- Errors for cases where the entire flow would need to change (better to crash loudly)

## Logging

- Don't include verbose logging by default, as it adds a lot of noise to code for little benefit.
