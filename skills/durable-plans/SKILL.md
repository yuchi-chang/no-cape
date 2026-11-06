---
name: durable-plans
description: Use when planned work will outlive the current session — persisting a plan to disk, resuming work from an on-disk plan, or landing changes a plan file describes
---

# Durable Plans

Context evaporates when the session ends. A plan that must outlive the session lives on disk — the file is the handoff, not anyone's memory of it.

## When to persist — and when not to

Persist when any of these hold:

- The work won't finish in this session.
- Several changes are in flight and would blur together.
- A human or another agent must review or resume the work.

Otherwise don't. A plan file for single-session work is process theater — the harness's plan mode already covers it.

## The structure

One file per change, `docs/plans/<change-name>.md` (follow the project's existing convention if it has one). Four sections:

1. **Goal** — what this change delivers; success criteria.
2. **Approach** — the chosen route and why; rejected alternatives and why.
3. **Tasks** — a checklist to the [[writing-solid-plans]] bar: exact paths, real code, no placeholders. `[ ]` / `[x]` status marks.
4. **Decision log** — dated entries for every deviation: what changed and why.

## Keeping it honest

- **Resuming:** read the plan first, then verify it against the code before trusting it — commits may have landed without plan updates. The code wins every conflict.
- **Landing a task:** tick its checkbox in the same commit as the change, so status rides along instead of drifting.
- **Deviating:** update the plan in the same commit that diverges from it. A plan that silently diverged misleads every later reader.

## Retiring

A landed change's plan is a liability pretending to be documentation:

- Fold decisions worth keeping (architecture choices, rejected alternatives) into the project's permanent docs — [[durable-knowledge]] says which ones qualify, where they go, and in what form.
- Then delete the file — or move it to `docs/plans/archive/` if the project keeps history. Git preserves it either way.

Don't maintain a parallel spec of the whole system: it duplicates what code, tests, and docs already say, and it rots. Plan files describe changes in flight; they retire when the change lands.

## Smell test

If a fresh session resumed the work by re-deriving state from git log and memory instead of opening a plan file, this skill was skipped one session earlier.
