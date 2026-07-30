# Writing Preprocessing Code

Reached from Malka's `execution-card.md`, which carries the approved plan and the user's
exclusion values. This file owns the craft: where the scripts go, what the pipeline looks
like, the coercion and exclusion patterns the lab uses, and the two reports the pipeline
produces. The topology it writes into is defined in
`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-scaffolding/references/folder_structure.md`.

## Data stages and file layout

```
preprocessing/
├── code/               build_raw.R · build_processed.R · manuscript_paragraph.R
├── output/             collected-to-raw-report.md · raw-to-processed-report.md
│                       manuscript paragraph .md
└── main.R              orchestrator: sources code/ scripts in order

data/
├── collected/          data exactly as it arrived — read from it, leave it as it is
├── raw/                collected data restructured to a tidy standard format
└── processed/          raw data after the participant-phase then trial-phase exclusions
```

Running `preprocessing/main.R` alone rebuilds `data/raw/`, `data/processed/`, and both
reports from `data/collected/`. Start it from `assets/template_main.R`. `build_raw.R` ends
by writing `collected-to-raw-report.md`; `build_processed.R` ends by writing
`raw-to-processed-report.md`.

Write every table with plain `dplyr`/`tidyr` code and named intermediate objects, and
render it with `knitr::kable(x, format = "pipe")`. `main.R` sets
`options(knitr.kable.NA = "")` once, so a cell with nothing to report comes out blank.
Both reports are Markdown tables only — they are read by the researcher during
preprocessing, so they stay quick to produce and quick to scan.

## Pipeline skeleton

Implement exactly the approved plan, in labelled sections:

```r
#### BUILD PROCESSED DATA ####

df <- readRDS(file.path(raw_dir, "data_raw.RDS"))

# Type conversions
df <- df |>
  dplyr::mutate(
    subject_id = as.character(subject_id),
    choice     = factor(choice, levels = c("left", "right")),
    rt         = as.numeric(rt),
    reward     = as.numeric(reward)
  )

# Cutoffs (rt_min_sec, rt_max_sec, max_pct_fast_rt) come from main.R, where each one
# holds the value the user approved in the interview.

# Participant phase: name each surviving dataset, so the pipeline order reads off the code
incomplete_subjects <- df |>
  dplyr::filter(session_status == "incomplete") |>
  dplyr::distinct(subject_id) |>
  dplyr::pull(subject_id)

after_incomplete <- df |> dplyr::filter(!subject_id %in% incomplete_subjects)

fast_rt_subjects <- after_incomplete |>
  dplyr::group_by(subject_id) |>
  dplyr::summarise(pct_fast = 100 * mean(rt < rt_min_sec, na.rm = TRUE)) |>
  dplyr::filter(pct_fast > max_pct_fast_rt) |>
  dplyr::pull(subject_id)

after_fast_rt <- after_incomplete |> dplyr::filter(!subject_id %in% fast_rt_subjects)

# Trial phase: applied to the participants that survived the phase above
after_no_response <- after_fast_rt     |> dplyr::filter(!is.na(choice))
after_rt_bounds   <- after_no_response |> dplyr::filter(rt >= rt_min_sec, rt <= rt_max_sec)

df_processed <- after_rt_bounds

saveRDS(df_processed, file = file.path(processed_dir, "data_processed.RDS"))
```

## Rules for the code

- Anchor every path with `project_root <- here::here()` and build it with `file.path()`.
- Chain operations with the base pipe `|>`, and name the package explicitly:
  `dplyr::mutate()`, `dplyr::filter()`.
- Give each exclusion step its own named dataset (`after_no_response`, `after_rt_bounds`),
  so the pipeline order is visible in the code and every count is recoverable afterwards
  by comparing two named objects.
- Run the participant phase first and the trial phase second, applying the criteria within
  each phase one at a time in the order the plan lists them — each criterion filters the
  survivors of the one before it, keeping every count attributable to a single criterion.
- Hold each cutoff in a named variable (`rt_min_sec`, `max_pct_fast_rt`) set once in `main.R`
  from the user's approved value, and reference that variable in the filter, the
  per-participant diagnostic, and the report's criterion text, so all three agree by
  construction.
- Convert values that only look like data (`"NA"`, `"."`, `""`) to proper `NA` before
  coercing the column.
- Build every report table from the data objects themselves, so each number in the report
  recomputes when the data changes.
- Write data outputs to `data/raw/` or `data/processed/`, and reports to
  `preprocessing/output/`.

## Type coercion patterns

```r
# Numeric column carrying non-numeric strings — clean, then coerce
score <- ifelse(score %in% c("NA", ".", ""), NA_real_, score)
score <- as.numeric(score)

# Character to factor
choice   <- factor(choice, levels = c("left", "right"))
severity <- factor(severity, levels = c("low", "medium", "high"), ordered = TRUE)

# Character to date — match the format the data actually uses
date_col <- as.Date(date_col, format = "%Y-%m-%d")

# Logical from string representations
outcome <- tolower(outcome) %in% c("true", "yes", "y", "1")
```

