---
name: session-management
description: Use this skill when saving/resuming work sessions across Claude Code restarts. Covers session snapshots, context serialization, and resuming from checkpoints.
related-skills:
  - code-style
---

# Session management

Save and resume Claude Code sessions to preserve context across restarts.

## /save-session

Snapshot current session state:

```
/save-session "feature: add dark mode toggle"
```

Creates a checkpoint with:
- Conversation history
- File state (recently opened, edited)
- Current task context

## /resume-session

List and resume previous sessions:

```
/resume-session
```

Shows saved snapshots. Select one to restore context and continue.

## When to use

- **Long tasks spanning days** — save before stopping
- **Complex refactors** — checkpoint before major changes
- **Multi-file edits** — resume exactly where you left off
- **Context-heavy work** — don't lose conversation history

## Naming sessions

Use descriptive names that capture intent:

- ✅ "fix: auth bug in login flow"
- ✅ "feature: add export to CSV"
- ✅ "refactor: extract API client"
- ❌ "work on stuff"

Clear names let you find the right session quickly later.

## Session limits

Claude Code keeps recent sessions. Very old snapshots may be cleaned up automatically.

For permanent records, commit work to git instead.
