---
name: ui-copy
description: Use this skill when writing UI microcopy — button labels, error messages, empty states, tooltips, CTAs, form helper text, confirmation dialogs. Covers being specific and action-oriented, surfacing useful context, and avoiding vague filler. Pair with the writing skill for voice baselines and the accessibility skill for screen-reader-friendly phrasing.
---

# UI copy

Microcopy is the short interface text that guides users through actions. The bar is "clear in one read."

## Buttons and CTAs

- Lead with the verb — `Save changes`, not `OK`
- Be specific about what happens — `Delete account` beats `Confirm`
- Match the surrounding form: a `Sign in` form should have a `Sign in` button, not `Submit`

## Error messages

- Say what went wrong AND what to do about it — `Password must be at least 8 characters`, not just `Invalid password`
- Plain language; never expose stack traces or codes alone to users
- Don't blame the user — `That email is already taken` rather than `You entered an invalid email`

## Empty states

- Acknowledge it's empty, then point to the next action — `No projects yet. Create one to get started.`
- Avoid placeholder text that looks like data — it confuses screen readers and users with reduced cognition

## Confirmations

- Confirm with identifiable info — `User "Lewis Howles" deleted`, not just `User deleted`
- For destructive actions, restate the consequence — `Delete account? This removes 12 projects and can't be undone.`

## Helper and supporting text

- Place near the input it relates to. If the information is essential, don't hide it in a tooltip
- Keep it short; if it needs more than two short sentences, it belongs in docs
