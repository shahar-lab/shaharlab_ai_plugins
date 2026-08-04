# Dispatch — the Cards and the Build Loop

A card is the prompt string you pass when you spawn a subagent; it carries the variables of one job. The
subagent starts with an empty context — its agent file arrives first, your card second, and whatever the
card points at, third — so the card is the context you assemble, and most of what follows is about what to
leave out of it.

Two rules span every card. Leave standing behaviour to `agents/code-writer.md` and
`agents/code-reviewer.md`, which reach the agent before your card does; a card that restates how an agent
blocks or returns creates a second copy, and the two drift apart silently. And keep the card to a screen —
it lives in the dispatch call and nowhere on disk, and one running longer than that has content where a
path belongs.

This file runs once per entry in the plan `references/planning.md` produced at Step 2 — that file decides
how many dispatches the job is and which folder each one writes into.

## 1 · Dispatching the Code Writer

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
The output paths, plus any ASSUMED tags. Or BLOCKED and the question.
```

**`JOB`** names the job and carries no values — "revise the exclusion criteria", never the numbers.
Values live in `SPECIFICATION` alone, so the two can never disagree.

**`FOLDER`** is this entry's folder from the plan, and it bounds **writing** only — both agents hold §0's
whole tree and read across the project as the work requires. It also resolves the one variable in the reads
both agents take on every job: each agent file instructs it to read the two constitution files plus its
folder's `01-folder-specific-rules/<type>/rules.md`, which §0's tree maps.

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

**`SPECIFICATION`** is the approved job in the user's own values. The checklists catch convention
violations; only this catches code that is clean and does the wrong thing.

**`RETURN`** lists the returns you will act on, and carries `BLOCKED` on every card. An agent given a way
to say the specification is silent will use it; an agent given none picks a default instead.

The Writer names the files it writes, from its folder's naming rules — you name the folder, not the
filenames.

### Cards examples

#### Example 1 — revising exclusions on an existing pipeline

The study ran in person. The user gave both cutoffs in their own numbers and asked for the summary to be
regenerated.

```
JOB
Revise the exclusion criteria and regenerate the exclusion summary.

FOLDER
preprocessing/

ROUTED READS
- coding-knowledge/03-preprocessing/references/how-to-convert-raw-to-processed.md
- coding-knowledge/03-preprocessing/references/how-to-summarise-exclusions.md
- coding-knowledge/03-preprocessing/assets/example-summary-exclusions.md

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
The output paths, plus any ASSUMED tags. Or BLOCKED and the question.
```

The two scripts sit in `PROJECT STATE` because the *user* named them, not because you chose filenames.

#### Example 2 — the analysis dispatch that follows a preprocessing dispatch

Second dispatch of a two-folder job. Preprocessing passed review and left its product on disk.

```
JOB
Fit the stay-by-reward regression and plot its posteriors.

FOLDER
analysis/stay_by_reward/          (new — scaffold it)

ROUTED READS
- coding-knowledge/05-bayesian-regression/01_sampling_and_priors.md
- coding-knowledge/05-bayesian-regression/02_diagnostics.md
- coding-knowledge/04-visualization/references/plot-types/plot-posterior/instructions.md
- coding-knowledge/04-visualization/references/plot-types/plot-posterior/example.R
- coding-knowledge/04-visualization/references/plot-types/plot-posterior/example.png
- coding-knowledge/04-visualization/references/standards/EXPORT_STANDARD.md

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
The output paths, plus any ASSUMED tags. Or BLOCKED and the question.
```

---

## 2 · Dispatching the Code Reviewer

Build this card alongside the Writer's, before dispatching either — constructing them together is what
keeps the Reviewer checking the work the Writer was told to write. Every slot but `TARGET` is fixed at that
point; `TARGET` fills in from what the Writer returns.

It is the Writer's card with four moves applied. `FOLDER`, `PROJECT STATE`, and `SPECIFICATION` are copied
unchanged.

| Move | From | To |
|---|---|---|
| add `TARGET` | — | the paths the Writer returned |
| swap `ROUTED READS` | the index's `W` rows | its `R` rows |
| change `JOB`'s verb | *fit / write / revise* | *review* |
| change `RETURN` | output paths + `ASSUMED` tags | `PASS` / `FAIL` |

`TARGET` is the Reviewer's alone. The Writer derives its filenames from its folder's naming rules, so
naming them for it would put you in a position to contradict those rules; the Reviewer has to be told
which files to open.

The `W`/`R` split is not a formality: the Writer gets instruction files and `assets/` examples to
imitate, the Reviewer gets `review-checklist.md` to gate with. A Reviewer handed the Writer's `example.R`
starts reviewing against a reference implementation instead of the rules. Where a stage ships no
checklist, `references/knowledge-index.md` names what stands in for it.

Copying `PROJECT STATE` and `SPECIFICATION` verbatim costs a few tokens; trimming either is a judgement
that can cost a finding.

### Cards examples

#### Example 3 — the Reviewer for the analysis dispatch of Example 2

```
JOB
Review the stay-by-reward regression and its posterior figure.

