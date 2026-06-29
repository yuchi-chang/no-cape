---
description: Manually load a no-cape discipline skill and apply it to the current work
disable-model-invocation: false
---

The user wants to manually invoke a no-cape skill — an override for when the skill didn't auto-trigger but they want its discipline applied now.

The available no-cape skills (name — when it applies):

- `clarifying-requirements` — starting underspecified new work
- `exploring-approaches` — turning a vague idea into a project shape
- `writing-solid-plans` — planning a multi-step feature or refactor
- `surgical-changes` — editing existing code you didn't just write
- `fail-loud` — writing error handling, fallbacks, or retries
- `safe-refactoring` — restructuring working code
- `writing-meaningful-tests` — writing or modifying tests
- `measure-before-optimizing` — performance work
- `schema-migration-safety` — changing a database schema
- `root-cause-debugging` — a bug, test failure, or regression
- `verify-before-done` — about to claim done/fixed/passing
- `receiving-feedback` — acting on review comments or corrections

The user's argument is: `$ARGUMENTS`

Do this:

1. **If the argument names a skill** (exact match, or an unambiguous prefix/substring like `surgical` → `surgical-changes`): invoke it with the `Skill` tool (`no-cape:<name>`), then apply its discipline to whatever is currently being worked on. Do not paraphrase the skill from the list above — load the real one.
2. **If the argument is empty**: show the list above and ask which one to apply. Don't guess.
3. **If the argument matches more than one skill ambiguously** (e.g. `re` → `receiving-feedback` or others): list the candidates and ask which.

Never restate a skill's contents from this file — this command only routes to the skill; the skill itself holds the discipline.
