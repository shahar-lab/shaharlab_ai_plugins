# Terms

Words Malka uses, and what they mean.

## Agents

**Malka**
The lab's analysis orchestrator. She talks with you, gets your approval, then sends the Code Writer to write the code.

**Code Writer**
Writes the code and the other files in a job-folder.

**Data Explorer**
Looks at your data during the interview so later questions are grounded in what's actually there. Reads only; writes nothing.

## Cards

**Plan Card**
This request's job index: `JOB`, `FOLDER`, and `WAVE` when there is more than one job. Printed in full in the chat.

**Summary Card**
The plain-English write-up you approve before any code is written.

**Job Card**
The instructions for one job. Born at Plan from a Plan Card line; locked at Confirm; completed at Dispatch for spawn.

## UI elements

**`AskUserQuestion`**
Claude Code's question dialog: a choice with options, then a wait. Not lab-made.

**`- [ ]`**
A checklist line in the chat. The terminal UI picks it up. Clarify's leftover questions and the Summary Card's Confirm & Execute / Revise are written this way.

## User interview step

**interview**
The conversation before anything is built: Plan, Clarify, Confirm.

**Plan**
Malka counts the jobs, prints the Plan Card, then writes one Job Card per line — walking `knowledge-index.md` once per job to fill `ROUTED READS` and `CHECKS`.

**Clarify**
Malka reads Deploy-checks on the knowledge-index entries listed in each Job Card's `CHECKS`, then asks for leftover values — not your science. Answers write into that Job Card's `SPECIFICATION`.

**Confirm**
Malka shows you a Summary Card and waits. Nothing is built until you say yes. Revise returns to Clarify. Wrong jobs return to Plan. On yes, the Plan Card and the Job Cards are written to `.malka/current_job.md`.

**deploy-checks**
Leftover questions on a knowledge-index entry, written as an ordered bullet list. Plan copies that entry's Path onto the Job Card's `CHECKS` in the same walk that fills `ROUTED READS`. Clarify walks the bullets in that order. The Writer reads the how-to.

**Exploration Pass**
A look at your data during the interview. Not a run.

**the gate**
That approval. Work does not start without it, and it is the only one.

**specification**
What you approved — the formulas, thresholds, and settings the code has to follow.

**run**
This request's full list of jobs. One request, one run.

**job**
One unit of work: one folder, one Writer.

**`WAVE`**
A batch of jobs on the Plan Card. WAVEs run in order (serial). Jobs in the same WAVE run together (parallel). When the Plan Card is one job, the heading is skipped.

## Agents dispatch

**Dispatch subagents**
Malka sends a Writer for each ready job, until the list is done.

**Dispatch**
Sending a Writer out to build a job.

**route**
Which lab how-to files the Writer is told to read for this job. Plan writes those paths on the Job Card's `ROUTED READS`.

**standing read**
Files the Writer always opens — project rules, coding rules, and that folder's templates.

**`FOLDER`**
Which job-folder this work writes into.

## Folders

**main-folder**
One of the five directories at the project root: `data/`, `preprocessing/`, `models/`, `analysis/`, `simulation/`.

**job-folder**
The directory one job writes into.

**canonical set**
The usual contents of a job-folder: `code/`, `artifacts/`, `output/`, `main.R`, `summary.md`. A `models/` job-folder is the exception — two files, no canonical set.

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
A default the Writer took because you didn't specify something that wasn't reserved. Malka will tell you about these.

**`BLOCKED`**
The Writer stopped because something only you can decide was missing.

**`ADDED READS`**
The Writer opened a how-to file Malka hadn't pointed it at. Not a failure.

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

## When you come back

**the return trip**
What happens when you return after running the code — a repair, a look at diagnostics, or writing the findings down.

**new science**
A different formula or a new cutoff. That needs a new interview, because you have to approve it.

## Skill design terms

**Structure Legend**
A heading, a skeleton box, then one bullet per named bit of the shape. The form for a folder tree, a card, a Plan Card, a Job Card, or a layout. The writing rule lives in the repo `.claude/CLAUDE.md`.
