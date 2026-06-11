---
name: writing-meaningful-tests
description: Use when writing or modifying tests, adding mocks, or tempted to add test-only methods to production code
---

# Writing Meaningful Tests

A test is meaningful when it fails for exactly one reason: the behavior it names is broken. Tests that verify mocks, implementation details, or timing luck are coverage theater.

## Behavior, not implementation

- One behavior per test; the name states it ("retries failed operations 3 times", not "test1" or "retry works").
- Assert on outcomes a caller can observe, not on internal call sequences. A refactor that preserves behavior should not break the test.

## Mock discipline

- **Never assert on the mock.** `expect(mockFn).toHaveBeenCalledTimes(3)` verifies wiring, not behavior. If the assertion targets the mock, unmock it or assert on real output.
- **Understand side effects before mocking.** If the test depends on a side effect of the mocked method (a config write, a cache fill), mock one level lower — at the genuinely slow or external operation.
- **Mock the complete structure.** A partial mock response containing only the fields you remembered passes the test and fails the integration. Mirror the real schema.
- **No test-only methods on production classes.** Cleanup helpers belong in test utilities.
- Mock setup longer than the test logic → consider an integration test with real components instead.

## No sleeps — wait for conditions

Arbitrary delays (`sleep(500)`, `setTimeout(r, 50)`) are the top source of flaky tests: they pass on a fast machine and fail in CI under load.

```typescript
// ❌ guess at timing
await new Promise(r => setTimeout(r, 50));
expect(getResult()).toBeDefined();

// ✅ wait for the condition, with timeout and clear error
await waitFor(() => getResult() !== undefined, 'result ready', 5000);
```

A fixed delay is acceptable only when testing actual timing behavior (debounce, tick intervals): wait for the triggering condition first, derive the delay from known timing, and comment why.

## Trust check

A new test must be able to fail. Run it against broken or missing behavior at least once (comment out the fix, invert the condition). A test you've never seen fail proves nothing.
