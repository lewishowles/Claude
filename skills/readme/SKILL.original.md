---
name: readme
description: Use this skill when writing or editing a README file (README.md or similar). Covers what belongs in a README, what doesn't, structure, and the "no fluff that doesn't help the average reader" principle — example: a bash script for macOS shouldn't mention Windows alternatives that don't exist. Pair with the writing skill for voice and tone baselines.
---

# README

A README's job is to help a person who's just landed on the project — what is it, why does it exist, how do they use it. Treat it like a quick-start guide, not a marketing page.

## What belongs

- **Purpose** — one or two sentences on what this is and who it's for
- **Setup / install** — concrete steps the reader can copy. macOS-only? Say so once and don't write Windows alternatives that don't exist
- **Usage** — the most common one or two ways to use it, with examples
- **Where to look next** — links to deeper docs, contributing guide, license

## What doesn't belong

- Marketing prose, long origin stories, or repeated value-prop sentences
- Step-by-step instructions for platforms that aren't supported
- Long feature lists — link to a dedicated docs file instead
- Internal-only notes (decisions, history, TODOs) — those go in commit messages, ADRs, or per-project docs

## Tone

- Friendly, conversational, second-person ("you'll need…") works well
- Short steps; concrete commands; no preamble before each section
- Sentence-case headings (`## Getting started`, not `## Getting Started`)
- UK spelling

## Quick checklist before publishing

- Can a new reader run setup from a clean machine using only what's here?
- Are platform assumptions stated explicitly?
- Have I cut anything that doesn't help the average reader?
