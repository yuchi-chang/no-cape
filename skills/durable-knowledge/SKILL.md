---
name: durable-knowledge
description: Use when a session learns a fact about the project the hard way — a convention, invariant, environment quirk, or wrong premise that cost a round trip — before the fix lands or the session ends
---

# Durable Knowledge

A fact that cost a round trip to learn costs it again next session unless it is written where the next session reads first. The fix goes in git; the *trap* goes in the project's instructions file.

## What qualifies

Record it when all three hold:

- **The code misleads.** A fresh session reading the code or its comments would make the same wrong assumption: "row 0 is the south edge", "model z is negated", "the sampler runs at 2×".
- **It was learned by being wrong first.** A failed attempt, a reverted change, a correction from the user. Facts found on the first read don't need rescuing.
- **It is stable.** A convention, invariant, environment quirk, or decision — not state in flight ([[durable-plans]]), not the fix itself.

Don't record what code, tests, or docs already say plainly, or anything you could not re-verify.

## Where

- The project's agent instructions file (`CLAUDE.md`, `AGENTS.md`, or the harness equivalent) for anything a session needs before its first edit. One to three lines per entry — the file loads every turn; every line competes with the task.
- A `docs/` page plus a one-line pointer from the instructions file when the detail runs longer (a coordinate system with a diagram).
- The harness's personal memory, never the repo, for facts about *you*.

## The entry

Three parts, so a later session can re-verify instead of trust — a recorded fact is a claim, not evidence ([[root-cause-debugging]]):

1. The fact, stated as the convention it is.
2. The trap: the wrong assumption and how it failed.
3. How to confirm: the file, test, or one-line experiment that proves it.

`Grid rows run south→north; row 0 is the southern edge. Trap: the tile loader reads top-down, so the first fixture rendered mirrored. Confirm: tests/grid_orientation.test.ts.`

## When

At the moment of discovery, in the same commit as the fix — the same rule as [[durable-plans]]. "I'll write it up at the end" is how it gets lost: by then it feels obvious.

## Smell test

If the next session re-derives something this session already paid for, this skill was skipped one session earlier.
