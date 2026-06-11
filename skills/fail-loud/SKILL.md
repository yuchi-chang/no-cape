---
name: fail-loud
description: Use when writing error handling — try/catch blocks, fallback values, default parameters, retries, or any code path that handles failure
---

# Fail Loud

A swallowed error is a bug with a delay timer. Code that hides failure looks robust in review and detonates in production months later, far from the cause.

## Forbidden reflexes

- Empty catch blocks, or catch-log-continue when the caller can't proceed correctly anyway.
- `|| defaultValue` / `?? fallback` that masks a *failed* operation instead of handling a *legitimately absent* value.
- Catching broad exception types just to keep things running.
- Retries without a limit, or whose eventual failure is silent.
- Returning null / empty collections on internal error so downstream code limps along with wrong data.

## The rule

Every fallback is a product decision, not a defensive reflex. Before writing one, answer: **"Is the system actually correct when this branch executes?"**

- **Yes** (missing config has a documented default; an optional feature degrades) → fine. Name the decision: `DEFAULT_TIMEOUT_S = 30`, not an inline `|| 30`.
- **No** (data is now wrong, state may be corrupt, the user sees stale results) → don't catch it here. Let it propagate to a layer that can genuinely handle it, and fail with a message naming what broke and which input caused it.

## Loud vs graceful

- **Loud:** internal invariants, programmer errors, impossible states, dev/test environments. Crash early, close to the cause — that's what makes the bug findable.
- **Graceful:** validated user input, external services you don't control, network edges. Handle explicitly, log with context, and surface the degradation to the caller — don't pretend it succeeded.

## Smell test

If deleting the try/catch would make the bug *easier* to find, the try/catch is the bug.
