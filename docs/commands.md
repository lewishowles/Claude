# Commands

Commands are typed directly into Claude Code with a `/` prefix. They fall into three categories: built-in Claude Code commands, skills (which double as commands), and plugin skills.

## Built-in Claude Code commands

These are provided by Claude Code itself and are always available.

| Command | What it does |
|---------|-------------|
| `/help` | List available commands and keyboard shortcuts |
| `/clear` | Clear the current conversation context |
| `/compact` | Summarise the conversation to free up context space |
| `/config` | Open Claude Code settings (theme, model, etc.) |
| `/model` | Switch the active model (e.g. `/model claude-sonnet-4-6`) |
| `/cost` | Show token usage and estimated cost for the session |
| `/status` | Show current session status |
| `/init` | Initialise a new `CLAUDE.md` in the current project |
| `/review` | Review a pull request |
| `/fast` | Toggle fast mode (Opus 4.6 with faster output) |
| `/vim` | Toggle Vim keybindings |
| `/bug` | Report a Claude Code bug |
| `/pr_comments` | Fetch comments from a GitHub pull request |

## Skills as commands

Every skill can be invoked manually as a command. Type the skill name with a `/` prefix.

| Command | Skill | When to use it manually |
|---------|-------|------------------------|
| `/accessibility` | accessibility | Auditing an interface for WCAG compliance |
| `/architecture-decision-records` | architecture-decision-records | Documenting a technical decision |
| `/bash` | bash | Writing a shell script or `.env` file |
| `/code-style` | code-style | Reviewing formatting before committing |
| `/dependencies` | dependencies | Evaluating a new package |
| `/e2e-testing` | e2e-testing | Writing Playwright tests |
| `/error-handling` | error-handling | Adding validation to a function |
| `/readme` | readme | Starting or editing a README |
| `/session-management` | session-management | Saving or resuming a session |
| `/swift` | swift | Working in a Swift file |
| `/swift-ui` | swift-ui | Working with SwiftUI views |
| `/typescript` | typescript | Resolving type errors |
| `/ui-copy` | ui-copy | Writing button labels or error messages |
| `/unit-testing` | unit-testing | Writing or reviewing tests |
| `/vite-patterns` | vite-patterns | Configuring Vite |
| `/vue` | vue | Working in a `.vue` file |
| `/vue-project-stack` | vue-project-stack | Working in a Vue project |
| `/writing` | writing | Writing or editing prose |

Most of these fire automatically via the trigger hooks — manual invocation is for cases the hooks don't catch, or to load a skill at the start of a session.

## Plugin commands

These come from installed plugins. See [docs/plugins.md](plugins.md) for plugin details.

### caveman plugin

Ultra-compressed communication mode — reduces token usage and response verbosity.

| Command | What it does |
|---------|-------------|
| `/caveman` | Activate caveman mode (full compression by default) |
| `/caveman-help` | Quick-reference card: all modes, skills, and shortcuts |
| `/caveman-review` | Ultra-compressed code review comments |
| `/caveman-commit` | Ultra-compressed commit message generator |
| `/compress` | Compress natural-language memory files (CLAUDE.md, todo lists, notes) |

Caveman modes: `full` (default), `lite`, `ultra`. Switch with `/caveman lite`, `/caveman ultra`. Deactivate with "stop caveman" or "normal mode".

### claude-mem plugin

Persistent cross-session memory and knowledge management.

| Command | What it does |
|---------|-------------|
| `/mem-search` | Search the persistent memory database across sessions |
| `/how-it-works` | Explain how claude-mem captures and stores observations |
| `/learn-codebase` | Prime a codebase by reading every source file — builds the memory corpus |
| `/smart-explore` | Token-optimised structural code search using tree-sitter |
| `/make-plan` | Create a detailed, phased implementation plan with documented steps |
| `/do` | Execute a phased implementation plan using subagents |
| `/pathfinder` | Map a codebase into feature-grouped flowcharts, identify entry points |
| `/knowledge-agent` | Build and query AI-powered knowledge bases from Claude sessions |
| `/babysit` | Watch a pull request or review cycle until it's ready to merge |
| `/version-bump` | Automated semantic versioning and release workflow |
| `/timeline-report` | Generate a narrative report of a project's history |
| `/wowerpoint` | Turn a document into a slide deck |

claude-mem stores observations across sessions. Use `/mem-search` to retrieve context from past work, or `/learn-codebase` when starting in an unfamiliar project.
