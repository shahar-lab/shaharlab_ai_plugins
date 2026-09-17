# How to convert raw data to processed data

## 1. Context for writing you script:
Raw data becomes processed data by applying exclusion criteria one at a time.
Each criterion is its own `source()` call in `main.R`. Write the criterion as a comment above that call. The sourced script drops the observations that fail it.

Every step does the same four things:

1. Load the current data — raw data on the first step; otherwise the table saved by the previous step.
2. Apply this step's exclusion.
3. Append counts and notes to `output/processed/exclusion.md`.
4. Save the surviving data.

When the last criterion has run, write the final table to `data/processed/` and add the final observation counts to `exclusion.md`. After the exclusions, add the calculated columns the plan names.

## 2. Rules and guidelines

* Criteria and cutoffs come from the Job Card. Implement exactly those. If the card is silent on a cutoff or cretria return `BLOCKED`.

* One criterion per sourced script. The comment above that `source()` in `main.R` is the criterion in the researcher's words.


* The first script reads `data_raw.RDS` from `raw_dir` and does not write to `data/raw/`. Every later script loads the RDS the previous step saved under `artifacts/`. Only the last script writes to `data/processed/`.

* Hold each cutoff in a named variable set once in `main.R` (`rt_min_sec`, `max_pct_fast_rt`, …). Use that same variable in the filter and in the text written to `exclusion.md`.

* Use `tidyverse`. Chain with `|>`. Add any missing `library()` to `main.R`'s `#### SETUP ####` block.

* Count before and after every filter: `n_distinct(subject_id)` for participant steps, `nrow()` for trial steps. The first script starts `output/processed/exclusion.md`; later scripts append; the last script adds the final N.

* Save the survivors after every step. Intermediate tables go to `artifacts/`. The last script names the table `df_processed` and writes it to `data/processed/` (RDS; CSV too if useful).

* Keep each script to 50–80 lines.

* For counting window exits in an online study, see `handling-leaving-window.md`.

## 3. Examples

#### Example for a `source()` block in `main.R` is the pipeline. Each comment is one criterion:

```r
#### PROCESSED DATA ####

# Exclude participant that did not complete all sessions
source(file.path(code_dir, "07_exclude_participants_incomplete_sessions.R"))

# Exclude participants who left the window twice or more, or for more than 30
# seconds total.
source(file.path(code_dir, "08_exclude_participants_leave_window.R"))

# Exclude trials with NA, under 300ms RT or above 3sec RT. 
source(file.path(code_dir, "09_exclude_trials_NA_RToutlier.R"))

# Excluse participants with more the 20% trials ommited in the previous step
source(file.path(code_dir, "09_exclude_participants_few_trials.R"))

```

##### Example for one exclusion script, here the first (participant-level) step:

```r
# reads: data/raw/data_raw.csv
# writes: artifacts/07_after_incomplete_sessions.rds, reports-processed/exclusion.md

#### EXCLUDE PARTICIPANTS: MISSING A SESSION ####

df <- read_csv(file.path(raw_dir, "data_raw.csv"), show_col_types = FALSE)

subjects_all <- unique(as.character(df$subject_id))

subjects_excluded <- df |>
  distinct(subject_id, session) |>
  count(subject_id, name = "n_sessions") |>
  filter(n_sessions < n_sessions_required) |>
  pull(subject_id)

subjects_after <- setdiff(subjects_all, subjects_excluded)

n_started  <- length(subjects_all)
n_excluded <- length(subjects_excluded)
n_left     <- length(subjects_after)

criterion_text <- "Did not complete all sessions"

writeLines(
  c(
    "# Exclusion summary",
    "",
    paste0(
      "1. ", criterion_text, ". Started with ", n_started,
      " participants, excluded ", n_excluded, ", ", n_left, " left."
    )
  ),
  file.path(reports_processed_dir, "exclusion.md")
)

saveRDS(
  list(subjects_all = subjects_all, subjects_after = subjects_after, subjects_excluded = subjects_excluded),
  file.path(artifacts_dir, "07_after_incomplete_sessions.rds")
)
```

#### Example for an `exclusion.md` summary file:

```
# Exclusion summary

1. Did not have both sessions. Started with 11 participants, excluded 1, 10 left.
2. Left the window twice or more, or more than 30 seconds total, on either time1 or time2, during PHQ9 or CBCU. Started with 10 participants, excluded 0, 10 left.
3. Trials with NA, RT quicker than 0.5 seconds, or RT slower than 15 seconds. Started with 2100 trials, excluded 88, 2012 left.
4. Trial exclusion took more than 15% of trials on either time1 or time2. Started with 10 participants, excluded 1, 9 left.
```