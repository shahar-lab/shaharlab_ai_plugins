# How to report descriptives

A descriptives folder answers "who took part and what did they look like" from
`data/processed/`. It produces the participant counts, the demographics table, and the
per-measure distributions a manuscript's Participants section is written from.

It holds no fitted model, so it is **one folder for the coherent set** however many figures and
tables it produces, per `../context.md`. That same file states the folder's structure and the
`main.R` path block every script here reads its paths from.

**This is the analysis-stage description, not the pipeline's.** The `examining_` reports written
during preprocessing check what survived each conversion, and they read `data/raw/` as well as
`data/processed/`. A descriptives folder reads `data/processed/` alone and reports the analyzed
sample as the manuscript will describe it.

## What the folder produces

| Product | Goes to | Holds |
|---|---|---|
| the participant table | `output/` | one row per group, or one row total for a single-sample study |
| the demographics table | `output/` | one row per demographic variable, summarised by group where the study has groups |
| the measure table | `output/` | one row per questionnaire score or behavioral summary measure |
| the distribution figures | `output/` | one figure per measure worth showing as a distribution rather than as a mean |
| the per-participant frame | `artifacts/` | one row per participant, every summary measure as a column |

Build the per-participant frame first and save it to `artifacts/`. Every table and figure here
reads it back, so each participant is summarised once and the tables cannot disagree with the
figures.

## Collapsing to one row per participant

`data/processed/` is one row per observation. Almost everything a descriptives folder reports is
per participant, so the first script collapses it and saves the result.

```r
#### PREPARE THE PARTICIPANT FRAME ####

df <- readRDS(file.path(processed_dir, "data_processed.RDS"))

per_participant <- df |>
  group_by(subject_id) |>
  summarise(
    across(all_of(participant_constant_columns), first),
    n_trials  = n(),
    rt_mean   = mean(rt, na.rm = TRUE),
    rt_sd     = sd(rt, na.rm = TRUE),
    pct_left  = 100 * mean(choice == "left", na.rm = TRUE)
  )

saveRDS(per_participant, file.path(artifacts_dir, "per_participant.RDS"))
```

`participant_constant_columns` names the columns that repeat unchanged on every row of a
participant — age, gender, group, condition assignment, each questionnaire's total score. Set it
in `main.R` beside the other named variables, so the one place it is stated is the place the
reader looks. Take `first()` on those and compute the rest, which keeps a per-observation column
from being averaged into a number that means nothing.

Where a questionnaire's items are still per-item rows rather than a scored total, the scoring
belongs in `preprocessing/` — see `../../01-preprocessing/references/`. This folder reads
scores that already exist.

## The participant table

The headline counts, and the first thing a reader looks for:

```r
participant_table <- per_participant |>
  group_by(group) |>
  summarise(
    n_participants = n(),
    n_observations = sum(n_trials),
    trials_min     = min(n_trials),
    trials_median  = median(n_trials),
    trials_max     = max(n_trials)
  )
```

Drop the `group_by()` for a single-sample study and the table becomes its one row. Where the
study has more than one grouping variable that matters — a between-subjects factor crossed with a
site, say — group by both, so an unbalanced cell is visible rather than averaged away.

Report the analyzed sample here and say so in the table's caption. The count before exclusions,
and the cascade from one to the other, is `summary_exclusions.md`'s report in `preprocessing/` —
name that file in the caption rather than recomputing its numbers, so one exclusion count exists
in the project.

## The demographics table

One row per demographic variable, so a continuous variable and a categorical one read side by
side:

```r
age_row <- per_participant |>
  group_by(group) |>
  summarise(
    variable = "Age",
    summary  = paste0(round(mean(age, na.rm = TRUE), 1),
                      " (", round(sd(age, na.rm = TRUE), 1), ")"),
    missing  = sum(is.na(age))
  )

gender_row <- per_participant |>
  count(group, gender) |>
  group_by(group) |>
  summarise(
    variable = "Gender",
    summary  = paste(gender, n, sep = ": ", collapse = ", "),
    missing  = sum(is.na(gender))
  )

demographics_table <- bind_rows(age_row, gender_row)
```

A continuous variable reports mean and SD, a categorical one reports each label and its count,
and both report how many participants the value is missing for. Carry the missing column even
when it is all zeros: a reader cannot tell a complete variable from an unreported one otherwise.

Add one block per demographic variable the study collected. Where a study collected many, keep
each block to its own named object and bind them at the end, so a variable can be added or
dropped without touching the others.

## The measure table

The same shape, one row per questionnaire score or behavioral summary measure:

```r
measure_table <- per_participant |>
  select(group, all_of(measure_columns)) |>
  pivot_longer(all_of(measure_columns), names_to = "measure", values_to = "score") |>
  group_by(group, measure) |>
  summarise(
    n       = sum(!is.na(score)),
    mean    = round(mean(score, na.rm = TRUE), 2),
    sd      = round(sd(score, na.rm = TRUE), 2),
    min     = round(min(score, na.rm = TRUE), 2),
    max     = round(max(score, na.rm = TRUE), 2),
    missing = sum(is.na(score)),
    .groups = "drop"
  )
```

`measure_columns` names the scored measures, set in `main.R` alongside
`participant_constant_columns`. Report the observed range beside the mean, so a score outside its
instrument's possible range is visible in the table that a reader is already looking at.

## The distribution figures

A mean and an SD hide bimodality, a floor effect, and a ceiling effect alike. Plot the
distribution of any measure the analysis rests on, rather than reporting its two numbers alone.

Build each figure from the plot-type knowledge in `../visualization/plot-types/` rather than from
raw ggplot — `plot-dot-histogram.md` shows every participant as a point and suits a sample of a
few hundred, which is what most of these figures are. Where the card routed no plot-type file for
a figure the specification asks for, take one as an `ADDED READ`. Export follows
`../visualization/standards/EXPORT_STANDARD.md`, and a multi-panel composite follows
`PANEL_TAGGING_STANDARD.md` beside it.

One script per figure type, named for what it plots behind its two-digit prefix, and each reads
`per_participant.RDS` back from `artifacts/`.

## Which measures and groupings get reported

The variables to describe, the groupings to break them down by, and the measures worth a
distribution figure all come from the approved specification. Where the specification names a
measure this folder cannot find a column for, return `BLOCKED` and say which column is missing
rather than substituting the nearest one.

Report what the data holds and leave the interpretation out. A note that a group differs on a
demographic variable is a claim that needs a model, so it belongs in a folder that fits one.

## Rules for the code

- Read `data/processed/` by path from `processed_dir`, set in `main.R`.
- Save the per-participant frame to `artifacts_dir` and every table and figure to `output_dir`.
- Render every table with `kable(x, format = "pipe")`, matching the reports the pipeline writes.
- Build each table from the participant frame itself, so every number recomputes when the data
  changes.
- Chain operations with the base pipe `|>` and named intermediate objects, calling functions
  directly and adding any missing package's `library()` call to `main.R`'s `#### SETUP ####`
  block.
- Keep each script to 50–80 lines, splitting a longer one into two named steps.
