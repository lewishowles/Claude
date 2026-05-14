#!/bin/bash

# This check will run on every tool use, because checks that run on session
# start cannot actually halt Claude execution. Because of that, we don't want to
# run this check more often than we need to, so create a temporary flag file
# that, if it exists, means the check was already run for this session and
# doesn't need to be repeated.
FLAGFILE="/tmp/claude-md-ok-${CLAUDE_SESSION_ID:-default}"

[ -f "$FLAGFILE" ] && exit 0

if [ ! -f ".claude/CLAUDE.md" ]; then
	echo '{"message": "⚠️ STOP. CLAUDE.md is missing from .claude/. Do NOT attempt workarounds, alternative file reads, or continuing. Tell the user: CLAUDE.md is missing — run /init first. Then wait."}'
	exit 2
fi

touch "$FLAGFILE"
