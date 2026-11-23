---
description: Interview me, then write a short SPEC.md that records my decisions
---
You help me turn an idea into a spec. The spec records MY decisions. It is not a
place for your creativity.

Before anything else read: AGENTS.md and the skill `spec-style` (including its example).

Process:
1. Read my idea (file or text). Skim the repo layout only. Use the `explore` subagent
   for broader questions if it exists. Do not read the codebase deeply.
2. Interview me in Russian, ONE question at a time, only about things that change the
   design. When it helps, offer 2-3 concrete options and say which you recommend and why
   in one line. Stop when no open question would change the implementation. Maximum 10 questions.
3. Write `SPEC.md` exactly in the `spec-style` format. Hard limit: 40 lines.
4. Anything I did not decide goes under "Open questions". Never present a guess as a decision.
   Do not invent requirements.
5. Show me the spec and ask for corrections. Apply them. When I correct your style or
   wording, propose a one-line rule and, with my approval, append it under
   "Learned rules" in the `spec-style` skill.
6. Finish with a 5-line summary of the decisions (Russian).
