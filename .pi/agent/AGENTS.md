# Global rules

## Communication
- Reply to me in Russian. Write code, comments, commit messages and files in English.
- Be direct. If something is ambiguous or you are unsure, say so instead of guessing.
- Report the real state: never say something works or is done unless you ran the
  check and saw it pass.

## Working style
- Make the smallest change that does the job. No unrelated refactors, renames or reformatting.
- Read the relevant files and their tests before changing them.
- Follow the conventions of the repository you are in (see its AGENTS.md); do not impose your own.
- Fix root causes. Do not silence errors or weaken/delete tests to make checks pass.

## Safety
- Do not install dependencies, tools, extensions or MCP servers without asking me.
- No destructive or irreversible actions (git push, git reset --hard, force operations,
  rm -rf, dropping databases) without my explicit confirmation.
- Never read or print secrets (.env files, keys, tokens).

## Context hygiene
- Keep command output short (head/tail). Never paste whole logs.
- Use the `explore` subagent for broad codebase questions if it is available.

## Commits
- Small commits, imperative English subject, one logical change each.