#!/bin/bash

# Before stopping, run lint and unit tests. If either fails, pause and display
# output.

# Check if package.json exists. If it doesn't this probably isn't a frontend
# project, and we don't need to continue.
if [ ! -f "package.json" ]; then
	exit 0
fi

failed=false
errors=""

# Check if an npm script exists.
has_script() {
	if command -v jq &>/dev/null; then
		jq -e ".scripts | has(\"$1\")" package.json 2>/dev/null && return 0 || return 1
	else
		grep -q "\"$1\"" package.json 2>/dev/null && return 0 || return 1
	fi
}

# Run lint if exists
if has_script "lint"; then
	echo "Running lint..." >&2
	if ! lint_out=$(npm run lint 2>&1); then
		failed=true
		errors="$lint_out"
	fi
fi

# Run test:unit:run if exists
if has_script "test:unit:run"; then
	echo "Running unit tests..." >&2
	if ! test_out=$(npm run test:unit:run 2>&1); then
		failed=true
		if [ -n "$errors" ]; then
			errors="$errors"$'\n\n'"$test_out"
		else
			errors="$test_out"
		fi
	fi
fi

# If failed, output pause signal as JSON
if [ "$failed" = true ]; then
	jq -n --arg errors "$errors" '{
		systemMessage: ("Lint or test checks failed:\n\n" + $errors),
		continue: false,
		stopReason: "Fix errors and try stopping again"
	}'
fi

exit 0
