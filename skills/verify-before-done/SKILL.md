---
name: verify-before-done
description: Use when about to claim work is complete, fixed, or passing — before committing, opening a PR, marking a task done, or relaying a subagent's success report
---

# Verify Before Claiming Done

Evidence before claims. If the verification didn't run in this turn, the claim can't be made.

## The gate

1. Name the command that would prove the claim.
2. Run it fresh and completely — not a remembered earlier run, not a partial subset.
3. Read the full output and the exit code.
4. Only then state the result — with the evidence, or with the actual failing state.

## What each claim requires

| Claim | Proof required |
|-------|----------------|
| Tests pass | Fresh full test run with 0 failures — lint or build passing is not it |
| Build succeeds | Build command exits 0 — lint passing is not it |
| Bug fixed | The original symptom re-tested and gone |
| Regression test works | Red-green verified once: revert fix → test fails; restore fix → test passes |
| Subagent finished | Inspect the actual diff — never trust the agent's own "success" report |
| Requirements met | Re-read the spec/plan and check items line by line — tests passing ≠ spec met |

## Check the criterion, not just the run

A green check only proves what it measured. Before trusting it, ask: *does passing this actually mean the work is right?* A test that asserts "ran without error" passes on output that silently dropped half its input. The gate above stops you skipping verification; this stops you trusting a verification that checks the wrong thing.

The trap is loudest when a library or default does the work for you — `vad_filter`, pagination limits, truncation, sampling, auto-retry-then-give-up. The call "succeeds" while quietly discarding part of the result. So when the output is a *transformation of an input* (transcribe, scrape, convert, migrate, extract), assert on **coverage**, not just liveness:

- Not "got N segments" but "the N segments cover the input" — duration, word count, row count, page count in vs out.
- Diff the risky default against its alternative once (e.g. filter on vs off) to see what it actually costs you — don't assume, measure.
- If you can't state what *complete* output would look like, you can't yet claim the run proved anything.

## Red flags

"Should work now", "probably passes", expressing satisfaction before running anything, committing without a fresh run. Asserting the pipeline ran without asserting the output is complete. Blaming a component (a filter, a default) for dropping data before reproducing it — name the cause from evidence, not a hunch. If verification fails, report the real state with the output — never optimism.
