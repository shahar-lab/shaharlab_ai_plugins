# The Reviewer Card

The prompt you pass when you spawn the Code Reviewer; it carries one run's worth of finished work.
You build one per **run**, after every Writer in that run has returned — one per run, whatever the
number of jobs in it.

The Reviewer starts with an empty context: its agent file arrives first, your card second. Its card is
smaller than a Writer Card by design. Where the Writer Card routes craft knowledge, this one routes
nothing: the Reviewer takes the two constitution files and each folder's `rules.md` on its own
standing instruction, opens the specification and the run's files, and leaves the craft library out of
its context. That absence is what holds the check to one spawn per run.

## The slots

```
RUN
[which run of the plan this is, and what it was to leave behind]

FOLDERS
[one block per job in the run: the folder, then the paths its Writer returned]

SPECIFICATION
.malka/current_job.md — sections: [the folders this run covers]

REPORTED
[every ASSUMED tag the run's Writers reported, with the file each came from]

RETURN
The manifest, plus any MISMATCH, UNAPPROVED, or MISSING findings. Or CLEAN.
```

**`SPECIFICATION` is a path, not quoted text.** `planning.md` had you write the approved
specification to `.malka/current_job.md` at Step 2, and the Reviewer opens it there. Pasting the
values onto this card instead would have the Reviewer comparing the code against your copy of the
specification — and a value mistyped onto a Writer Card would then be mistyped identically here,
which is the one error this whole beat exists to catch.

**`FOLDERS` carries the returned paths verbatim**, including any you have not opened yourself. Pass 1
exists to catch a path that names nothing, so filtering the list first removes the finding.

**`REPORTED` carries the tags as the Writers wrote them**, without your reading of them. The Reviewer
decides which tags took a value that was the user's to set; handing it your own triage settles that
question before it is asked.

There is no `ROUTED READS` slot on this card. A `coding-knowledge/02`–`06` path appearing here means
the narrow role has grown back into the one `45d2c1b` removed.

## Card example

Second run of a two-run plan. One job, one folder, freshly scaffolded.

```
RUN
Run 2 of 2 — the analysis folder reading the processed data run 1 rebuilt.

FOLDERS
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

SPECIFICATION
.malka/current_job.md — section: analysis/stay_by_reward/

REPORTED
04_plot_posterior.R — ASSUMED[no order given]: plotted the fixed effects in formula order.

RETURN
The manifest, plus any MISMATCH, UNAPPROVED, or MISSING findings. Or CLEAN.
```

## Acting on what comes back

One review, then at most one repair, then the user. That bound is what holds the beat at roughly one
extra spawn per run.

| What comes back | What it means | What you do |
|---|---|---|
| `CLEAN` | the code says what was approved | write each scaffolded folder's `summary.md` from the manifest, and carry the manifest to Step 5 |
| `MISMATCH` | the code contradicts the specification, or breaks a structural rule | re-dispatch that job's Writer Card with the finding quoted in `PROJECT STATE`, then review that folder once more |
| `UNAPPROVED` | the Writer set a value that is the user's to set | take it to the user with the run's `BLOCKED` questions in one round, amend the card, re-dispatch |
| `MISSING` | the dispatch reported a product it did not write | re-dispatch that card once; on a second miss, stop the plan and tell the user what is and is not on disk |

A folder that mismatches again after its repair goes to the user with both findings named. Two Writers
disagreeing with the specification twice on one folder points at a gap in the specification rather
than at the code, and you are the only channel to the person who can close it.

---

With the run reviewed, `references/folder-summary.md` carries what each `summary.md` says, and it takes
its values from the manifest.
