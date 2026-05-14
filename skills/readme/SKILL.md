---
name: readme
description: Use this skill when writing or editing README.md, README, and getting-started documentation. Covers what belongs in a README, what to cut, practical structure, and avoiding fluff that does not help the average reader. Pair with writing for voice and tone.
---

# README

README job: help person who just landed — what is it, why exist, how use. Quick-start guide, not marketing page.

## What belongs

- **Purpose** — one or two sentences: what this is, who it's for
- **Setup / install** — concrete steps reader can copy. macOS-only? Say once. No Windows alternatives that don't exist
- **Usage** — most common one or two uses, with examples
- **Where to look next** — links to deeper docs, contributing guide, license

## What doesn't belong

- Marketing prose, long origin stories, repeated value-prop sentences
- Step-by-step for unsupported platforms
- Long feature lists — link to dedicated docs file instead
- Internal-only notes (decisions, history, TODOs) — commit messages, ADRs, per-project docs

## Tone

- Friendly, conversational, second-person ("you'll need…")
- Short steps; concrete commands; no preamble before sections
- Sentence-case headings (`## Getting started`, not `## Getting Started`)
- UK spelling

## Quick checklist before publishing

- Can new reader run setup from clean machine using only what's here?
- Platform assumptions stated explicitly?
- Cut anything that doesn't help average reader?
