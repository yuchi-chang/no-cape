---
name: writing-solid-plans
description: Use when designing or planning a multi-step feature, refactor, or spec before implementation begins
---

# Writing Solid Plans

Write the plan for an engineer (or a fresh agent) with zero context for this codebase. Everything they need must be in the plan itself.

## Before designing

- Confirm purpose, constraints, and success criteria. Ask only the questions whose answers would change the design.
- If the request bundles several independent subsystems, decompose into sub-projects first — one spec/plan each.
- Propose 2-3 approaches with trade-offs and a recommendation before committing to one. YAGNI: cut anything the goal doesn't need.

## Plan content

- Exact file paths for every create / modify / test.
- Real code in code steps; exact commands with expected output.
- Each task leaves the codebase working and testable; commit per task.

**Forbidden placeholders — each one is a plan failure:**

- "TBD", "TODO", "fill in later"
- "Add appropriate error handling / validation / edge cases"
- "Write tests for the above" (without the actual test code)
- "Similar to Task N" (repeat the content — tasks may be read out of order)
- References to functions or types that no task defines

## Self-review before handoff

1. **Coverage:** every spec requirement maps to a task — list any gaps.
2. **Placeholders:** scan for the forbidden patterns above.
3. **Consistency:** names, signatures, and types match across tasks (`clearLayers()` in Task 3 but `clearFullLayers()` in Task 7 is a bug).

Fix findings inline and move on — no re-review loop needed.
