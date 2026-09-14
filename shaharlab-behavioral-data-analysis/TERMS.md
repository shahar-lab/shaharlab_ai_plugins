# Terms

Words Malka uses, and what they mean.

## Agents

**Malka**
The lab's analysis orchestrator. She specifies every job with you, executes a single job, and dispatches Code Writers for multiple jobs.

**Code Writer**
Writes the code and the other files in a job-folder.

## Cards

**Summary Card**
The plain-English write-up you approve before any code is written.

**Job Card**
The complete instructions for one job. Created before Clarify, approved at Confirm, then executed by Malka or a Code Writer.

**Handback Card**
The checked delivery for one job: its status, changed files, entry point, outputs to inspect, and any `BLOCKED`, `ASSUMED`, or `ADDED READS` tags.

## UI elements

**`AskUserQuestion`**
Claude Code's question dialog: a choice with options, then a wait. Not lab-made.

**`- [ ]`**
A checklist line in the chat. The terminal UI picks it up. Clarify's leftover questions and the Summary Card's Confirm & Execute / Revise are written this way.

## User interview step

**interview**
The conversation before anything is built: Specify, Clarify, Confirm.

**Specify**
Malka splits the request into one Job Card per job-folder, then fills `ROUTED READS` and `CHECKS` from `02-knowledge-index.md`.

**Clarify**
Malka reads the actual questions under each Job Card's `CHECKS`, asks for leftover values, and writes the answers into `SPECIFICATION`.

**Confirm**
Malka shows you a Summary Card and waits. Nothing is built until you say yes. Revise returns to the affected Job Cards and Clarify. On yes, the Job Cards are written to `.malka/current_job.md`.

**`CHECKS`**
The actual clarification questions copied from a knowledge-index entry onto a Job Card. Clarify answers them in `SPECIFICATION`.

**the gate**
That approval. Work does not start without it, and it is the only one.

**specification**
What you approved — the formulas, thresholds, and settings the code has to follow.

**run**
This request's full list of jobs. One request, one run.

**job**
One unit of work in one job-folder, executed by Malka or one Code Writer.

## Agents dispatch

**Dispatch subagents**
Malka sends a Writer for each ready job, until the list is done.

**Dispatch**
Sending a Writer out to build a job.

**route**
Which lab how-to files the executor reads for this job. Their paths appear under the Job Card's `ROUTED READS`.

**standing read**
Files every executor opens — project rules, coding rules, and that folder's templates.

**`FOLDER`**
Which job-folder this work writes into.

## Folders

**main-folder**
One of the five directories at the project root: `data/`, `preprocessing/`, `models/`, `analysis/`, `simulation/`.

**job-folder**
The directory one job writes into.

**canonical set**
The usual contents of a job-folder: `code/`, `artifacts/`, `output/`, `main.R`, `summary.md`. Preprocessing alone adds `reports-collected/`, `reports-raw/`, and `reports-processed/` inside `output/`. A `models/` job-folder is the exception — two files, no canonical set.

**fit**
One fitted model — one `brm()` or `stan()` call, one combination of formula, family, and analyzed subset.

**scaffold / clone**
Starting a job-folder from its templates, or copying an existing one.

**`summary.md`**
The notebook that lives in the job-folder. Not the Summary Card you approved.

## Flags

**the reserved set**
Values only you may choose — the numbers that reach a manuscript, named in `project-terms.md`. No one else picks these.

**`ASSUMED`**
A defensible non-reserved default used while executing a Job Card. Malka reports it at Handback.

**`BLOCKED`**
Execution stopped because a reserved user decision or required input was missing.

**`ADDED READS`**
Guidance opened beyond the Job Card's `ROUTED READS`.

## Recovery studies

**recovery study**
A simulation that generates data from known parameters and fits the model back.

**environment**
The setup every simulated agent faces — a reward schedule, a design, an item set.

**agent**
Who the parameters belong to in a recovery study — a subject, an item, a player.

**true parameters**
The values the data were generated from.

**recovered parameters**
What the fit got back, compared against the true parameters.

## Revisions

**new science**
A different formula or a new cutoff. That needs a new interview, because you have to approve it.

## Skill design terms

**Structure Legend**
A heading, a skeleton box, then one bullet per named bit of the shape. The form for a folder tree, a card, a Job Card, or a layout. The writing rule lives in the repo `.claude/CLAUDE.md`.
