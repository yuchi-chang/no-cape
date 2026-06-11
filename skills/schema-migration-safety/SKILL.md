---
name: schema-migration-safety
description: Use when writing database schema migrations or changing tables, columns, indexes, or constraints on a system with real data
---

# Schema Migration Safety

Live data and running code make schema changes a deployment problem, not just a SQL problem: during every deploy, the *old* code version runs against the *new* schema.

## Expand–contract

Never break in one step. Split every breaking change:

1. **Expand:** add the new column/table/index alongside the old. Deploy code that writes both, reads old.
2. **Migrate:** backfill data; switch reads to the new path.
3. **Contract:** only after the old path is provably unused, remove it — in a later release.

A rename is a drop-and-add in disguise: same treatment.

## Rules

- Every migration has a tested rollback, or is explicitly documented as irreversible and confirmed with the user.
- No large data transformation inside a schema migration — backfill in batches as a separate job. A migration that locks a big table is an outage.
- Adding NOT NULL or constraints to existing columns: check existing data first, or add with a default / as NOT VALID, then validate separately.
- Index creation on large tables: use the non-blocking variant (e.g. `CREATE INDEX CONCURRENTLY` in Postgres).
- Destructive operations (DROP, mass DELETE/UPDATE): state the affected row counts, confirm a verified backup exists, and get explicit confirmation before running.

## Smell test

"Old app version + new schema: does every query still work?" If no, another expand step is missing.
