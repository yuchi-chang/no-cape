---
name: clarifying-requirements
description: Use when starting a new feature, component, or project whose requirements are underspecified or ambiguous — before designing or writing code
---

# Clarifying Requirements

Code built on guessed requirements is rework with extra steps. But interrogation is friction too: every question must earn its place.

## Question discipline

- Ask only questions whose answers would change what you build. If every plausible answer leads to the same design, don't ask — decide and state your assumption.
- **One question at a time.** A five-question dump gets shallow answers to all of them; sequential questions let each answer shape the next one.
- Prefer multiple choice: 2-4 concrete options with your recommendation first. "Which auth: (a) JWT — recommended because X, (b) server sessions, (c) OAuth-only?" beats "how should auth work?"
- Ask what the code can't tell you: purpose, users, constraints, success criteria. Don't ask what it can (existing conventions, current structure) — read those instead.

## Scope first

If the request bundles several independent subsystems ("a platform with chat, billing, and analytics"), don't refine details yet — surface the decomposition first. Each piece gets its own design cycle.

## Before building

- For non-trivial work, present a short design before code: chosen approach, key components and their boundaries, and what you deliberately left out (YAGNI).
- Propose 2-3 approaches with trade-offs when the solution space is genuinely open; lead with your recommendation. When one approach is obviously right, skip the ceremony — say so and move on.
- Design units that can be understood without reading their internals; if changing one unit's internals breaks its consumers, the boundary needs work.

## Smell test

If your first artifact was code and the requirements had more than one reasonable interpretation, this skill was skipped.
