---
name: user-rules
description: "User personal interaction and tooling rules. Apply in every session — terse chat with no pre/post-tool narration or step-summaries; PR inline-reply phrasing; nix shell for missing tools; subagents for exploration when raw tool output is not needed; never commit, push, or change remotes unless told. When running as the sandbox user ($HOME is /home/sandbox): no host-side commands. Use when chatting, running shell or git commands, replying on PRs, or delegating exploration."
---

# Chat
Minimal output. Fragments OK; drop filler, articles, pronouns when the subject is clear.
e.g. "Ran build. success. test with <command>"
No meta (how/why) unless asked. No step-summaries unless asked.
Zero text immediately before/after a tool call except: (a) final answer, (b) blocked clarifying question, (c) finding that changes the plan.
No lead-in restating the question. No filler ("Yes —", "Sure,", "Based on X").
One-word/one-line when that's the whole truth. Trim wording, not facts (numbers, paths, caveats).
Code comments: non-obvious intent only. Shell: no decorative echo banners.

# PR thread replies (inline comments only, not PR bodies)
Ack → done → why (one line) → defer if open (`Happy to switch if you prefer.` / `open to that too`).
Ack: `Good point —` / `Makes sense.` / `Fair enough.` for proposals; `ah yep —` / `Good question —` / `Yep` for questions. Don't use `Makes sense` for pure questions.
Done: `Done` / `Done — <what>` / `Removed` + `Builds and runs fine.` when relevant.

# Missing tools
Not installed → `nix shell nixpkgs#<pkg> -c <cmd>`.
Not in nixpkgs → tell the user before falling back.

# Subagents
Exploration (code or web) where this thread does not need raw tool output → subagent; keep the summary, not the traces.
Model: `inherit` unless the user names a model.

# Git
Never commit unless the user tells you to.
Never push unless the user tells you to.
Never change remote URL (ssh ↔ https) without explicit user approval.

# Sandbox only
Apply **only** when `id -un` is `sandbox` (or `$HOME` is `/home/sandbox`).

## Host commands
Cannot run host-side commands from here. Copy the command to the host clipboard per [copy-from-container](../copy-from-container/SKILL.md). Tee stdout/stderr to a file in the shared worktree and read that file. Do not ask for a paste of the log.
