# How to write `converting_data_raw_to_processed.R`

The second `converting_` script in the pipeline. It reads `data/raw/`, applies the exclusions the
user approved, adds the calculated columns the plan names, and saves the result to
`data/processed/`. The folder it writes into and the three prefixes it is named under are defined
in `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-preprocessing/context.md`.

Every criterion and every cutoff in this script came from the user through Malka's interview and
arrives in the Job Card. Implement exactly the approved plan.

## What this stage does

`processed/` is `raw/` after two things only: exclusion of participants and of observations, and
addition of calculated columns. Every exclusion count this script produces is a number that
appears in the manuscript, so the code is written to make those counts recoverable: each
criterion gets its own named surviving dataset, and `summary_exclusions.R` reads those names
afterwards.

Run the exclusions in two phases, in this order:

1. **Participant phase** — whole-subject removal (left the session early, subject-level RT
   thresholds).
2. **Trial phase** — observation removal, applied to the participants that survived phase 1
   (no response, RT bounds).

Within each phase, apply the criteria one at a time in the order the approved plan lists them, so
each criterion filters the survivors of the one before it and every count stays attributable to a
single criterion. A job with a further phase (session-level, block-level) puts it where the plan
puts it. Calculated columns are added after the exclusions, on the surviving rows, using the
formulae the plan names.

For an online study, one of the participant criteria is usually how many times the participant left
the study window. Counting that takes a definition of its own — one exit is a *sequence* of trials
away, not one trial — so it has its own file: `handling-leaving-window.md`.

## Skeleton

```r
#### CONVERT RAW DATA TO PROCESSED ####

df <- readRDS(file.path(raw_dir, "data_raw.RDS"))

# Cutoffs (rt_min_sec, rt_max_sec, max_pct_fast_rt) come from main.R, where each one
# holds the value the user approved in the interview.

# Participant phase: name each surviving dataset, so the pipeline order reads off the code
incomplete_subjects <- df |>
  filter(session_status == "incomplete") |>
  distinct(subject_id) |>
  pull(subject_id)

after_incomplete <- df |> filter(!subject_id %in% incomplete_subjects)

fast_rt_subjects <- after_incomplete |>
  group_by(subject_id) |>
  summarise(pct_fast = 100 * mean(rt < rt_min_sec, na.rm = TRUE)) |>
  filter(pct_fast > max_pct_fast_rt) |>
  pull(subject_id)

after_fast_rt <- after_incomplete |> filter(!subject_id %in% fast_rt_subjects)

# Trial phase: applied to the participants that survived the phase above
after_no_response <- after_fast_rt     |> filter(!is.na(choice))
after_rt_bounds   <- after_no_response |> filter(rt >= rt_min_sec, rt <= rt_max_sec)

df_processed <- after_rt_bounds

saveRDS(df_processed, file = file.path(processed_dir, "data_processed.RDS"))

# A processed data-validation report when the specification asks for one — see
# how-to-build-data-validation.md. Build the dictionary in this script (include
# calculated columns); do not rely on a tribble left behind by the raw step.
write_data_validation_report(
  df_processed,
  trials_dictionary,
  "trials",
  suffix = "processed"
)
```

## Rules for the code

- Read from `raw_dir` and write the tidy table to `processed_dir`; a processed data-validation
  HTML goes to `output_dir`. All three variables come from `main.R`.
- Anchor every path with `project_root <- here::here()` and build it with `file.path()`.
- Chain operations with the base pipe `|>`, and call functions directly, adding any missing
  package's `library()` call to `main.R`'s `#### SETUP ####` block.
- Give each exclusion step its own named dataset (`after_no_response`, `after_rt_bounds`), so the
  pipeline order is visible in the code and every count is recoverable afterwards by comparing two
  named objects.
- Hold each cutoff in a named variable (`rt_min_sec`, `max_pct_fast_rt`) set once in `main.R` from
  the user's approved value, and reference that variable in the filter here and in the criterion
  text `summary_exclusions.R` writes, so filter and report agree by construction.
- Name the survivors `df_processed`, and leave every intermediate `after_*` object and every
  excluded-ID vector in the environment — `summary_exclusions.R` and
  `summary_manuscript_paragraph.R` are sourced after this script and read them.
- When the specification asks for a processed data-validation report, call
  `write_data_validation_report(..., suffix = "processed")` after `saveRDS`. The helper is sourced
  from `main.R`'s `#### SETUP ####`.
- Keep the script to 50–80 lines. A plan with enough criteria to break that splits by phase into a
  second `converting_` script.

## Where each cutoff comes from

The Job Card carries the criteria in the user's own words and their numbers. A cutoff the
card is silent on is a decision nobody has made — take a defensible default, mark it where it
happens, and let Malka carry it back to the user:

```r
# ASSUMED[no criterion given]: dropped subjects with fewer than 10 trials
```

Where guessing wrong would mean rewriting the analysis, return `BLOCKED` with the question phrased
about the analysis rather than the code.

## What comes next

| Script | File |
|---|---|
| processed data-validation HTML | `how-to-build-data-validation.md` |
| `examining_data_processed.R` | `how-to-examine.md` |
| `summary_exclusions.R`, `summary_manuscript_paragraph.R` | `how-to-summarise-exclusions.md` |
