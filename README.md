# no-cape

> "No capes!" — Edna Mode

Lean engineering-discipline skills for frontier-class AI models (Claude Fable 5, Opus 4.x, and beyond).

Heavyweight skill frameworks were written for an earlier generation of models — ones that needed Iron Laws repeated five times, rationalization tables, and "you MUST invoke this even at 1% relevance" to stay disciplined. Frontier models don't need the coercion. But buried inside that scaffolding is real knowledge: decision rules, stop conditions, and evidence requirements that no amount of model intelligence replaces.

**no-cape keeps the knowledge and drops the cape.**

## The skills

| Skill | Fires when | The kernel |
|-------|-----------|------------|
| [`root-cause-debugging`](skills/root-cause-debugging/SKILL.md) | A bug, test failure, or unexpected behavior appears | No fix without root cause + evidence. Instrument component boundaries instead of guessing across layers. **3 failed fixes → question the architecture, not the code.** |
| [`verify-before-done`](skills/verify-before-done/SKILL.md) | About to claim "done", "fixed", or "passing" | A claim needs a fresh command run in this turn. Lint ≠ build ≠ tests. Subagent "success" reports need a diff check. Tests passing ≠ requirements met. |
| [`writing-solid-plans`](skills/writing-solid-plans/SKILL.md) | Planning a multi-step feature or refactor | Plans are for readers with zero context: exact paths, real code, no placeholders ("TBD", "add appropriate error handling"). Self-review coverage and naming consistency before handoff. |
| [`receiving-feedback`](skills/receiving-feedback/SKILL.md) | Receiving review comments or corrections | Verify feedback against the codebase before implementing. Clarify every unclear item before acting on any. No performative agreement — the diff is the acknowledgment. |
| [`surgical-changes`](skills/surgical-changes/SKILL.md) | Editing existing code | The diff is the product: every line traces back to the request. No drive-by cleanups — report improvements, don't apply them. |
| [`fail-loud`](skills/fail-loud/SKILL.md) | Writing error handling | A swallowed error is a bug with a delay timer. Every fallback is a product decision: "is the system actually correct when this branch executes?" |
| [`writing-meaningful-tests`](skills/writing-meaningful-tests/SKILL.md) | Writing or modifying tests | Test behavior, not mocks. No test-only methods in production. Wait for conditions, never sleep. A test you've never seen fail proves nothing. |
| [`safe-refactoring`](skills/safe-refactoring/SKILL.md) | Restructuring working code | Never mix restructure with behavior change. Green before, between, after. Grep beyond the compiler before renaming. |
| [`measure-before-optimizing`](skills/measure-before-optimizing/SKILL.md) | Performance work | No optimization without a measurement. State the baseline, fix the structural cost, re-measure the same workload. |
| [`schema-migration-safety`](skills/schema-migration-safety/SKILL.md) | Database schema changes | Old code runs against new schema during every deploy. Expand–contract, tested rollbacks, no data backfill inside migrations. |

Each skill is under 400 words. They state rules once and trust the model to follow them.

## Install

**As a Claude Code plugin (recommended):**

```
/plugin marketplace add yuchi-chang/no-cape
/plugin install no-cape@no-cape
```

**Manual copy (works with any [agentskills.io](https://agentskills.io)-compatible tool):**

Copy any folder under `skills/` into:

- `~/.claude/skills/` — personal, all projects (Claude Code)
- `<project>/.claude/skills/` — per project

## Design principles

Contributions welcome if they follow the same rules:

1. **Knowledge over coercion.** State the rule and the reason once. No Iron Laws, no rationalization tables, no ALL-CAPS threats. If a rule needs to be repeated five times to hold, the rule is the problem.
2. **Trigger-precise descriptions.** `description` says *when* to fire, never summarizes the workflow (a workflow summary becomes a shortcut the model takes instead of reading the skill).
3. **Under 400 words per skill.** Skills load into context; every token competes with the actual task.
4. **Decision rules and stop conditions, not process theater.** "3 failed fixes → stop" earns its place. "Announce that you are using this skill" does not.
5. **Don't duplicate the harness.** Worktrees, parallel agents, plan execution, and review dispatch are native tooling in modern harnesses — skills shouldn't reimplement them.

## Credits

Distilled from [obra/superpowers](https://github.com/obra/superpowers) (MIT) by Jesse Vincent — the discipline kernels in these skills trace back to that project. What's removed is the enforcement scaffolding; what remains is rewritten for models that don't need it.

## 繁體中文

這是一套給新世代強模型用的精簡工程紀律 skill。舊框架（如 superpowers）為了讓較弱的模型守紀律，加了大量強制性提示詞；強模型不需要被脅迫，但框架裡的真知識——決策規則、停止條件、證據要求——依然有價值。no-cape 留下知識，拿掉披風。

安裝方式見上方 Install 一節，或直接把 `skills/` 底下的資料夾複製到 `~/.claude/skills/`。

## License

MIT