FOLDER
analysis/stay_by_reward/

TARGET
analysis/stay_by_reward/main.R
analysis/stay_by_reward/code/fit_model.R
analysis/stay_by_reward/code/check_diagnostics.R
analysis/stay_by_reward/code/plot_posteriors.R

ROUTED READS
- coding-knowledge/05-bayesian-regression/01_sampling_and_priors.md
- coding-knowledge/05-bayesian-regression/02_diagnostics.md
- coding-knowledge/04-visualization/references/plot-types/plot-posterior/instructions.md
- coding-knowledge/04-visualization/references/standards/EXPORT_STANDARD.md
- coding-knowledge/02-scaffolding/references/review-checklist.md

PROJECT STATE
[copied from the Writer's card]

SPECIFICATION
[copied from the Writer's card]

RETURN
PASS or FAIL. Or BLOCKED and what is missing.
```

The scaffolding checklist is routed here and not to the Writer, and the two `plot-posterior` examples are
routed there and not here — that is the `W`/`R` split doing its work.

---

## 3 · Running the loop

Dispatch the **Code Writer**, then the **Code Reviewer**. On `PASS`, run this file again for the next entry
in the plan, or move to Step 5 when none remain. Treat `PASS` as the only passing verdict — every other verdict takes the
`FAIL` path.

On `FAIL`, re-dispatch the Writer with the same card plus the revision block, then re-dispatch the
Reviewer. Routing holds across rounds — the job is the same job, and only the task has moved from writing
to fixing.

```
REVISION — ROUND [N]
Your previous attempt is in [folder]. The reviewer tagged findings as # REVIEW[...]
comments in these files:
  [one path per line]
```

Run at most **three review rounds per dispatch**. Through all of them you relay control rather than
content: the findings are tagged inside the code where the Writer reads them, so leave the files closed
and take each agent's return at face value.

---

## 4 · Troubleshooting

| What comes back | What it means | What you do |
|---|---|---|
| Writer `BLOCKED`, naming a file it needs | you under-routed `ROUTED READS` | add the file, re-dispatch |
| Writer `BLOCKED`, no defensible default | the specification is silent | get the value from the user, amend both cards |
| Writer `BLOCKED`, needs a write outside `FOLDER` | the job crosses folders | revise the plan into a chain of dispatches, per `planning.md` |
| Writer `BLOCKED`, `FOLDER` contradicts the work | the route is wrong | re-route on §0's tree and §2.III |
| Reviewer `BLOCKED`, nothing to check against | the specification is silent | get the value from the user, amend both cards |
| `FAIL` after three rounds | usually a Step 1 gap | stop; see below |

A `BLOCKED` question arrives phrased about the analysis rather than the code, because neither agent
knows you do not read their file. Take it to the user, get the value in their own words, amend both
cards, and re-dispatch. A blocked round leaves the three-round count untouched, since no review happened.

This is why your conversational role stays open past the interview gate. A gap that surfaces only once code
is being written still belongs to the user, and you are the only channel to them.

**When the loop does not converge.** After three rounds without a `PASS`, stop. Tell the user where the
files are, that unresolved `REVIEW` comments remain inside them, and ask how they want to proceed. The
usual cause is a specification gap from Step 1, which they can close and you cannot.
