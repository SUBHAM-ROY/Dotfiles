---
name: plan-xray
description: Use when planning, designing, or proposing an implementation approach for any codebase. Produces a decision-first plan that surveys and reuses existing infrastructure, minimizes new surface area, keeps the diff strictly in scope, and verifies with the repo's own checks. Triggers on "plan", "design", "approach", "how should we implement", "propose a plan", "draft a plan".
---

Solve this the way a senior engineer on this codebase would.

**0. Clarify the problem first.** If the problem statement is ambiguous, incomplete, or seems to conflict with the codebase, ask clarifying questions before surveying the solution. State what's unclear and ask — don't assume. Only proceed once the goal is concrete.

**1. Survey before designing.** Read the area this touches and its neighbors. Identify existing functions, state, persistence layers, and conventions that already do most of the work. Assume the platform provides it until proven otherwise — do not invent parallel mechanisms (caches, config stores, plumbing) unless genuinely new.

**2. Find the smallest seam.** Prefer extending an existing entry point, lifecycle hook, or callback over adding new ones. A change that adds one parameter to an existing function beats one that adds a new module, new state, and new wiring.

**3. Minimize new surface area.** For every new API, piece of state, or stored field, ask: does this already exist? Could an existing mechanism absorb this with a smaller change? New surface is a cost — spend it only when required.

**4. Simplest data model.** Choose the minimal representation that round-trips and satisfies the requirement. Prefer flat/scalar over nested structures. Handle edge cases only when they're real, not defensively.

**5. Strict scope.** Touch only the files this feature needs. No refactors, renames, or drive-by cleanups. Strip all debug scaffolding before finishing. If something belongs in a separate change, keep it separate.

**6. Ask on product behavior.** If multiple behaviors are reasonable, list them and ask — don't unilaterally force a default.

**7. Mirror house style.** Match the codebase's idioms, naming, and structure; check how recent similar changes in this repo were made.

**8. Verify cheaply.** Use the repo's existing test/lint/check conventions; identify how this change will be verified.

**9. Audit against your own rules.** Before writing the plan, re-read your design and strike anything the existing rules forbid: new state that mirrors data already resident (caches, load loops, cleanup passes), defensive fields no action consumes, new dialogs in flows that already confirm. If a rule had to be stretched, say so in the plan.

Then produce a plan:
- the design decisions and the choices they rule out (with the reasoning from the survey above),
- the files you'll touch and why each one is necessary,
- the data model and where it will live (or why none is needed),
- any risks, unknowns, or things to confirm before implementation,
- the verification steps, ordered from cheapest to most expensive,
- and the exact order you'd implement it in.

Keep the plan tight — no code yet, decisions over prose.