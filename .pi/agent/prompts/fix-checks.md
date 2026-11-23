---
description: Fix a rejected gate (check failure, scope violation or failed review)
---
A gate rejected the previous attempt. Read, in this order:
1. AGENTS.md and the task file named in your instruction.
2. The latest logs in `.pipeline/logs/<id>.diff.log` and `<id>.check.log` (use `tail -n 60`).
3. If present, the review `.pipeline/reviews/<id>.md`.

Then:
- Fix the ROOT CAUSE of each reported problem. Scope violations mean: revert the
  out-of-scope change, do not argue with the check.
- If a failing test seems wrong and the task has `tests_frozen: true`, do not edit it:
  write the question to the inbox file and stop.
- Never suppress errors, never weaken tests, never touch protected files.
- Run the task's check command until green. Commit.
- Final message (Russian, max 5 lines): what was wrong, what you changed, check result.
- Do NOT call task-done and do NOT edit the task file.
