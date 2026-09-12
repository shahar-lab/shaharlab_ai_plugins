# The Job Card (dispatch)

A Job Card is the instructions for one job, handed to the Code Writer at spawn. Dispatch completes it from the locked Job Card in `.malka/current_job.md`: copy `WAVE` / `JOB` / `FOLDER` / `ROUTED READS` / `SPECIFICATION`, drop `CHECKS`, add `PROJECT STATE` and `RETURN`. Prefix each `ROUTED READS` path with `coding-knowledge/`. Later WAVEs fill `PROJECT STATE` from what earlier WAVEs left on disk. This document shows the spawn shape.

## 1. Structure of the Job Card

```text
Job Card
```

- **Job Card**

  The first line of the card.

```text
WAVE
n
JOB
<one line>
FOLDER
<path> (new | existing | repair)
ROUTED READS
- coding-knowledge/<path>
PROJECT STATE
- <path or constraint>
SPECIFICATION
<values>
RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```

- **`WAVE`**

  Copied from the locked Job Card. When the Plan Card is one job, skip this slot.

- **`JOB`**

  Copied from the locked Job Card. Values live in `SPECIFICATION`.

- **`FOLDER`**

  Copied from the locked Job Card. Writing is bounded to this folder. Constitution files and this folder's `context.md` arrive with `FOLDER`.

- **`ROUTED READS`**

  Copied from the locked Job Card. Prefix each path with `coding-knowledge/`.

- **`PROJECT STATE`**

  Paths and constraints: the scripts the user named, the input file this job reads, the folder it clones. Name the path. Describe columns or objects only for a file that is not on disk yet. Write this slot when the folder already has files this job revises, or when this job reads a path outside it.

- **`SPECIFICATION`**

  Copied from the locked Job Card — formula, cutoffs, family, priors, sampling, plot type. One approved value per line.

- **`RETURN`**

  The same standing line on every spawn card. The Writer names the files it writes; you name the folder.

One job is one tight block: no blank line between these slots.

## 2. Examples

### Example 1 — revising exclusions on an existing pipeline

```text
Job Card
JOB
Revise the exclusion criteria and regenerate the exclusion summary.
FOLDER
preprocessing/
ROUTED READS
- coding-knowledge/01-preprocessing/references/how-to-convert-raw-to-processed.md
- coding-knowledge/01-preprocessing/references/how-to-summarise-exclusions.md
- coding-knowledge/01-preprocessing/assets/example-summary-exclusions.md
PROJECT STATE
- Revise in place: preprocessing/code/converting_data_raw_to_processed.R
- Revise in place: preprocessing/code/summary_exclusions.R
- Leave converting collected→raw and examining_ closed
- In person — no window_status
SPECIFICATION
- Phase 1 (participant): exclude if fewer than 50 valid trials
- Phase 2 (trial): drop RT < 200 ms or RT > 3000 ms
- Regenerate summary_exclusions.md cascade tables for these two phases
RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```

The two scripts sit in `PROJECT STATE` because the user named them, not because you chose filenames.

### Example 2 — a new analysis after preprocessing

```text
Job Card
WAVE
2
JOB
Fit the stay-by-reward regression and plot its posteriors.
FOLDER
analysis/stay_by_reward/ (new)
ROUTED READS
- coding-knowledge/02-analysis/regression/01_sampling_and_priors.md
- coding-knowledge/02-analysis/regression/02_diagnostics.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.png
- coding-knowledge/02-analysis/visualization/standards/EXPORT_STANDARD.md
PROJECT STATE
- data/processed/df_trials.rds
SPECIFICATION
- Formula: stay_ch ~ reward_oneback + (reward_oneback | subject)
- Family: bernoulli
- Priors: normal(0, 1) on the fixed effects; package defaults elsewhere
- Sampling: 4 chains, 2000 iterations, half warmup
- Figure: one posterior plot of the fixed effects, no colour
RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```

### Example 3 — a second analysis, different formula

```text
Job Card
JOB
Fit RT by condition and plot its posteriors.
FOLDER
analysis/go_nogo_rt/ (new)
ROUTED READS
- coding-knowledge/02-analysis/regression/01_sampling_and_priors.md
- coding-knowledge/02-analysis/regression/02_diagnostics.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.png
- coding-knowledge/02-analysis/visualization/standards/EXPORT_STANDARD.md
PROJECT STATE
- data/processed/df_trials.rds
SPECIFICATION
- Formula: rt ~ condition + (1|subject)
- Family: gaussian
- Priors: normal(0, 1) on the fixed effects; package defaults elsewhere
- Sampling: 4 chains, 2000 iterations, half warmup
- Figure: one posterior plot of the fixed effects, no colour
RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```
