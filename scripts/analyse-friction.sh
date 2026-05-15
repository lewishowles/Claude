#!/usr/bin/env bash

set -euo pipefail

log_file="${1:-$HOME/.claude/logs/friction.log}"

if [ ! -f "$log_file" ]; then
	printf 'No friction log found at %s\n' "$log_file"
	exit 0
fi

awk -F '\t' '
	NF >= 4 {
		key = $2 FS $3 FS $4
		counts[key]++
	}

	END {
		for (key in counts) {
			print counts[key] FS key
		}
	}
' "$log_file" | sort -rn
