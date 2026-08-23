---
name: review-staged
description: Use when reviewing staged git changes, a diff, or a PR against a plan or stated intent. Produces an issues-only review.md that verifies the diff against its plan, audits it against sound engineering-design principles (smallest seam, minimal surface area, simplest data model, strict scope), hunts for real bugs via runtime tracing and simulation, checks test-coverage gaps, and flags doc/plan mismatches. Triggers on "review", "review staged changes", "review my changes", "diff review", "PR review".
---

# Skill: review-staged

Review the way a senior engineer on this codebase would: judge the change against
its intent and against good design principles, hunt for real bugs, check tests,
and report only problems.

## 0. Gather inputs first

1. Run `git status` and `git diff --cached --stat` (or `git diff <base>...` for a PR/branch) to see what changed.
2. Read the full diff.
3. If a plan/design/context document exists (PLAN_*.md, RFC, issue description, even untracked), read it. It is the source of truth for *intent* — the diff is judged against it.
4. Read the repo's contribution guidance (AGENTS.md, CONTRIBUTING.md, README dev sections). House rules found there are hard review criteria, not suggestions.

## 1. Audit against design principles

Judge every addition through these lenses (from planning discipline — the same rules a good plan followed, the review now enforces):

- **Survey / no parallel mechanisms**: does the change reinvent something the platform or codebase already provides (caches, config stores, helpers, plumbing)? A new mechanism next to an existing one is a finding.
- **Smallest seam**: does it extend an existing entry point/hook/callback, or does it bolt on new wiring where a parameter would have done?
- **Minimal new surface area**: for every new API, state field, stored field, or config key added — who consumes it? Is there an existing mechanism that could absorb it? Defensive fields nothing reads are findings.
- **Simplest data model**: is the representation minimal and round-trippable? Prefer flat/scalar over nested; flag structures more complex than the requirement demands.
- **Strict scope**: only files the feature needs may be touched. Refactors, renames, drive-by cleanups, and leftover debug scaffolding are findings.
- **House style**: naming, idioms, error-handling conventions, localization/formatting rules — match how recent similar changes in this repo were made.
- **Edge cases real, not defensive**: handling added for cases that cannot occur is scope creep; genuinely reachable edge cases left unhandled are bugs (see §3).

When the diff stretches a rule, don't auto-reject — record *why* it was stretched and whether the justification holds.

## 2. Verify, don't trust

- Read every touched file **in full context**, not just hunks: callers, callees, neighbors, lifecycle.
- Trace the changed path end-to-end: who calls this, how often, on which instances? Watch especially for:
  - **Shared/singleton/module-level state** — writes in one path leaking into another.
  - **Restore/cleanup logic** that works only because some other line happens to re-copy state — find the case where that line doesn't run.
  - **Shallow vs deep copies** — aliasing between live objects and stored/shared config; mutations leaking back into source data.
  - **Ordering assumptions** between related steps (e.g. overrides applied before/after lookups).
  - **Consumers of the modified data elsewhere** — keys/values removed by new semantics but read by other code paths.
- Check error paths: what happens on malformed input, missing optional fields, garbage from hand-edited config?

## 3. Reproduce, don't speculate

- Run syntax checks/lint on all changed files using the repo's own commands.
- Actually run the affected tests. If the environment can't (missing toolchain/runtime), say so explicitly in the review — never imply tests passed.
- For suspicious logic, write a **tiny inline simulation** reproducing the exact branch sequence, rather than arguing from reading alone. Paste the output into the review as evidence. A reproduced bug outranks a suspected one.
- If a simulation isn't feasible (UI, hardware), trace by hand and label the finding as unconfirmed.

## 4. Audit test coverage of the new behavior

For each new branch/behavior in the diff:
- Is there a test that fails if the code were wrong?
- Does any test pass only because of a fixture detail (optional field present, mock leniency) while the missing-field variant breaks? That gap is itself a finding.
- Are error/garbage inputs covered (wrong types, nulls, empty configs, boundary values)?
- Does the test mock mirror production field names and call sequences? Divergence means production changes won't be caught.

## 5. Audit docs and claims

- Every behavioral claim added in comments/docs: does the code actually enforce it? Comments describing enforcement that doesn't exist are findings.
- Examples in docs: do they illustrate the actual use case (contrasting values), or confusingly reuse defaults?
- Plan-vs-diff completeness: list plan checklist items still open. Items correctly excluded (user-owned files, separate workstreams, device-side steps) are noted as pending, not counted against the diff.

## 6. Write the review file (issues only)

Write `review.md` in the repo root containing **only problems** — no praise, no restating what was done well:

1. **Bugs** first — each with `file:line`, a concrete failing scenario, and evidence (simulation output) if reproduced.
2. **Design-principle violations** — parallel mechanisms, excess surface area, scope creep, with the principle breached named.
3. **Concerns** — silent interactions with other subsystems, imprecise claims, semantics that drop data consumers rely on.
4. **Minor** — confusing docs, redundant tests, mock/production divergence, open plan items.
5. End with **verification performed**: what was run, what couldn't run and why, and what must run before merge.

Rules:
- Every finding must be actionable: what's wrong, why it matters, suggested fix direction.
- Severity must be honest; don't inflate minors into blockers, don't bury real bugs as minors.
- State environment limitations explicitly rather than silently skipping checks.

## 7. Report back concisely

After writing the file, reply with a short summary: main bug(s) by name, principle violations if any, verification status. Keep it to a handful of lines — details live in review.md.
