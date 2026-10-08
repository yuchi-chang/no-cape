---
name: blast-radius
description: Use when changing a condition, guard, filter, default, or allow/deny rule that existing code already reaches — before editing it
---

# Blast Radius

A condition has two sides and the code only shows one. Before changing who passes, find out who is passing today.

## Rules

- **Enumerate producers, not just callers.** Grep every place that builds the input the condition reads — the model, the flag, the enum value. Direct callers are half the list.
- **Classify every path under the new condition**: still passes / now blocked / unreachable. A "now blocked" the request didn't ask for is a finding — surface it before editing, not after.
- **Prefer evidence over reading.** If logs exist, query who hits the branch today, grouped by source. A branch commented "not supported" that fires thirty times a day is the one you'll break.
- **Implicit pass-through is a dependency.** Code that reaches the permissive branch by accident — no flag, no comment — is still relied on. Make it explicit in the same change (a flag, an enum case) instead of leaving it to fall through.
- **Test the paths, not the field.** A test on the model proves nothing about the flows. One test per affected path, asserting its outcome under the new condition.

## Stop rules

- You can't name who reaches the branch → you're not ready to change it.
- The request's literal reading blocks a path that's live in production → stop and report the conflict. Don't implement the letter of the request.

## Smell test

Can you list, from memory, every path that will now take a different branch, and for each say whether the user asked for that? Any entry that's "probably fine" means you haven't finished.
