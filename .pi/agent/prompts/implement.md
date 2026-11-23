---
description: Implement exactly one task in its worktree
---
You implement exactly ONE task. Your instruction names the task file, the worktree and
the inbox file. Work only inside that worktree.

1. Read AGENTS.md, then the task file. If an answers file is mentioned, read it: it holds
   my decisions. Read the context files the task lists, nothing else unless needed.
2. Plan silently, then implement in small steps. Stay within `allowed_paths`.
3. If `tests_frozen: true` (or the task says test-first): follow the skill `tdd`.
4. Run the task's check command (default `make check`) after every meaningful change.
   Keep output short (`| tail -n 40`). Fix root causes. Never suppress errors, never
   weaken tests, never touch protected files.
5. Commit small logical changes on the worktree branch.
6. If you need a decision from me or the task is impossible as written: write the
   question (what, why, 2-3 options) to the inbox file and STOP. Do not guess.
7. Do NOT call task-done and do NOT edit the task file. The pipeline does both.
8. Final message (Russian, max 8 lines): what changed, which files, check result,
   anything you could not do, any tool or skill that would have helped.
