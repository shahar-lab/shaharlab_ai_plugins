# The Job Card (interview)

A Job Card is the instructions for one job. This beat writes it from a Plan Card line, right after that index is printed. Only `JOB` and `FOLDER` are copied straight off the line, plus `WAVE` when the Plan Card has more than one job — the Writer never sees the Plan Card, so a card born under a WAVE has to carry its own. The three slots this beat adds are `ROUTED READS`, `CHECKS`, and `SPECIFICATION` (§2). Keep each Job Card in hand; print only the Plan Card. Clarify reads this card's `CHECKS` and writes answers onto its `SPECIFICATION`. Dispatch later completes the same object for spawn (see `dispatch-job-card.md`).

## 1. Structure of the Job Card

The full card in one box. `Job Card` is its first line. One job is one tight block: no blank line between these slots. When the Plan Card is one job, skip the `WAVE` slot.

```text
Job Card

JOB
<one line>

FOLDER
<path> (new | existing | repair)

ROUTED READS
- <path>

CHECKS
- <knowledge-index entry>

SPECIFICATION
<values>
```

## 2. The three slots this beat adds

- **`ROUTED READS`**
  
  The craft files this job's Writer will open. Dispatch copies this slot onto the spawn card.

- **`CHECKS`**
  
  Which knowledge-index entries hold leftovers this job still has to answer. These are pointers into `knowledge-index.md`, not files: nobody opens a `CHECKS` bullet. Clarify follows each pointer to that entry's Deploy-checks. Dispatch drops this slot when it completes the card for spawn.

- **`SPECIFICATION`**
  
  The values this job will be built from. At birth it holds only what the prompt already gave; Clarify writes the rest onto it, and Confirm approves the filled slot.

`ROUTED READS` and `CHECKS` are filled in one walk. Open `knowledge-index.md` once per job and walk every catalog heading. Match an entry by **What it covers** against this job's `JOB` and `FOLDER` — which files the work needs, not which main-folder `FOLDER` sits in. The Common jobs table is the shortcut for listed kinds; still walk the catalog so a heading those rows omit is not missed. `assets/` files and `.png` paths belong on the card when this job writes that deliverable.

Every matching craft Path goes on `ROUTED READS` — a path, because the Writer opens it. An Explorer-only entry stays the Data Explorer's standing read.

In the same walk, name on `CHECKS` every matching entry whose Deploy-checks is not an em dash. Name the entry as the index heads it — its filename for a craft entry, its leftover-only label when Path is an em dash. Never a directory path: `CHECKS` says which entry to walk, and only `ROUTED READS` carries paths. A leftover-only entry has no craft to route, so it lands on `CHECKS` alone.

## 3. Examples of Job Cards

These cards match the Plan Card examples in `interview-plan-card.md`. One Job Card per Plan Card job; the other jobs in those examples follow the same shape.

### Example 1. One brms fit plus a posterior-mean figure

```text
Job Card
JOB
Fit a stay-by-reward regression, condition by trial-type, and plot the posterior means
FOLDER
analysis/stay_reward_x_condition/ (new)
ROUTED READS
- 02-analysis/regression/01_sampling_and_priors.md
- 02-analysis/regression/02_diagnostics.md
- 02-analysis/visualization/plot-types/plot-posterior.md
- 02-analysis/visualization/plot-types/plot-posterior.png
- 02-analysis/visualization/standards/EXPORT_STANDARD.md
CHECKS
- 01_sampling_and_priors.md
- plot-posterior.md
SPECIFICATION
stay ~ reward * condition * trial_type + (1 | id)
data/processed/trials.csv
```

### Example 2. WAVE 1 — repair preprocessing

```text
Job Card

JOB
Add a choice-stay logical column to the data

FOLDER
preprocessing/ (repair)

ROUTED READS
- 01-preprocessing/references/how-to-convert-raw-to-processed.md
- 01-preprocessing/references/conversion-and-filter-traps.md

CHECKS
- how-to-convert-raw-to-processed.md

SPECIFICATION
choice-stay logical column
```

### Example 2. model comparision using loo

```text
Job Card

JOB
Compare the three stay-by-reward fits with loo

FOLDER
analysis/stay_reward_x_condition_loo/ (new)

ROUTED READS

CHECKS
- Model comparison / loo

SPECIFICATION
compare stay_reward_x_condition, stay_reward_x_condition_easy, stay_reward_x_condition_hard
```

### Example 3. WAVE 1 — a model definition

```text
Job Card
WAVE
1
JOB
Write the generating .R and fitting .stan for the new RL model
FOLDER
models/rl_twostep/ (new)
ROUTED READS
- 03-models/references/how-to-write-a-model-definition.md
- 04-simulations/references/how-to-build-a-recovery-pipeline.md
CHECKS
- how-to-write-a-model-definition.md
- how-to-build-a-recovery-pipeline.md
SPECIFICATION
new RL model
```

### Example 4. First preprocessing of an online study

```text
Job Card
JOB
Clean the Pavlovia export into tidy tables and apply exclusions
FOLDER
preprocessing/ (new)
ROUTED READS
- 01-preprocessing/references/how-to-convert-collected-to-raw.md
- 01-preprocessing/references/how-to-convert-raw-to-processed.md
- 01-preprocessing/references/how-to-examine.md
- 01-preprocessing/references/how-to-summarise-exclusions.md
- 01-preprocessing/references/how-to-build-data-validation.md
- 01-preprocessing/references/conversion-and-filter-traps.md
- 01-preprocessing/references/handling-leaving-window.md
- 01-preprocessing/assets/example-examining-report.md
- 01-preprocessing/assets/example-summary-exclusions.md
- 01-preprocessing/assets/example-data-validation.html
CHECKS
- how-to-convert-collected-to-raw.md
- how-to-convert-raw-to-processed.md
- how-to-build-data-validation.md
- handling-leaving-window.md
SPECIFICATION
Pavlovia export in data/collected/
```

### Example 5. Descriptives of the sample

```text
Job Card
JOB
Describe the sample: counts, demographics, and questionnaire scores
FOLDER
analysis/descriptives/ (new)
ROUTED READS
- 02-analysis/descriptives/how-to-report-descriptives.md
CHECKS
- how-to-report-descriptives.md
SPECIFICATION
```
