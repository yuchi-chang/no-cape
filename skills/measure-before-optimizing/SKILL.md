---
name: measure-before-optimizing
description: Use when asked to improve performance, or when about to optimize code believed to be slow
---

# Measure Before Optimizing

No optimization without a measurement. Intuition about where time goes is wrong often enough that acting on it produces complexity without speed.

## The cycle

1. **Measure first.** Profile, time, or count queries on a realistic workload. Find the actual hotspot — not the code that "looks slow".
2. **State the baseline.** "X takes 2.3s, target is under 500ms." Without a number, nothing can be proven later.
3. **Fix the biggest cost first.** It is usually structural — N+1 queries, O(n²) loops, missing index, repeated work inside a loop, chatty I/O — not micro-level (string concatenation, function call overhead).
4. **Re-measure the same workload.** Report before/after numbers. Without them, the claim is just "I changed something".

## Heuristics

- Batching and killing N+1 patterns beat any micro-optimization by orders of magnitude.
- Cache only with an invalidation story — a stale cache trades a speed problem for a correctness bug.
- Don't trade readability for unmeasured gains; do trade it for a measured 10x.
- Parallelism added "for speed" without measurement usually adds race conditions, not speed.

## Red flags

"This should be faster", optimizing in the middle of an unrelated task, preemptive caching or parallelization. All of these mean: measure first, or leave it alone.
