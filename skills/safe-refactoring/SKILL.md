---
name: safe-refactoring
description: Use when restructuring, renaming, moving, or extracting code that already works — before making the first edit
---

# Safe Refactoring

A refactor changes structure, never behavior. The moment behavior changes, it's not a refactor — split it out.

## Rules

- **Never mix restructure and behavior change.** Behavior-preserving moves in one commit; behavior changes in another. A reviewer must be able to skim the refactor commit and trust it's mechanical.
- **Green before, green between, green after.** Run tests before starting (know the baseline), after each mechanical step, and at the end. If tests were already red, stop and report — new breakage and old breakage become indistinguishable.
- **Find every reference before renaming or removing.** Grep beyond what the compiler sees: string references, reflection, config files, serialized field names, SQL, API routes, environment variables, docs. The compiler only checks the typed half.
- **Public surface needs a transition.** Anything external callers depend on (API endpoint, exported function, published schema) gets a deprecation period or an adapter, not an in-place break.
- **Small steps that each leave the build working.** If you must hold five files in your head to know it still compiles, the step is too big.

## Stop rules

- A "rename" starts requiring logic edits → behavior is changing; stop and separate the two.
- Tests fail mid-refactor in a way you didn't predict → you misunderstood a dependency; investigate before continuing, don't patch around it.

## Smell test

Could someone review the diff and verify it's behavior-preserving *without running it*? If not, the steps are too large or the concerns are mixed.
