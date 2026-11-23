---
description: Create check/check-full and a short AGENTS.md for the current repo
---
You are bootstrapping this repository for AI-assisted development.
Do NOT modify application source code, do NOT add dependencies, do NOT commit.

## 1. Detect
Inspect only what exists: package.json, pyproject.toml, go.mod, Cargo.toml,
Makefile, justfile, lockfiles, linter/formatter/type-checker configs, test
directories, docker-compose files, and CI workflows (.github/workflows etc.).
The CI config is the source of truth for what this repo checks. Whatever CI
runs must be runnable locally through `check-full`.

## 2. Create the check entry points
Create a Makefile, or add to the existing one without overwriting existing targets.
- `check`: FAST, target under 60 seconds. Format check (no auto-fix), strict lint,
  type check, unit tests (only changed/affected tests if the tooling supports it).
  Quiet output: one line on success; on failure only the errors and the last
  40 lines of the log.
- `check-full`: everything in `check` plus the full test suite, build, integration
  tests, migrations applied from scratch on an empty throwaway database (if the
  repo has migrations), secrets scan and dependency audit IF the tools are already
  configured in the repo or CI.
Rules:
- Use only tools already configured in the repo or in CI. If something is
  missing (no linter, no type checker, no tests), do NOT add it. List it under "Gaps".
- Every step must fail loudly. No `|| true`, no ignored exit codes, no
  error suppression.
- If the repo has several subprojects, `check` calls per-subproject targets.
- Heavy e2e tests (containers, labs, VMs) belong only in `check-full`, and must be
  started through `~/.pi/agent/pipeline/e2e` when they use containerlab.

## 3. Create AGENTS.md (max 50 lines)
If one already exists, do not overwrite it: show a proposed diff instead.
Sections, all short:
- Purpose: one line.
- Commands: `make check`, `make check-full`, how to run a single test.
- Layout: map of the main directories, one line each.
- Gotchas: non-obvious facts verified from the repo (ports, env vars, generated files).
- Parallel worktrees: which resources need per-worktree isolation (database, ports,
  lab names) and which env vars carry them (DB_NAME, WT_PORT_BASE, CLAB_LAB_NAME).
Include only facts you verified. No generic advice, no filler.

## 4. Optional per-repo hooks
Only if the repo needs a database, containers or fixed ports, create
`.pipeline/hooks/up` and `.pipeline/hooks/down` (executable, bash). They run with
the variables from `.env.local` exported, inside the worktree. `up` creates the
per-worktree resources (for example `CREATE DATABASE "$DB_NAME" TEMPLATE app_template`),
`down` removes them. Otherwise skip this step.
Also create `.pipeline/protected.txt` ONLY if the default protected list is wrong for this repo.

## 5. Verify
Create `tasks/.gitkeep` if `tasks/` does not exist.
Run `make check` and report the real result. If it is red on the clean checkout,
do NOT fix it: record the failures as the baseline.

## 6. Report (in Russian)
List: what you created, what you ran and what happened, Gaps, baseline failures,
and at most 3 questions for me. Nothing else.
