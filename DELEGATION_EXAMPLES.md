# Delegation task templates

## Explorer
Task ID: EXP-<id>
Role: explorer
Mode: read-only
Goal: Map the execution path for <behavior/bug>.
Context: <minimal symptom, error, files, reproduction>.
Acceptance criteria:
- Relevant files and symbols identified.
- Confirmed facts separated from hypotheses.
- Suggested minimal fix and regression tests.
Forbidden: modify files, install dependencies, commit.
Return the shared result contract.

## Coder
Task ID: CODE-<id>
Role: coder
Mode: write
Goal: Implement <specific change>.
Context: <Explorer findings and relevant constraints>.
Allowed paths: <explicit file paths/globs>.
Acceptance criteria:
- <behavior 1>
- <behavior 2>
- Regression tests added/updated where practical.
Verification commands: <real project commands>.
Forbidden: unrelated refactor, edits outside allowed paths, commit/push.
Return the shared result contract.

## Reviewer
Task ID: REV-<id>
Role: reviewer
Mode: read-only
Goal: Independently review the implementation of <change>.
Context: <acceptance criteria, diff, test evidence>.
Acceptance criteria:
- Find concrete defects or explicitly approve.
- Findings include severity, file/line, scenario, evidence, fix.
Forbidden: modify files.
Return the shared result contract.
