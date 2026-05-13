---
name: session-management
description: Use this skill when saving or resuming Claude Code sessions, starting meaningful multi-session work, or tracking progress across sessions.
related-skills:
  - code-style
---

# Session management

## Built-in save/resume

Claude Code can snapshot and restore session state:

```
/save-session "feature: add dark mode toggle"
/resume-session
```

Saves conversation history, recently opened files, and task context. Use for long tasks, complex refactors, or any work you'll pick up later. Name sessions descriptively — "fix: auth bug in login flow" not "work on stuff".

Old snapshots may auto-clean. For permanent records, commit to git instead.

## PROGRESS.md — tracking meaningful work

For multi-file, multi-session, or significant-scope work, maintain a `PROGRESS.md` in the project's `.claude/` directory. This is the persistent record that survives session changes.

**When starting work:**
1. Check for `.claude/PROGRESS.md`
2. If present — read it before doing anything else; it has architecture, decisions, and session history
3. If absent and the work is significant — create it from `.claude/templates/PLAN.md.template`

**Structure:**

```markdown
# [Work title]

**Started:** [date]  **Status:** planning | in-progress | blocked | complete

## Legend
- `[ ]` not started  `[~]` in progress  `[x]` done  `[-]` skipped

## Phase 1 — [name]
- [ ] **1.1 Step** — verify: [how to confirm done]
- [x] **1.2 Step** — actual outcome if it diverged from plan

## Purpose / Context / Architecture / Key files / Decisions
[reference sections — keep these below the checklist]

## Validation
[observable outcomes that confirm the work is complete]

## Discoveries
[unexpected findings, hidden constraints, useful insights — add as you go]

## Session notes
### [Date]
**Completed:** [tasks done]  **Next:** [what to pick up]
```

**When to update:** After completing a significant task — update the checklist and append a session note. Don't wait until session end; `SessionEnd` doesn't fire reliably when conversations are archived in the desktop app.

## Token efficiency

- Skip plan mode for single-file, single-line, or trivial edits (<20 lines)
- Batch edits in one session — amortise system context across multiple changes
- Use `claude-mem:smart-explore` for large codebases instead of broad reads
- Try `grep`/`find` first before spawning agents for targeted lookups

## Goal-driven execution

Transform tasks into verifiable goals before starting:

- "Add validation" → write tests, make them pass
- "Fix bug" → reproduce with test, make it pass
- "Refactor X" → tests pass before and after

Multi-step tasks: state plan with verification:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
```

Strong criteria = independent loops. Weak criteria = constant clarification.
