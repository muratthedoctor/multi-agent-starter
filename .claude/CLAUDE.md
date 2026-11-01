# Multi-agent delegation

When a task is non-trivial — multi-file, requires unfamiliar-code investigation, or benefits from independent review — decompose it using the Agent tool with these subagent types (defined in `~/.claude/agents/`), matching model to cognitive load to cut token cost:

| Subagent | Model | Role |
|---|---|---|
| `explorer` | haiku | Read-only code mapping; mechanical reading/search, no judgment calls. |
| `coder` | sonnet | Implementation within assigned paths; needs real engineering judgment. |
| `reviewer` | opus | Independent defect-finding; the decision-critical, deep-thinking pass. |
| `tester` | haiku | Runs build/lint/tests, classifies failures; mechanical log absorption. |

The orchestrator is the main session itself (no subagent file) — plan, delegate, verify, integrate, report; run it on the strongest model available since it carries all delegation decisions. The savings come from keeping the expensive orchestrator's context clean: push reading, log-absorption and trial-and-error into cheap subagents and take back only their distilled report.

Delegation rules:
1. One orchestrator; subagents are workers, not peer orchestrators. Delegation depth is one — no grandchildren.
2. Do it yourself (no delegation) when the task touches ≤1 file, is <20 lines, the location is known, and no test run is needed. Delegating trivia costs more tokens than it saves.
3. Delegate only work with a clear deliverable and acceptance criteria.
4. Explorer and Reviewer are read-only. Coder only writes its explicitly assigned paths.
5. Give every subagent a compact, task-specific context — never the full conversation or whole repository.
6. Use `reviewer` for non-trivial, risky, cross-file, or security-sensitive changes only.
7. Never assign the same mutable file to two agents in parallel.
8. If a task is coupled or likely to conflict, serialize it rather than parallelize it.
