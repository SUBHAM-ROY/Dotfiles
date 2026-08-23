---
name: self-review-loop
description: Use when a staged change set should be iteratively reviewed and fixed until a reviewer finds nothing. Spawns a fresh reviewer subagent that follows the review-staged skill on the staged diff, applies only the valid findings, re-stages, deletes review.md, and loops until the review comes back clean or only consciously-accepted items remain. Triggers on "review loop", "review until clean", "self-review loop", "iterate reviews".
---

# Skill: self-review-loop

Run an adversarial fix–review convergence loop over the staged changes.
A *different* agent reviews than the one fixing — reviewers never trust the
fixer's reasoning, and the loop ends only on an explicit clean verdict.

## Loop structure

Each iteration is exactly four steps:

1. **Review** — spawn a general subagent via the Task tool (`subagent_type: general`, fresh context each time) with
   instructions to:
   - read and follow the `review-staged` skill EXACTLY as written;
   - review the STAGED changes (`git status`, `git diff --cached`) against the
     intent document (PLAN_*.md / issue / stated goal) and house rules
     (AGENTS.md) — these are hard criteria, not suggestions;
   - verify before reporting: read every touched file in full context, trace
     callers, run syntax checks, execute the test suite if runnable, and
     reproduce claimed bugs via throwaway simulation scripts (kept outside the
     repo);
   - write an issues-only report to `review.md` at the repo root following the
     review-staged format (Bugs / Design-principle violations / Concerns /
     Minor, with file:line references, real pasted evidence, fix directions);
     if nothing actionable is found the file contains exactly
     `CLEAN: no findings`.
2. **Triage** — read `review.md` yourself. For each finding decide: fix now,
     reject with justification, or classify as consciously accepted /
     user-owned / out of scope. Reproduce non-obvious claims before accepting
     them; reviewers can be wrong too.
     Record every decision in `REVIEW_DECISIONS.md` at the repo root
     (untracked), appending one section per round:

     ```markdown
     ## Round 2 triage
     ### Accepted & fixed
     - F1 stale config copy left on the shared object → cleared after each use
     ### Rejected
     - M2 test through the real module instead of a snippet → house rules
       explicitly allow snippet testing for non-exported logic
     ### Consciously accepted (do not re-report)
     - Reads from the source record instead of the merged copy on the shared
       object — deliberate, prevents cross-record leaks
     ```

     This file is written in plain language for the user to read directly —
     not agent shorthand. It is the loop's memory: it survives session loss,
     prevents re-litigating old findings, and serves as the decision record
     once the loop converges.
3. **Fix** — apply the accepted findings. Smallest correct change per finding;
     no drive-by refactors. Add or extend tests when the finding reveals a
     coverage gap. Re-run syntax checks and the full test suite.
4. **Stage & reset** — `git add` every fixed file so the next round sees them
     staged, then `rm review.md` (skip this after a final clean round — that
     verdict stays). Go to step 1.

## Convergence

The loop ends when a full iteration returns `CLEAN: no findings` — not merely
"no bugs". Expect 3–6 iterations for a feature of moderate size:

- rounds 1–2 find real bugs (shared/singleton state leaks, ordering
  assumptions, aliasing) and test gaps;
- round 3–4 find doc/comment inaccuracies and edge-case tests;
- final rounds should find nothing new — if they keep producing speculative
  "future code might..." findings, tighten the next prompt instead of
  "fixing" them.

## Prompting the reviewer subagent

Point the reviewer at `REVIEW_DECISIONS.md` (the triage log) and instruct it
to read that file first and not re-report anything under "Rejected" or
"Consciously accepted" — this is the only place the carry-forward instruction
lives; do not duplicate it in the loop steps above. Also exclude user-owned
items (live config files, device-side steps) and pre-existing behavior outside
the diff.

Raise the bar in later rounds: after round ~3, instruct that only findings
requiring a code/doc change in the staged diff count — reachable bugs,
design violations in the diff itself, test gaps for diff-introduced logic, or
doc claims contradicted by the code. Speculation is not a finding. Tell the
reviewer how many prior rounds ran and what they already fixed, so it does not
manufacture findings to justify itself.

## Rules

- Never let the same subagent session review twice — always a fresh spawn, so
  each review is independent.
- Never skip the staging step: unstaged fixes are invisible to
  `git diff --cached` and will be re-reported forever.
- Never delete or edit the intent/plan docs during the loop without explicit
  user approval; record plan deviations as accepted items instead.
- At convergence, stop the loop and leave both files in place:
  `review.md` holds the final clean verdict, `REVIEW_DECISIONS.md` the full
  decision history. The user reads them directly — do not summarize or delete
  them unless asked.
- If two consecutive rounds produce only rejected/accepted-as-is findings,
  declare convergence even without a literal CLEAN verdict, and say why.
