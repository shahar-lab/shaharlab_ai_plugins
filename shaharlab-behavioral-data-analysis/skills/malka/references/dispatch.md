# Dispatch subagents

Step 2 of `SKILL.md`. Ready jobs are the current WAVE on the Plan Card. Loop until the job list is empty, then go to Step 3.

Build one Code-Writer Card per ready job (`dispatch-code-writer-card.md`). Spawn those Writers in one message, one Writer per job. Act on a return when it arrives; do not wait for the whole WAVE.

On a clean return: Reviewer Card (`dispatch-reviewer-card.md`), then `summary.md` (`folder-summary.md`; skip `models/`). Carry `ASSUMED`, `ADDED READS`, and the Reviewer's return to Step 3. Then the rest of this WAVE, then the next WAVE.

## BLOCKED

One round to the user for every `BLOCKED` in the WAVE. Re-dispatch only the jobs that blocked.

| What comes back | What it means | What you do |
|---|---|---|
| `BLOCKED`, no defensible default | the specification is silent | get the value from the user, amend the card |
| `BLOCKED`, needs a write outside `FOLDER` | the job crosses folders | revise the Plan Card into several jobs, per `interview-plan-card.md` |
| `BLOCKED`, `FOLDER` contradicts the work | the route is wrong | re-route on `project-rules.md` §1's tree |
| `BLOCKED`, specification contains more than one fit | the Plan Card under-counted the jobs | re-Plan per `interview-plan-card.md`, then Critique holes, then Confirm again |
| `BLOCKED`, an input file is missing from disk | the writing job is not done, or its dispatch failed | put this job in a later WAVE than the job that writes that file, per `interview-plan-card.md`; if that job already ran, treat as a failed dispatch below |
| nothing came back, or neither clean nor `BLOCKED` | the dispatch failed | re-dispatch the same card once; on a second failure, stop and say what is on disk |

Reviewer findings: `dispatch-reviewer-card.md`.

`ADDED READS` is not a failure — the deliverable stands. Add those files to later cards of that kind.

Two rounds, then the user. A blocked Writer may already have written: `PROJECT STATE` says the job is resumed.
