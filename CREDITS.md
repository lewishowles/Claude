# Credits

This repository contains a mix of original work and content adapted from external sources. Where content was lifted or adapted, attribution lives both here and as a banner at the top of the relevant skill.

## Skills

All skills are original work unless listed below.

- `vue` — composable patterns, performance section, error capture, form validation: concepts inspired by [ECC `frontend-patterns`](https://github.com/affaan-m/everything-claude-code/blob/main/skills/frontend-patterns/SKILL.md) — MIT © 2026 Affaan Mustafa. Content written from scratch in Vue 3 idioms.
- `accessibility` — focus trap in modals, keyboard widget contract, dialog ARIA: concepts inspired by [ECC `frontend-patterns`](https://github.com/affaan-m/everything-claude-code/blob/main/skills/frontend-patterns/SKILL.md) — MIT © 2026 Affaan Mustafa. Content written from scratch.
- `swift-ui` — modified from [ECC `swiftui-patterns`](https://github.com/affaan-m/everything-claude-code/blob/main/skills/swiftui-patterns/SKILL.md) — MIT © 2026 Affaan Mustafa. Adapted to integrate existing macOS app patterns and focus on iOS 26+ / macOS 26+ `@Observable` framework.
- `vite-patterns` — modified from [ECC `vite-patterns`](https://github.com/affaan-m/everything-claude-code/blob/main/skills/vite-patterns/SKILL.md) — MIT © 2026 Affaan Mustafa. Adapted to focus on config, security, and build patterns; omitted plugin authoring and framework-specific HMR details.

<!--
When adopting external content, add an entry here in this format:

- `skill-name` — modified from [source name](url) by author, license. Notes on what was adapted.
- `skill-name` — verbatim from [source name](url) by author, license.
- `skill-name` — concept inspired by [source name](url) by author, license. Content written from scratch.
-->

## Hooks

All hooks are original:

- `skill-autotrigger.sh` — UserPromptSubmit hook, pattern-matches prompts to inject skill reminders
- `skill-file-trigger.sh` — PreToolUse hook, maps file extensions to relevant skills
- `pre-stop-checks.sh` — Stop hook running `npm run lint` and `npm run test:unit:run` before session close

## Enabled plugins

Listed in `settings.json` under `enabledPlugins`:

- **claude-mem** — [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) — memory consolidation

## Inspirations

References consulted while designing this repository (no code or content copied):

- [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) — MIT © 2026 Affaan Mustafa — broader survey of skills, commands, agents, and hooks patterns
