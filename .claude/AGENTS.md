# Central Claude Configuration Repository

This is the source of truth for all Claude Code configuration. Skills, hooks, plugins, and documentation live here and are symlinked to `~/.claude` for global access.

## Structure

- `skills/` — skill library (15+ skills, each with frontmatter + content)
- `hooks/` — Claude Code hooks for auto-triggering skills, file patterns, etc.
- `plugins/` — custom plugins (caveman, etc.)
- `commands/` — user-defined slash commands (if needed)
- `docs/` — supplementary documentation

## Symlinking

Symlinks distribute files to global location so skills/hooks are available across all projects:

```bash
ln -s /Users/lewis/Dev/Configuration/Claude/skills ~/.claude/skills
ln -s /Users/lewis/Dev/Configuration/Claude/hooks ~/.claude/hooks
# etc.
```

**Important**: Edit files HERE in the project, not in `~/.claude`. The symlinks point FROM global TO here.

## Skill Structure

Each skill is a directory with `SKILL.md`:

```
skills/vue/
├── SKILL.md          # frontmatter + content
└── (no other files)
```

Frontmatter includes:

- `name` — skill identifier
- `description` — when to use this skill
- `related-skills` — list of complementary skills (auto-invoked)

## Adding a Skill

1. Create `skills/new-skill/SKILL.md`
2. Add frontmatter with name, description, related-skills
3. Write content (reference, not prescription)
4. Update hook configuration if needed

## Hook System

Hooks auto-invoke skills based on context. See individual hook files for how they work.

Key hooks:

- skill-autotrigger — invokes skills on UserPromptSubmit based on task type
- skill-file-trigger — invokes skills when opening/editing specific file patterns

## Editing Workflow

1. Edit source file HERE in `/Users/lewis/Dev/Configuration/Claude/`
2. Symlink picks up changes immediately
3. Changes available globally via `~/.claude/`
4. Commit changes to this repository

Don't edit `~/.claude/` directly — changes will be overwritten.
