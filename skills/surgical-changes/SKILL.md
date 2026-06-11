---
name: surgical-changes
description: Use when editing existing code — bug fixes, small features, or any change inside a codebase you didn't just write
---

# Surgical Changes

Change only what the task requires. The diff is the product: every line in it should trace back to the request.

## Rules

- Touch only the lines the task needs. No drive-by renames, reformatting, import reordering, or "while I'm here" cleanups.
- Match the surrounding code — its naming, comment density, idioms, and formatting — even where you'd write it differently. A patch that mixes styles is harder to review than either style alone.
- Don't upgrade dependencies, bump versions, or change config as a side effect of an unrelated task.
- Introduce new helpers or abstractions only when this task needs them, not because the code "would benefit".

## When you see something worth improving

Report it, don't fix it:

> "Done. Unrelated: `parseConfig()` swallows errors — want me to fix that separately?"

This keeps each change reviewable and leaves scope decisions with the user. If they say yes, it's a separate change.

## Legitimate exceptions

- The mess directly blocks the task (the bug can't be fixed without restructuring) — say so explicitly when reporting.
- The user asked for cleanup.
- Project tooling (linter, formatter) forces the change.

## Smell test

Before finishing, reread the diff and ask of each hunk: "would a reviewer understand why this changed, given the task?" If a hunk needs justification beyond the request, revert it or surface it separately.