## Describing the data

These five blocks answer "what is in this dataset". They adapt to whatever columns exist,
so the same code serves a two-choice bandit, a Likert study, or a multi-condition design.
Both build scripts run them: `build_raw.R` reads `df`, and `build_processed.R` reads
`df_processed` in place of `df` throughout. Repeating the blocks in the two scripts keeps
each one readable end to end and makes the two reports' tables line up column-for-column.

**Numeric columns** — one row per numeric column, whatever they are (RT, reward, accuracy,
trial number, age):

```r
numeric_columns <- df |>
  dplyr::select(dplyr::where(is.numeric)) |>
  tidyr::pivot_longer(dplyr::everything(), names_to = "column", values_to = "value") |>
  dplyr::group_by(column) |>
  dplyr::summarise(
    n_missing = sum(is.na(value)),
    min       = round(min(value, na.rm = TRUE), 3),
    mean      = round(mean(value, na.rm = TRUE), 3),
    max       = round(max(value, na.rm = TRUE), 3)
  )
```

**Categorical columns** — one row per character/factor column, with its labels:

```r
categorical_columns <- df |>
  dplyr::select(dplyr::where(is.character) | dplyr::where(is.factor)) |>
  dplyr::mutate(dplyr::across(dplyr::everything(), as.character)) |>
  tidyr::pivot_longer(dplyr::everything(), names_to = "column", values_to = "value") |>
  dplyr::group_by(column) |>
  dplyr::summarise(
    n_missing = sum(is.na(value)),
    n_levels  = dplyr::n_distinct(value, na.rm = TRUE),
    labels    = paste(head(sort(unique(value)), 6), collapse = ", ")
  )
```

**Sample overview** — the headline numbers:

```r
trials_per_subject <- dplyr::count(df, subject_id, name = "n_trials")

sample_overview <- tibble::tibble(
  metric = c("Observations", "Participants",
             "Trials per participant (min / median / max)",
             "RT mean (SD)", "RT range"),
  value  = c(format(nrow(df), big.mark = ","),
             format(dplyr::n_distinct(df$subject_id)),
             paste(min(trials_per_subject$n_trials),
                   median(trials_per_subject$n_trials),
                   max(trials_per_subject$n_trials), sep = " / "),
             paste0(round(mean(df$rt, na.rm = TRUE), 3),
                    " (", round(sd(df$rt, na.rm = TRUE), 3), ")"),
             paste(round(range(df$rt, na.rm = TRUE), 3), collapse = " to "))
)
```

**Per participant** — one row per subject, worst first, so outlier subjects surface
immediately and exclusion candidates are visible before any criterion runs:

```r
per_subject <- df |>
  dplyr::group_by(subject_id) |>
  dplyr::summarise(
    n_trials    = dplyr::n(),
    pct_no_resp = round(100 * mean(is.na(choice)), 1),
    pct_fast_rt = round(100 * mean(rt < rt_min_sec, na.rm = TRUE), 1),
    rt_mean     = round(mean(rt, na.rm = TRUE), 3),
    rt_min      = round(min(rt, na.rm = TRUE), 3),
    rt_max      = round(max(rt, na.rm = TRUE), 3)
  ) |>
  dplyr::arrange(dplyr::desc(pct_no_resp), dplyr::desc(pct_fast_rt))
```

**Per design cell** — one block per design factor the study has (condition, block, group),
so a collapsed cell or an unbalanced design shows up straight away:

```r
per_condition <- df |>
  dplyr::group_by(condition) |>
  dplyr::summarise(
    n_obs      = dplyr::n(),
    n_subjects = dplyr::n_distinct(subject_id),
    rt_mean    = round(mean(rt, na.rm = TRUE), 3),
    pct_left   = round(100 * mean(choice == "left", na.rm = TRUE), 1)
  )
```

Name the columns this dataset actually uses, and keep the blocks it has data for. The first
two blocks need no adjustment at all — they read whatever columns are present. In the last
three, put this study's outcome variable wherever `rt` appears and its grouping variable
wherever `condition` appears; a study measuring only choices keeps the trial counts and
choice percentages and drops the RT lines.

## Collected-to-raw report

Written at the end of `build_raw.R`, once `collected` has been restructured into `raw`.
This stage keeps every real observation and every participant — it drops housekeeping rows
and empty columns only — so the row table is a plain kept/dropped count. Assemble it from
the blocks above:

