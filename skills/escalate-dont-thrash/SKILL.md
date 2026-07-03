---
name: escalate-dont-thrash
description: Use when repeated attempts at the same problem keep failing without producing new evidence — before trying another variation of the last fix
---

# Escalate, Don't Thrash

A problem you can't solve is recoverable. An hour of confident thrashing is not. When attempts stop producing new information, stop producing attempts.

## The trigger

The signal is not the failure count — it's what the next idea is made of. If the next attempt is a **variation of the last one** rather than a **new hypothesis built from new evidence**, you are thrashing. That state is often visible by the second failure and certain by the third. (root-cause-debugging's "3 failed fixes → stop" rule lands here: this skill is what "stop" actually means — and it applies to any repeated-failure loop, not just debugging.)

Other tells, name them honestly when they appear:

- "This should work now" — said for the third time.
- Each fix reveals a new break somewhere else.
- The evidence contradicts itself and you're picking which half to believe.
- Editing code you don't fully understand "to see what happens."

## The move

1. **Stop.** No third variation. No "one more small change."
2. **Leave the tree no worse than you found it.** Revert edits that didn't help; keep only changes you can justify on their own.
3. **Write the handoff summary:**
   - The symptom: exact error, reproduction command, expected vs. actual.
   - Verified facts — each with the evidence that established it.
   - Hypotheses eliminated — and what ruled each one out.
   - The failed attempts — what each changed and how it failed.
   - What remains unexplored or suspicious.
4. **Recommend escalation explicitly:** a stronger model, a human pair, or a fresh session seeded with the summary. Say which and why.

## Why this is a win, not a defeat

This converts an unbounded failure into a bounded one: ten minutes to a clean handoff instead of an hour of accumulating damage. And the summary is a real deliverable — investigation compounds. Whoever picks the problem up starts at the frontier you reached, not at zero.

The worst outcome is not "I couldn't solve it." It's "I couldn't solve it, the code is worse, and nobody can tell what was tried."
