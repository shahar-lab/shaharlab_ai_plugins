# The Code-Writer Card

A Code-Writer Card is the instructions for one job that will be later handed to the Code-Write. The Code-Writer card includes information regarding what to write, where, from which files, and with which approved values. This document shows how to structure one.

## 1. Stracture of the Code-Writer Card

The first line is the name. Then WAVE when the Plan Card has more than one job. Then these six slots.

```text
Code-Writer Card

WAVE
[WAVE N — omit when the Plan Card is one job]

JOB
[one line — the same line as on the Plan Card]

FOLDER
[the job-folder path this dispatch writes into]

ROUTED READS
- [this job's craft files, from references/knowledge-index.md]

PROJECT STATE
- [path or constraint the Writer would otherwise have to discover]
  [omit the slot when the folder is empty and nothing outside it is needed]

SPECIFICATION
- [one approved value per line]

RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.
```

- **Code-Writer Card**
  
  The name. First line of every copy.

- **`WAVE`**

  The batch this job sits in on the Plan Card. Omit when the Plan Card is one job.

- **`JOB`**
  
  The Plan Card's one-line name for this job — "revise the exclusion criteria". Values live in `SPECIFICATION`.

- **`FOLDER`**
  
  The job-folder path from the Plan Card (`preprocessing/`, `analysis/stay_by_reward/`). The main-folder is already in the path. Writing is bounded to this folder. Constitution files and this folder's `context.md` arrive with `FOLDER`. Mark new / clone / repair on the path line when it is not obvious.

- **`ROUTED READS`**
  
  The craft this job needs, from `references/knowledge-index.md` alone. List paths. A file left off is knowledge the Writer works without.

- **`PROJECT STATE`**
  
  Paths and constraints: the scripts the user named, the input file this job reads, the folder it clones. Name the path. Describe columns or objects only for a file that is not on disk yet. Omit the slot when the folder is empty and nothing outside it is needed.

- **`SPECIFICATION`**
  
  The user's values for this job — formula, cutoffs, family, priors, sampling, plot type. One approved value per line.

- **`RETURN`**
  
  The same standing line on every card. The Writer names the files it writes; you name the folder.

## 2. Examples

### Example 1 — revising exclusions on an existing pipeline

A filled Code-Writer Card of those six slots.

```
Code-Writer Card
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

The two scripts sit in `PROJECT STATE` because the *user* named them, not because you chose filenames.

### Example 2 — a new analysis after preprocessing

```
Code-Writer Card

WAVE 2
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

```
Code-Writer Card
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
