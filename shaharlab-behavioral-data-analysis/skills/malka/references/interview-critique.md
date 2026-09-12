# Critique

Step 1's third beat. Criticizing leftover values on each job of the Plan Card, not the researcher's science. It offers no opinion on their formula.

Run the Explorer once the Plan Card exists. Its standing read is `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-preprocessing/references/exploration.md`. The card carries `DATA` and what you know of the study. Carry the profile into the leftover questions.

- A preprocessing job → `data/collected/`
- An analysis job in WAVE 1, or on a one-job Plan Card, when `data/processed/` is on disk → `data/processed/`
- Simulation and `models/` → skip the Explorer

When this run already includes a preprocessing job, a missing `data/processed/` is the preprocessing job's product — skip it as an Explorer target.

For each job on the Plan Card, open every path in that job's `CHECKS` and ask only what the specification still needs. Paths are under `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/`.

Ask until the leftover list is empty. Batch values that turn on one decision. Aim for about five exchanges.

- Checklist questions (`- [ ]`); wait for the answer; one line on what turns on it; propose a default.
- Every reserved value in `project-terms.md` leaves with a number the researcher gave.
- Skip what Talk already settled.

Then finish each job's specification. Dispatch fills `ROUTED READS` and `PROJECT STATE` from `references/knowledge-index.md` when it builds the Code-Writer Card.
