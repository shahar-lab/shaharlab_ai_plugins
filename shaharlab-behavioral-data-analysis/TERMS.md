# Terms

Words Malka uses, and what they mean.

## Agents

**Malka**
The lab's analysis orchestrator. She talks with you, gets your approval, then sends others to write and check the code.

**Code Writer**
Writes the code and the other files in a job-folder.

**Code Reviewer**
Checks the finished files against what you approved and the lab's coding rules. Reads only.

**Data Explorer**
Looks at your data during the interview so later questions are grounded in what's actually there. Reads only; writes nothing.



## Cards

**Plan Card**
This request's job list: `JOB`, `FOLDER`, `CHECKS`, and `WAVE` when there is more than one job. 

**Summary Card**
The plain-English write-up you approve before any code is written.

**Code-Writer Card**
The exact instructions the Writer works from — locked when you approve.

**Reviewer Card**
The instructions the Reviewer works from after that Writer finishes.



## UI elements

**`AskUserQuestion`**
Claude Code's question dialog: a choice with options, then a wait. Not lab-made.

**`- [ ]`**
A checklist line in the chat. The terminal UI picks it up. Critique's leftover questions and the Summary Card's Confirm & Execute / Revise are written this way.



## User interview step

**interview**
The conversation before anything is built: Talk, Plan, Critique, Confirm.

**Talk**
Malka finds out what you want and looks at the project.

**Plan**
Malka counts the jobs and fills the Plan Card.

**Critique**
Malka checks each job on the Plan Card for missing values — not your science.

**Confirm**
Malka shows you a Summary Card and waits. Nothing is built until you say yes.

**pre-deploy-checks**
A short list of questions Malka still needs answered before a card is finished. Paths sit in the Plan Card's `CHECKS` slot.

**Exploration Pass**
A look at your data during the interview. Not a run.

**the gate**
That approval. Work does not start without it, and it is the only one.

**specification**
What you approved — the formulas, thresholds, and settings the code has to follow.

**run**
This request's full list of jobs. One request, one run.

**job**
One unit of work: one folder, one Writer, one Reviewer.

**`WAVE`**
A batch of jobs on the Plan Card. WAVEs run in order (serial). Jobs in the same WAVE run together (parallel). Omit `WAVE` when the Plan Card is one job.

## 

## 

## Agents dispatch

**Dispatch subagents**
Malka sends a Writer, then a Reviewer, for each ready job, until the list is done.

**Dispatch**
Sending a Writer out to build a job.

**Review**
Checking the files that came back against what you approved and the lab's coding rules.

**manifest**
The Reviewer's report of what the code actually set, compared with the card.

**route**
Which lab how-to files the Writer is told to read for this job.

**standing read**
Files the Writer always opens — project rules, coding rules, and that folder's templates.

**`FOLDER`**
Which job-folder this work writes into.

**`CARD`**
On a Reviewer Card, the Code-Writer Card this job was sent with.

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
Values only you may choose — the numbers that reach a manuscript. No one else picks these.

**`ASSUMED`**
A default the Writer took because you didn't specify something that wasn't reserved. Malka will tell you about these.

**`BLOCKED`**
The Writer stopped because something only you can decide was missing.

**`MISMATCH`**
The code doesn't match what you approved, or it breaks a lab coding rule.

**`UNAPPROVED`**
The Writer assumed a value that was yours to set.

**`MISSING`**
A file the job claimed to produce isn't there, or is empty.

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
A heading, a skeleton box, then one bullet per named bit of the shape. The form for a folder tree, a card, a Plan Card, or a layout. The writing rule lives in the repo `.claude/CLAUDE.md`.
