---
name: clarifying-requirements
description: Use when starting a new feature, component, or project whose requirements are underspecified or ambiguous — before designing or writing code
---

# Clarifying Requirements

## First: has the approach been chosen?

Clarifying details inside an approach assumes the approach is settled. For a new project or a significant feature, confirm that first — [[exploring-approaches]] runs *before* this skill, precisely to stop you from refining a branch nobody checked was the right one.

Before asking your first question, check: was the project's fundamental shape ever on the table, or did you walk straight into the user's (or your own) first idea? Signs it was skipped: the goal hides a fork into *different projects* (cloud API vs self-host vs SaaS; batch vs realtime), the user stated a preference you accepted without examining, or your questions all live inside one unexamined architecture. If so, stop and run [[exploring-approaches]] now — then come back here.

Skip this check when the approach is genuinely not in question: a bug fix, a small change to existing code, or a task whose shape has only one reasonable form. The point is to catch the unexamined fork, not to ceremonially loop through a sibling skill before every clarification.

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
