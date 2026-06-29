---
name: exploring-approaches
description: Use when starting a new project or significant feature from a vague idea — before clarifying details or planning, especially when the user already has a preferred approach
---

# Exploring Approaches

A request names a goal, not an architecture. The fastest way to build the wrong thing is to take the first approach that comes to mind — including the user's. Someone holding a hammer sees nails; your job is to check whether it's actually a nail before anyone starts hammering.

This runs *before* [[clarifying-requirements]]. Don't refine details inside an approach until you've confirmed it's the right approach. Once one is chosen, [[clarifying-requirements]] handles the open questions and [[writing-solid-plans]] turns it into steps.

## Challenge the framing first

- A goal like "a service that translates English audio" hides a fork: call a cloud API, self-host open models, or buy a SaaS. These grow into *different projects* — different cost, deployment, and code. Surface the fork before refining any branch of it.
- Do this **even when the user states a preference.** A stated approach is a starting hypothesis, not a settled decision. Confirming it without examining it is how knowledge blind spots become architecture.

## The brake: when to speak, when to move on

Raise an alternative only when **all three** hold. Miss one and stay quiet — confirm the direction and proceed.

1. **They likely haven't considered it.** "You said self-host — what about a cloud API?" is too obvious to earn its place. Skip it.
2. **It would change the shape of the project** — architecture, cost structure, or deployment. Not a library swap.
3. **You can name a concrete reason for *their* situation** — not "might be better," but "at your volume / under your constraint, it specifically wins because X."

The bar for speaking up is: *can you give them an "I hadn't thought of that"?* If you can't, don't manufacture options to look thorough. Inventing alternatives to seem thoughtful is its own failure — it buries the real decision in noise.

Watch for hidden **constraints**, not just alternative tools: "you plan to self-host Whisper, but those are client meeting recordings — data residency may force your hand" challenges the premise more usefully than any tool swap.

## Presenting

- Lead with your recommendation and why. Give 2-3 genuinely distinct options with their trade-offs — distinct in shape, not flavor.
- If the user's stated approach survives scrutiny, say so plainly and move on. Confirming a good instinct is a real outcome, not a skipped step.

## Smell test

If the project's fundamental shape was never on the table — only details within one unexamined approach — this skill was skipped.
