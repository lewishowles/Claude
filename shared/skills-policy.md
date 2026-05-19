## Skill use policy

Skills are authoritative when their trigger conditions match. Before coding, editing prose, changing config, or reviewing files, inspect the task and file paths, then load and use the matching skills needed for the current task type. If multiple skills match, use all relevant skills — especially `code-style` plus language/framework skills. Do not wait for explicit slash-command invocation.

Minimise repeated skill reads:

- Do not re-read the same skill file within a continuous session unless the task type changes, the user explicitly asks, or you need a specific detail not already loaded.
- Reusing an already-read skill is the default. State briefly that you are continuing to apply it instead of opening it again.
- Prefer loading the smallest relevant skill set. Do not load broad adjacent skills speculatively.
- If a platform requires skill invocation every turn, invoke only the required matching skill and avoid opening long reference files unless needed.
- Summarise remembered skill constraints in your own words; do not paste or quote long skill sections back to the user.
- If a skill conflicts with the user's token-budget preference, follow the user's preference and note the tradeoff briefly.

The goal is strict compliance without paying repeated token cost for unchanged instructions.
