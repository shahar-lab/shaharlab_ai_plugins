# The Writer Card

The Writer Card is the prompt string you pass when you spawn the Code Writer; it carries the variables of one job.
The subagent starts with an empty context — its agent file arrives first, your card second, and whatever
the card points at, third — so the card is the context you assemble, and most of what follows is about
what to leave out of it.

Two rules span every card. Leave standing behaviour to `agents/code-writer.md`, which reaches the agent
before your card does; a card that restates how it blocks or returns creates a second copy, and the two
drift apart silently. And keep the card to a screen — it lives in the dispatch call and nowhere on disk,
and one running longer than that has content where a path belongs.

You build one card per job in the plan `references/planning.md` produced at Step 2 — that file decides how
many jobs the request is, which folder each one writes into, and which of them go out in the same run.

## The slots

```
JOB
[one line, the job in the user's terms — no values]

FOLDER
[the one folder this dispatch writes into]

ROUTED READS
- [the Step 3 selection for this agent, from references/knowledge-index.md]

PROJECT STATE
[what exists on disk that this job builds on, including the files outside FOLDER it depends on]

SPECIFICATION
[the approved job, in the user's exact values]

RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```

**`JOB`** names the job and carries no values — "revise the exclusion criteria", never the numbers.
Values live in `SPECIFICATION` alone, so the two can never disagree.

**`FOLDER`** is this entry's folder from the plan, and it bounds **writing** only — the Writer holds §0's
whole tree and reads across the project as the work requires. It also resolves the one variable in the
reads the Writer takes on every job: its agent file instructs it to read the two constitution files plus
the `rules.md` of its folder's own domain, which §0's tree maps.

**`ROUTED READS`** is what you *decided* — the craft files for the stages this job involves, derived from
`references/knowledge-index.md` alone. List paths and let the subagent open them itself: a few hundred
tokens on the pointer against thousands on the library, which is the trade the subagents exist for. A file
left off is knowledge the subagent works without; a file beyond the job's stages is context spent on
nothing. The two constitution files and the folder's `rules.md` stay off this list: `FOLDER` already
determines them, and a read the agent file states survives a card that forgot it.

**`PROJECT STATE`** names what the job builds on — the folder being cloned, the profile the exploration
pass returned, the scripts the user asked to revise — and the files outside `FOLDER` it depends on. Name the
**path** and let the agent open it; describe columns or objects only for a file that is not on disk yet.
This is a head start, not a permission list: it saves the agent from discovering what you already know
matters, and it stays silent about the rest of the project, which the agent may read anyway. Leave the slot
out when the job starts from an empty folder and depends on nothing outside it.

**`SPECIFICATION`** is the approved job in the user's own values, in full — the Writer's only source for
every threshold, formula, and setting the job needs. A value missing here is a value the Writer has to
guess or block on.

Quote it from this job's section of `.malka/current_job.md`, which `planning.md` had you write at
Step 2, rather than composing it again from the conversation. The card stays self-contained — the
Writer reads the values here and opens nothing — while the file stays the one text every card is
copied from. The Code Reviewer reads that same file at the end of the run, so a value mistyped onto a
card surfaces as a `MISMATCH` rather than as code nobody questions.

**`RETURN`** lists the returns you will act on, and carries `BLOCKED` and `ADDED READS` on every card. An
agent given a way to say the specification is silent will use it; an agent given none picks a default
instead. `ADDED READS` is the same principle applied to your routing: a Writer that needed a craft file
you left off says so, rather than writing the deliverable without it and leaving you to never find out.

The Writer names the files it writes, from its folder's naming rules — you name the folder, not the
filenames.

## Card examples

### Example 1 — revising exclusions on an existing pipeline

The study ran in person. The user gave both cutoffs in their own numbers and asked for the summary to be
regenerated.

```
JOB
Revise the exclusion criteria and regenerate the exclusion summary.

FOLDER
preprocessing/

ROUTED READS
- coding-knowledge/01-preprocessing/references/how-to-convert-raw-to-processed.md
- coding-knowledge/01-preprocessing/references/how-to-summarise-exclusions.md
- coding-knowledge/01-preprocessing/assets/example-summary-exclusions.md

PROJECT STATE
The pipeline exists and runs. Revise these two scripts in place:
  preprocessing/code/converting_data_raw_to_processed.R
  preprocessing/code/summary_exclusions.R
The collected→raw and examining_ scripts are unchanged; leave them closed.
Study ran in person — no window_status column, no window-exit criterion.

SPECIFICATION
Participant-level (phase 1): exclude a subject with fewer than 50 valid trials.
Trial-level (phase 2): drop a trial with RT < 200 ms or RT > 3000 ms.
Both values replace what the pipeline uses now.
Regenerate summary_exclusions.md so its cascade tables report these two phases.

RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```

The two scripts sit in `PROJECT STATE` because the *user* named them, not because you chose filenames.

### Example 2 — the analysis dispatch that follows a preprocessing dispatch

Second dispatch of a two-folder job. Preprocessing finished and left its product on disk.

```
JOB
Fit the stay-by-reward regression and plot its posteriors.

FOLDER
analysis/stay_by_reward/          (new — scaffold it)

ROUTED READS
- coding-knowledge/02-analysis/regression/01_sampling_and_priors.md
- coding-knowledge/02-analysis/regression/02_diagnostics.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.png
- coding-knowledge/02-analysis/visualization/standards/EXPORT_STANDARD.md

PROJECT STATE
The folder does not exist yet — scaffold it from its rules.md and templates.
Input, written by this job's preprocessing dispatch and readable on disk:
  data/processed/df_trials.rds
Open it to confirm the column names before using them.

SPECIFICATION
Model: brms, stay_ch ~ reward_oneback + (reward_oneback | subject)
Family: bernoulli
Priors: normal(0, 1) on the fixed effects; package defaults elsewhere.
Sampling: 4 chains, 2000 iterations, half warmup.
Figure: one posterior plot of the fixed effects, no colour.

RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```

---

With the card built, `references/dispatch.md` carries the spawn and the return.
