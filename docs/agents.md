# Agents

This page describes Claude Code agent types. Codex also uses the word "agents" for broader concepts such as `AGENTS.md`, subagents, and runtime roles; see [docs/codex.md](codex.md) for Codex-specific notes.

Agents are specialised Claude instances that run as sub-processes, each with a focused set of tools and a specific purpose. You can spawn them via the `Agent` tool, or Claude Code spawns them automatically for certain tasks.

Agents differ from skills: a skill loads instructions into the current Claude session; an agent starts a fresh session with its own context and tool access.

## Available agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| `claude` | General-purpose catch-all. Use when no other agent fits | All tools |
| `claude-code-guide` | Questions about Claude Code features, hooks, slash commands, MCP servers, settings, IDE integrations; Claude Agent SDK; Claude API usage | Bash, Read, WebFetch, WebSearch |
| `Explore` | Fast read-only code search — find files by pattern, grep for symbols, answer "where is X defined?" | All read-only tools |
| `general-purpose` | Complex research, broad codebase questions, multi-step tasks where the right file isn't obvious upfront | All tools |
| `Plan` | Design implementation strategies — returns step-by-step plans, identifies critical files, considers tradeoffs | All read-only tools |
| `statusline-setup` | Configure the Claude Code status line setting in `settings.json` | Read, Edit |

## When to use each

**Explore** — you know roughly what you're looking for but not where. "Find all components that use `useAuth`", "which files import from `@lewishowles/helpers`". Specify search breadth: `quick`, `medium`, or `very thorough`.

**Plan** — before implementing something non-trivial. Returns a plan you can review before any code is written.

**claude-code-guide** — anything about Claude Code itself: how hooks work, what settings are available, how to configure MCP servers.

**general-purpose** — open-ended research that'll take more than three tool calls, or tasks that span the whole codebase.

**claude** — everything else.

## Spawning an agent

Agents are spawned via the `Agent` tool in Claude's context. You don't call them directly — Claude does it when appropriate, or when you ask for a specific agent by name.

```
"Use the Explore agent to find all .vue files that use the useRoute composable"
"Spawn a Plan agent to design the auth refactor before we touch any code"
```

Agents run in the foreground by default (Claude waits for the result). Set `run_in_background: true` for tasks that don't block the next step.

## Agents vs skills

| | Skills | Agents |
|-|--------|--------|
| Context | Injected into current session | Fresh session, no memory of current conversation |
| Tools | Same as current session | Defined per agent type |
| Use for | Loading standards and conventions | Independent sub-tasks, research, planning |
| Cost | Low (just context) | Higher (new session, full tool access) |
