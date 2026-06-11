---
name: root-cause-debugging
description: Use when encountering a bug, test failure, regression, flaky test, or unexpected behavior — before proposing or applying any fix
---

# Root-Cause Debugging

No fix until you can state the root cause and point to the evidence for it. Fixing symptoms wastes time and breeds new bugs.

## Investigate first

1. Read the complete error message and stack trace — they often contain the answer.
2. Reproduce reliably. If you can't reproduce, gather more data instead of guessing.
3. Check what changed: recent commits, dependency updates, config, environment.
4. Trace bad values upstream to where they originate. Fix at the source, not where it crashed.

## Multi-component systems (API → service → DB, CI → build → deploy)

Don't guess which layer is broken. Add logging at each component boundary (what enters, what exits, whether env/config propagates), run once, and read the evidence to locate the failing layer. Then investigate only that layer.

## Hypothesis discipline

- One hypothesis at a time: "I think X is the cause because Y."
- Test it with the smallest possible change. Never stack multiple fixes in one attempt.
- Failed? Form a new hypothesis from the new evidence — don't pile another fix on top.

## Stop rules

- **3 failed fixes → stop.** Especially when each fix reveals a new problem somewhere else — that pattern means the architecture is wrong, not the code. Discuss before attempting fix #4.
- Catch yourself thinking "just try X and see" or "it's probably X, let me fix it" → return to investigation.

## Landing the fix

Write a test that reproduces the bug: it must fail before your fix and pass after. If investigation shows the cause is genuinely environmental or timing-dependent, document what you ruled out and add handling (retry/timeout) plus logging — but most "no root cause found" is just incomplete investigation.
