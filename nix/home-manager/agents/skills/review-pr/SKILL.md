---
name: review-pr
description: Review this branch's diff against its PR base; writes review.md and files.md.
disable-model-invocation: true
---

# Review PR

Prioritized review. Write files, not a chat dump.

## Base
`gh pr view --json baseRefName -q .baseRefName`; no PR → `master` if `origin/master` exists, else `main`.
`git fetch origin <base>` if `origin/<base>` is missing.

## Diff
`git diff origin/<base>...HEAD --stat`, then the full diff. Then read every changed file in full — hunks are not enough.
Exception: lockfiles, generated, vendored, and snapshot files — skim the diff only.
Also read related unchanged files, e.g. callers of changed functions, sibling implementations, config/schemas it depends on.

## Don't run
No lint, type-check, test, or build. Read the code instead.

## Re-review
Applies when `review.md` has `**Reviewed:** \`<sha>\``.
Diff `<sha>...HEAD` if `git merge-base --is-ancestor <sha> HEAD` passes; otherwise (rebased/force-pushed) use the full base diff.
Update `review.md` in place: new sha in the header, each prior finding marked fixed / unfixed / superseded, new findings under `## Since \`<sha>\``. Only the latest round gets a "Since" section; merge any older one into the main body.
`files.md`: update only files touched since `<sha>`.

## Findings → `review.md`
Header: `**Reviewed:** \`<sha>\`` (`git rev-parse HEAD`).
Severity: **RED** must-fix (e.g. bugs, unhandled cases elsewhere, data loss, security, silent prod fail) · **ORANGE** should (e.g. missing migration/config/docs updates, fragile design, perf) · **YELLOW** consider (e.g. simpler alternative, readability) · **GREEN** nit (e.g. naming, style).
Each comment: file + line range, snippet, issue, suggested fix. Be detailed; don't collapse distinct issues.
End with what the PR does well, if it does.

## Overview → `files.md`
3–5 sentences from the code, not the PR description or commits. Problem + mechanism.
Then 2–3 lines per file, story order: entry → wiring → core → tests → docs.

## Chat
Point at `review.md` and `files.md`. Do not paste them.
