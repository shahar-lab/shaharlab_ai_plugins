# The Reviewer Card

Opened at Step 2 after that Writer has returned. The prompt you pass when you spawn the Code Reviewer.

The Reviewer takes the constitution files on its own standing instruction. Spawn this Reviewer as soon as this Writer returns, one card per return, that Writer's folder only.

## The slots

The first line is the name. Then WAVE when the Plan Card has more than one job. Then JOB. Then these four slots. How-tos, covering-folder `context.md`, and `pre-deploy-checks.md` stay with the Writer; constitution files arrive with the Reviewer's standing instruction.

```text
Reviewer Card

WAVE
[WAVE N — omit when the Plan Card is one job]

JOB
[the same line as on the Plan Card]

FOLDER
[this job's folder]
[the paths its Writer returned]

CARD
[the Code-Writer Card this job was dispatched with, quoted in full]

REPORTED
[every ASSUMED tag this Writer reported, with the file each came from]

RETURN
The manifest, plus any MISMATCH, UNAPPROVED, or MISSING findings. Or CLEAN.
```

- **Reviewer Card**

  The name. First line of every copy.

- **`WAVE`**

  The batch this job sits in on the Plan Card. Omit when the Plan Card is one job.

- **`JOB`**

  The Plan Card's one-line name for this job. Same line as on the Code-Writer Card.

- **`FOLDER`**

  This job's folder, then the paths its Writer returned, carried verbatim, including any you have not opened yourself.

- **`CARD`**

  The Code-Writer Card text, the payload the Writer actually got. Critique and Confirm already locked it. Paste the text here.

- **`REPORTED`**

  Every `ASSUMED` tag this Writer reported, with the file each came from, as this Writer wrote them.

- **`RETURN`**

  The same standing line on every Reviewer Card. The Reviewer writes the manifest, plus any `MISMATCH`, `UNAPPROVED`, or `MISSING` findings, or `CLEAN`.

## Card example

A filled Reviewer Card of those four slots. The `CARD` slot holds a Code-Writer Card, so that card's own `RETURN` line sits inside it; the Reviewer Card's `RETURN` is the last slot.

```
Reviewer Card

WAVE 2
JOB
Fit the stay-by-reward regression and plot its posteriors.

FOLDER
analysis/stay_by_reward/
  analysis/stay_by_reward/main.R
  analysis/stay_by_reward/code/01_prep_data.R
  analysis/stay_by_reward/code/02_fit_model.R
  analysis/stay_by_reward/code/03_diagnostics.R
  analysis/stay_by_reward/code/04_plot_posterior.R
  analysis/stay_by_reward/artifacts/model_fit.rds
  analysis/stay_by_reward/output/diagnostic.pdf
  analysis/stay_by_reward/output/posterior_fixed_effects.pdf
  analysis/stay_by_reward/output/posterior_fixed_effects.png

CARD
Code-Writer Card

WAVE 2
JOB
Fit the stay-by-reward regression and plot its posteriors.

FOLDER
analysis/stay_by_reward/

ROUTED READS
- coding-knowledge/02-analysis/regression/01_sampling_and_priors.md
- coding-knowledge/02-analysis/regression/02_diagnostics.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.md
- coding-knowledge/02-analysis/visualization/plot-types/plot-posterior.png
- coding-knowledge/02-analysis/visualization/standards/EXPORT_STANDARD.md

PROJECT STATE
Input: data/processed/df_trials.rds

SPECIFICATION
Model: brms, stay_ch ~ reward_oneback + (reward_oneback | subject)
Family: bernoulli
Priors: normal(0, 1) on the fixed effects; package defaults elsewhere.
Sampling: 4 chains, 2000 iterations, half warmup.
Figure: one posterior plot of the fixed effects, no colour.

RETURN
The output paths, plus any ASSUMED tags and any ADDED READS. Or BLOCKED and the question.

REPORTED
04_plot_posterior.R — ASSUMED[no order given]: plotted the fixed effects in formula order.

RETURN
The manifest, plus any MISMATCH, UNAPPROVED, or MISSING findings. Or CLEAN.
```

## Acting on what comes back

One review, then at most one repair, then the user. What comes back is one of these four.

```text
RETURN
├── CLEAN
├── MISMATCH
├── UNAPPROVED
└── MISSING
```

- **`RETURN`**

  The Reviewer's last slot. The finding is one of the four that follow.

- **`CLEAN`**

  The code matches the card and the coding rules. Write this folder's `summary.md` from the manifest, and carry the manifest to Step 3.

- **`MISMATCH`**

  The code contradicts the card, or breaks a coding rule. Re-dispatch this job's Code-Writer Card with the finding quoted in `PROJECT STATE`, then review that folder once more.

- **`UNAPPROVED`**

  The Writer set a value that is the user's to set. Take it to the user with this WAVE's `BLOCKED` questions in one round, amend the card, re-dispatch.

- **`MISSING`**

  The dispatch reported a product it did not write. Re-dispatch that card once; on a second miss, stop the run and tell the user what is and is not on disk.

A folder that mismatches again after its repair goes to the user with both findings named. Several ready Reviewers go out in one message.
