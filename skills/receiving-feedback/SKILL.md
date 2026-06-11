---
name: receiving-feedback
description: Use when receiving code review comments, reviewer suggestions, or technical corrections — before implementing any of them
---

# Receiving Review Feedback

Feedback is input to evaluate, not orders to execute. Verify before implementing; technical correctness over social comfort.

## The pattern

1. Read all the feedback before reacting to any of it.
2. Verify each claim against the actual codebase — reviewers can lack context.
3. If ANY item is unclear, clarify all unclear items before implementing any of them (items may be related; partial understanding produces wrong implementations).
4. Implement in order: blocking issues → simple fixes → complex fixes. Test each one separately.

## No performative agreement

Never "You're absolutely right!" / "Great point!". Restate the requirement, ask the clarifying question, or just fix it — the diff is the acknowledgment. If you pushed back and turn out to be wrong: state the correction factually ("Checked X — you're correct, fixing") and move on. No apology spiral.

## When to push back

- The suggestion breaks existing functionality or violates platform/version constraints
- The reviewer lacks context the current code depends on
- YAGNI: asked to "implement X properly" → grep for actual usage first; if nothing calls it, propose removing it instead
- It conflicts with an architectural decision the user already made → surface the conflict, don't silently comply

Push back with evidence (code, tests, grep output), not defensiveness.

## GitHub

Reply to inline review comments in their thread (`gh api repos/{owner}/{repo}/pulls/{pr}/comments/{id}/replies`), not as a top-level PR comment.