```r
row_summary <- tibble::tibble(
  metric = c("Rows kept", "Rows dropped as housekeeping", "Participants"),
  value  = c(nrow(df), nrow(collected) - nrow(df), dplyr::n_distinct(df$subject_id))
)

report_lines <- c(
  "# Collected-to-raw report", "",
  "Built by `preprocessing/code/build_raw.R`. This stage restructures the collected data",
  "and keeps every real observation; it removes housekeeping rows and empty columns only.", "",
  "## Rows", "",             knitr::kable(row_summary, format = "pipe"), "",
  "## Numeric columns", "",  knitr::kable(numeric_columns, format = "pipe"), "",
  "## Categorical columns", "", knitr::kable(categorical_columns, format = "pipe"), "",
  "## Sample overview", "",  knitr::kable(sample_overview, format = "pipe"), "",
  "## Per condition", "",    knitr::kable(per_condition, format = "pipe"), "",
  "## Per participant", "",  knitr::kable(per_subject, format = "pipe")
)
writeLines(report_lines, file.path(output_dir, "collected-to-raw-report.md"))
```

See `assets/example-collected-to-raw-report.md` for a worked example.

## Raw-to-processed report

Written at the end of `build_processed.R`. Its first half is the exclusion cascade: one
table per phase, one row per criterion in the order it ran, giving the criterion in the
user's own words, how many it took out, that count as a percentage of what reached it, and
how many remain. Its second half repeats the describing-the-data blocks on `df_processed`,
so the reader compares the surviving sample against the same tables in the collected-to-raw
report. Every count comes from the named datasets in the pipeline:

```r
participant_exclusions <- tibble::tibble(
  criterion = c("Starting point (raw)",
                "Did not complete the session",
                paste0("More than ", max_pct_fast_rt, "% of RTs under ", rt_min_sec, " s")),
  n_omitted = c(NA_integer_,
                length(incomplete_subjects),
                length(fast_rt_subjects)),
  n_remaining = c(dplyr::n_distinct(df$subject_id),
                  dplyr::n_distinct(after_incomplete$subject_id),
                  dplyr::n_distinct(after_fast_rt$subject_id))
) |>
  dplyr::mutate(pct_omitted = round(100 * n_omitted / dplyr::lag(n_remaining), 1))

trial_exclusions <- tibble::tibble(
  criterion = c("Starting point (after participant exclusions)",
                "No response recorded",
                paste0("RT under ", rt_min_sec, " s or over ", rt_max_sec, " s")),
  n_omitted = c(NA_integer_,
                nrow(after_fast_rt)     - nrow(after_no_response),
                nrow(after_no_response) - nrow(after_rt_bounds)),
  n_remaining = c(nrow(after_fast_rt), nrow(after_no_response), nrow(after_rt_bounds))
) |>
  dplyr::mutate(pct_omitted = round(100 * n_omitted / dplyr::lag(n_remaining), 1))

report_lines <- c(
  "# Raw-to-processed report", "",
  "Built by `preprocessing/code/build_processed.R`. Participant criteria run first, then",
  "trial criteria on the participants that remain. Each row filters the row above it.", "",
  "## Participant exclusions (counts in participants)", "",
  knitr::kable(participant_exclusions, format = "pipe"), "",
  "## Trial exclusions (counts in observations)", "",
  knitr::kable(trial_exclusions, format = "pipe"), "",
  paste0("**Final: ", format(nrow(df_processed), big.mark = ","),
         " observations across ", dplyr::n_distinct(df_processed$subject_id),
         " participants.**"), "",
  "## Sample overview after exclusion", "",
  knitr::kable(sample_overview, format = "pipe"), "",
  "## Per condition after exclusion", "",
  knitr::kable(per_condition, format = "pipe"), "",
  "## Per participant after exclusion", "",
  knitr::kable(per_subject, format = "pipe")
)
writeLines(report_lines, file.path(output_dir, "raw-to-processed-report.md"))
```

See `assets/example-raw-to-processed-report.md` for a worked example.

## Manuscript paragraph

A single "Data treatment" paragraph, saved as `.md` in `preprocessing/output/`, with every
number computed from the data by the script rather than typed by hand. The example below
shows the style; each criterion and cutoff in the delivered paragraph is the user's own
value:

> *Data treatment. During data preprocessing, we first examined the quality of the
> behavioral data. Poor quality was defined by having either (a) more than 20% excluded
> trials due to no response, implausibly fast or implausibly slow reaction times
> (RTs < 0.2 sec or > 4 sec), or (b) selecting the same response key in over 90% of trials
> within a block. Due to this examination, two participants from the ADHD group and one
> from the control group were excluded. Furthermore, due to a technical error, the data of
> one participant in the ADHD group was not submitted and the participant was therefore
> excluded. From the remaining behavioral observations we omitted trials with no response
> (<1% of all trials), and trials with implausibly quick reaction times (< 0.2 sec) or
> exceptionally slow reaction times (> 4 sec; <1% of all trials). This resulted in 8,717
> trials for the ADHD group (198.11 mean trials per participant) and 8,661 trials for the
> control group (196.84 mean trials per participant).*

The Code Reviewer checks the result against `review-checklist.md` once the build is complete.
