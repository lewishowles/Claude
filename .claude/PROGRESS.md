# Claude config improvements — Writ-inspired

**Started:** 2026-05-13  
**Project:** `~/Dev/Configuration/Claude`  
**Status:** in-progress

## Legend

- `[ ]` not started
- `[~]` in progress
- `[x]` done
- `[-]` skipped (with reason)

## Phase 1 — foundation

- [x] **1.1 Create `.claude/PROGRESS.md`** — this file
- [x] **1.2 Add skill/hook maintenance rules to `claude-config` skill** — covers when to update autotrigger + file-trigger on skill changes
- [x] **1.3 Create `templates/PLAN.md.template`** — comprehensive template shipped with project setup
- [x] **1.4 Add progress tracking workflow** — moved to `session-management` skill so it travels to all projects; `claude-config` references it

## Phase 2 — slim CLAUDE.md

- [x] **2.1 Audit CLAUDE.md rules** — classify each as keep / move-to-skill / identity context (analysis already done; see Decisions)
- [x] **2.2 Move token efficiency section** → `session-management` skill
- [x] **2.3 Move goal-driven execution section** → `session-management` skill
- [x] **2.4 Remove communicating with humans detail** — trimmed to 3 universal lines; full guidance in `writing` skill
- [x] **2.5 Verify line count** — 100 lines (down from 141); skills list accounts for 19; rule content ~80 lines

## Phase 3 — plan verification hook

- [ ] **3.1 Write `hooks/plan-verify.sh`** — `PostToolUse` on `ExitPlanMode`; warns if `## Validation` or `## Plan of work` absent from plan file
- [ ] **3.2 Register in `settings.json`**
- [ ] **3.3 Test**: exit plan mode without Validation section → warning visible; with section → silent

## Phase 4 — friction logging

- [ ] **4.1 Add friction log write** to `pre-stop-checks.sh` (or new hook) — appends timestamp + session summary to `~/.claude/logs/friction.log`
- [ ] **4.2 Write `scripts/analyze-friction.sh`** — parses log, shows top friction causes

## Phase 5 — PreWrite test-skeleton gate

- [ ] **5.1 Write `hooks/pre-write-test-gate.sh`** — detects test framework config (Vitest, Playwright, Cypress, Jest, XCTest); blocks implementation writes if no matching test file exists
- [ ] **5.2 Register in `settings.json`**
- [ ] **5.3 Test in Vitest project**: write `.ts` without test file → blocked; write `.test.ts` first → proceeds
- [ ] **5.4 Test in non-test project**: write `.ts` → no interruption

---

## Purpose

Improve the Claude configuration repo with patterns adapted from the Writ project: structural enforcement where advisory hooks fall short, a living progress-tracking system, a slimmer CLAUDE.md, and better plan templates.

## Context

Explored the Writ repo (https://github.com/infinri/Writ) and compared its enforcement model to the current setup. Current hooks are advisory (prompt-level reminders); Writ uses structural hooks that block writes until conditions are met. We identified which patterns are worth adopting at ~60 rules / solo workflow scale, and which are overkill.

Key finding: existing hooks work well after descriptions were tightened. The gap is enforcement depth — a PreWrite test-skeleton gate would catch the most common discipline slip.

## Architecture

Enforcement stays in hooks, not prompts. Three new hooks:
1. `plan-verify.sh` — warns on `ExitPlanMode` if plan file lacks required sections
2. `pre-write-test-gate.sh` — blocks implementation writes in projects with a test suite if no matching test file exists
3. Friction logging folded into `pre-stop-checks.sh` or a new flow-triggered write

Progress tracking is flow-driven (updated at task completion), not session-driven — `SessionEnd` doesn't fire reliably when conversations are archived.

`PLAN.md.template` ships with the project (copied into `.claude/templates/` on setup) — self-contained, no global path dependency.

## Key files

| File | Change |
|---|---|
| `.claude/PROGRESS.md` | New — this file |
| `templates/PLAN.md.template` | New — comprehensive plan template |
| `skills/claude-config/SKILL.md` | Added: autotrigger maintenance rule; references session-management for progress workflow |
| `skills/session-management/SKILL.md` | Add: token efficiency + goal-driven execution + progress.md workflow |
| `CLAUDE.md` | Slim to ~55–60 lines; move token/goal sections to session-management skill |
| `hooks/plan-verify.sh` | New — PostToolUse on ExitPlanMode, warns on missing sections |
| `hooks/pre-write-test-gate.sh` | New — PreWrite, test-first enforcement in test projects |
| `settings.json` | Register new hooks |

## Decisions

| Decision | Rationale | Date |
|---|---|---|
| Single `PROGRESS.md` not two files | Simpler than architecture.md + progress.md — one file easier to maintain | 2026-05-13 |
| Progress tracking in `session-management` skill | `claude-config` skill only applies in config repo; session-management travels to all projects | 2026-05-13 |
| Flow-driven updates, not SessionEnd | User archives conversations; SessionEnd unreliable in desktop app | 2026-05-13 |
| Warning not block for plan verification | Plans for small tasks are fine as-is; block would be too rigid | 2026-05-13 |
| Test gate per-project only | Global gate annoying in prototypes; detect by test config presence | 2026-05-13 |
| Template ships in `.claude/templates/` | Self-contained — no dependency on global `~/Dev/Configuration/Claude` path | 2026-05-13 |
| No RAG / Neo4j / state machine | Overkill at ~60 rules, solo workflow; bash + hooks sufficient | 2026-05-13 |

## Validation

- CLAUDE.md is ~55–60 lines; all previous rules still accessible via skills or identity context
- New plan in any project creates `.claude/PROGRESS.md` from `.claude/templates/PLAN.md.template`
- Exiting plan mode without a Validation section produces a visible warning
- Writing a `.ts` file in a Vitest project without a matching `.test.ts` is blocked with a clear message
- Writing a `.ts` file in a project without `vitest.config.ts` proceeds without interruption

## Discoveries

- `SessionEnd` hook likely doesn't fire when conversations are archived in desktop app — needs flow-driven alternative
- `skill-autotrigger` has been matching context correctly since descriptions were tightened; no changes needed there
- OpenAI codex exec plans format recommends Decision log and Surprises/Discoveries sections — incorporated into template
- Writ's core insight: enforcement belongs in the hook layer, not the prompt layer

## Session notes

### 2026-05-13
**Completed:** Phases 1 & 2 — PROGRESS.md, PLAN.md.template, claude-config skill maintenance rules, session-management skill expanded (token efficiency, goal-driven, PROGRESS.md workflow), CLAUDE.md slimmed 141→100 lines, autotrigger updated with session-management patterns  
**Next:** Phase 3 — plan verification warning hook; Phase 4 — friction logging; Phase 5 — PreWrite test gate
