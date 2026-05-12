# Hooks

Hooks are shell scripts that Claude Code runs automatically at specific points in a session. They're registered in `settings.json` under the `hooks` key and live in `hooks/`.

## Registered hooks

| Hook | Event | Behaviour on failure |
|------|-------|----------------------|
| `skill-autotrigger.sh` | Every user message (`UserPromptSubmit`) | Exits cleanly if `jq` is missing — but blocks the prompt and reports an error if `jq` is installed and the hook itself errors |
| `check-claude.sh` | Before every tool use (`PreToolUse`, all tools) | Blocks with exit code 2 and tells Claude to stop until `CLAUDE.md` is present |
| `skill-file-trigger.sh` | Before every Write or Edit (`PreToolUse`, `Write\|Edit`) | Silently skips if `jq` is missing — writes are never blocked |
| `pre-stop-checks.sh` | When Claude finishes (`Stop`) | Runs lint and unit tests; pauses Claude and displays output if either fails |

### skill-autotrigger.sh

Fires on every user message. Reads the prompt text, pattern-matches it against each skill's domain keywords, and injects an `additionalContext` instruction into Claude's context telling it to invoke the matched skills before responding.

**Continuation prompts:** when the user sends something ambiguous ("yes", "continue", "next step"), Claude decides what to write independently. The hook detects these and injects *all* skills so Claude can pick whichever apply. False positives (loading unused skills) are acceptable; missing a skill is not.

**Requires:** `jq` — `brew install jq`. The hook hard-fails and blocks the prompt if `jq` is missing.

### skill-file-trigger.sh

Fires whenever Claude is about to write or edit a file. Checks the file extension and injects a skill reminder. Complements `skill-autotrigger.sh` for cases where Claude independently decides what to create.

**Limitation:** by the time this hook fires, the file content is already planned in Claude's tool call. The reminder primarily affects subsequent edits in the same turn, not the current write.

Extension-to-skill mapping:

| Extension / filename | Skills injected |
|----------------------|----------------|
| `.swift` | `code-style`, `swift`, `macos` |
| `.vue` | `code-style`, `vue`, `vue-project-stack` |
| `.ts`, `.tsx` | `code-style`, `typescript` |
| `.js` | `code-style` |
| `.sh` | `bash` |
| `.md` | `code-style`, `writing` |
| `README.md` | + `readme` |
| `vite.config.ts` / `.js` | + `vite-patterns` |
| `*.test.js`, `*.spec.ts`, etc. | + `unit-testing` |
| `*.e2e.js`, files in `e2e/` | + `e2e-testing` |
| Files in `adr/` or `0001-*.md` | + `architecture-decision-records` |

**Requires:** `jq` — silently skips if missing.

### check-claude.sh

Runs on every tool use, but only once per session (uses a temp flag file keyed to the session ID). Checks that `.claude/CLAUDE.md` exists in the current working directory. If not, it blocks Claude with exit code 2 and instructs it to tell the user to run `/init` rather than attempting workarounds.

### pre-stop-checks.sh

Runs when Claude finishes a response. Checks for a `package.json` (skips silently if absent — not all projects are frontend projects). If present, it runs `npm run lint` and `npm run test:unit:run` if those scripts are defined. On failure, outputs a JSON pause signal with the error output, preventing Claude from stopping until the issues are resolved.

## How skill triggering works

Skills aren't invoked automatically by Claude Code — they need an explicit `Skill` tool call. The trigger hooks bridge that gap by injecting a strong instruction into Claude's context at the right moment.

Neither hook is perfect: `skill-autotrigger` only analyses the typed prompt, not what Claude plans to write; `skill-file-trigger` fires after the content is planned. Together they cover most cases without any manual invocation.

To invoke a skill manually: type `/skill-name` in Claude Code (e.g. `/vue`, `/typescript`).

## Adding a new hook

1. Create the script in `hooks/` — make it executable (`chmod +x`)
2. Register it in `settings.json` under the appropriate event key
3. Document it in the table above

Event types supported by Claude Code: `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `Stop`, `SessionStart`.
