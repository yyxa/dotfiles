---
description: End-of-task retrospective; appends one entry to the global friction log
---
The task is finished (or blocked). Write a retrospective entry. Do not modify
the repository, AGENTS.md, skills or any configuration. Do not install anything.

## Steps
1. Find the task file for this session (named in your instruction, or tasks/NNN-*.md).
   If you cannot tell which one, ask me once.
2. Get facts via bash: `date +%F`, `basename "$(git rev-parse --show-toplevel)"`.
3. Review this session and base every statement on evidence: concrete commands,
   files, error messages, attempt counts. If you cannot point to evidence, leave it out.
4. Append ONE entry to `~/.pi/agent/friction.md` in exactly this format
   (use `>>`, never overwrite the file):

## <date> · <repo> · <task id> · result: <ready|blocked>
- cost: attempts=<n>, check failures=<n>
- friction: <what slowed you down, with evidence> (or "none")
- missing: <information or tool you lacked> (or "none")
- suggestion: type=<agents-md|script|skill|mcp|linter-rule|none> — <one line>
- user-correction: <rule implied by anything I corrected during the session> (or "none")

Rules:
- Max 3 bullets of real content. "none" everywhere is a valid and good answer.
- A suggestion is only a proposal: never act on it. Prefer the cheapest type
  (agents-md before script before skill before mcp).
- Do not invent problems to look useful. Do not repeat an entry already in the log.

## Output (in Russian)
Two lines: the result and the suggestion, or "трений не было".
