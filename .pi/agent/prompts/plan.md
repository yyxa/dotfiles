---
description: Split SPEC.md into small self-contained task files in tasks/
---
Read AGENTS.md, SPEC.md and, briefly, the repo layout (use the `explore` subagent if available).

Split the spec into tasks. Rules:
- Each task must fit one short agent session: at most ~5 files changed and ~200 lines of diff.
  If it would be bigger, split it.
- Each task is SELF-CONTAINED: a fresh agent will see only AGENTS.md and the task file.
  Put the needed context in the task (paths to read first, relevant decisions from the spec).
- Acceptance criteria are numbered, testable statements. No vague wording.
- `allowed_paths`: comma-separated globs the task may change (be tight).
  `may_touch`: protected files the task is allowed to change (usually empty).
- Order by dependency; `depends_on: [001, 002]`.
- Where logic is testable, make test-first tasks: set `tests_frozen: true` on the
  implementation task and make the previous task or the first commit write the tests
  (see skill `tdd`).
- Keep the `check:` field `make check` unless the task needs something else.

Before writing any file, show me a table: id, title, depends_on, allowed_paths, and a
one-line goal. Wait for my approval (Russian). Then write `tasks/NNN-slug.md` using
exactly the task file format from `~/.pi/agent/pipeline/README.md`, with `status: todo`,
`attempts: 0`, `max_attempts: 3`. Do not implement anything. Do not commit.
