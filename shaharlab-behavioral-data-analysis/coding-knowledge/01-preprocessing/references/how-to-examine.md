# How to write an `examining_` script

An `examining_` script reads one data stage from disk and writes one Markdown report of what is in
it. Every data inspection that belongs in the pipeline is an `examining_` script, so it reruns with
every build rather than being done once by hand. The folder it writes into and the three prefixes
it is named under are defined in
`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-preprocessing/rules.md`.

A standard pipeline has two: `examining_data_raw.R` and `examining_data_processed.R`. Both run the
same five description blocks, so their two reports line up column for column and the surviving
sample reads side by side against the full one. A study with a further stage adds one
`examining_` script for it, on the same pattern.

**This file is the pipeline's examination.** The one-off pass over `data/collected/` that happens
before any code exists — the profile that feeds Malka's interview — is `exploration.md`.

## What an examining script reads and writes

| Script | Reads | Writes |
|---|---|---|
| `examining_data_raw.R` | `data/raw/` from disk, plus `df_collected` from the environment to account for the rows the conversion dropped | `output/examining_data_raw.md` |
| `examining_data_processed.R` | `data/processed/` from disk | `output/examining_data_processed.md` |

Read the stage this script reports on from disk by path, so the report is a statement about what is
actually saved. The one exception is the collected row count: `data/collected/` arrives in whatever
shape and however many files it came in, and the `converting_` script is the one that knows how to
read it, so take that count from the `df_collected` it left in the environment.

Write every table with plain `dplyr`/`tidyr` code and named intermediate objects, and render it
with `kable(x, format = "pipe")`. `main.R` sets `options(knitr.kable.NA = "")` once, so a cell with
nothing to report comes out blank. These reports are Markdown tables only — the researcher reads
them during preprocessing, so they stay quick to produce and quick to scan.

## The five description blocks

These five answer "what is in this dataset". They adapt to whatever columns exist, so the same code
serves a two-choice bandit, a Likert study, or a multi-condition design. `df` below is the stage
this script read.

**Numeric columns** — one row per numeric column, whatever they are (RT, reward, accuracy, trial
number, age):

```r
numeric_columns <- df |>
  select(where(is.numeric)) |>
  pivot_longer(everything(), names_to = "column", values_to = "value") |>
  group_by(column) |>
  summarise(
    n_missing = sum(is.na(value)),
    min       = round(min(value, na.rm = TRUE), 3),
    mean      = round(mean(value, na.rm = TRUE), 3),
    max       = round(max(value, na.rm = TRUE), 3)
  )
```

**Categorical columns** — one row per character/factor column, with its labels:

```r
categorical_columns <- df |>
  select(where(is.character) | where(is.factor)) |>
  mutate(across(everything(), as.character)) |>
  pivot_longer(everything(), names_to = "column", values_to = "value") |>
  group_by(column) |>
  summarise(
    n_missing = sum(is.na(value)),
    n_levels  = n_distinct(value, na.rm = TRUE),
    labels    = paste(head(sort(unique(value)), 6), collapse = ", ")
  )
```

**Sample overview** — the headline numbers:

```r
trials_per_subject <- count(df, subject_id, name = "n_trials")

sample_overview <- tibble(
  metric = c("Observations", "Participants",
             "Trials per participant (min / median / max)",
             "RT mean (SD)", "RT range"),
  value  = c(format(nrow(df), big.mark = ","),
             format(n_distinct(df$subject_id)),
             paste(min(trials_per_subject$n_trials),
                   median(trials_per_subject$n_trials),
                   max(trials_per_subject$n_trials), sep = " / "),
             paste0(round(mean(df$rt, na.rm = TRUE), 3),
                    " (", round(sd(df$rt, na.rm = TRUE), 3), ")"),
             paste(round(range(df$rt, na.rm = TRUE), 3), collapse = " to "))
)
```

**Per participant** — one row per subject, worst first, so outlier subjects surface immediately and
exclusion candidates are visible before any criterion runs:

```r
per_subject <- df |>
  group_by(subject_id) |>
  summarise(
    n_trials    = n(),
    pct_no_resp = round(100 * mean(is.na(choice)), 1),
    pct_fast_rt = round(100 * mean(rt < rt_min_sec, na.rm = TRUE), 1),
    rt_mean     = round(mean(rt, na.rm = TRUE), 3),
    rt_min      = round(min(rt, na.rm = TRUE), 3),
    rt_max      = round(max(rt, na.rm = TRUE), 3)
  ) |>
  arrange(desc(pct_no_resp), desc(pct_fast_rt))
```

**Per design cell** — one block per design factor the study has (condition, block, group), so a
collapsed cell or an unbalanced design shows up straight away:

```r
per_condition <- df |>
  group_by(condition) |>
  summarise(
    n_obs      = n(),
    n_subjects = n_distinct(subject_id),
    rt_mean    = round(mean(rt, na.rm = TRUE), 3),
    pct_left   = round(100 * mean(choice == "left", na.rm = TRUE), 1)
  )
```

Name the columns this dataset actually uses, and keep the blocks it has data for. The first two
blocks need no adjustment at all — they read whatever columns are present. In the last three, put
this study's outcome variable wherever `rt` appears and its grouping variable wherever `condition`
appears; a study measuring only choices keeps the trial counts and choice percentages and drops the
RT lines.

For an online study, the per-participant block also carries the window-exit counts, so the user sees
that distribution before choosing a cutoff. `handling-leaving-window.md` has the counting block.

Run the same blocks in both `examining_` scripts, naming the objects identically. Repeating them
keeps each script readable end to end and makes the two reports comparable line by line.

## Assembling the report

`examining_data_raw.R` opens with the conversion's row accounting, then the five blocks:

```r
#### EXAMINE RAW DATA ####

# df_collected comes from converting_data_collected_to_raw.R, sourced before this script
df <- readRDS(file.path(raw_dir, "data_raw.RDS"))

row_summary <- tibble(
  metric = c("Rows kept", "Rows dropped as housekeeping", "Participants"),
  value  = c(nrow(df), nrow(df_collected) - nrow(df), n_distinct(df$subject_id))
)

# … the five description blocks on df …

report_lines <- c(
  "# Examining the raw data", "",
  "Built by `preprocessing/code/examining_data_raw.R` on `data/raw/`. This stage keeps",
  "every real observation; it removes housekeeping rows and empty columns only.", "",
  "## Rows", "",                 kable(row_summary, format = "pipe"), "",
  "## Numeric columns", "",      kable(numeric_columns, format = "pipe"), "",
  "## Categorical columns", "",  kable(categorical_columns, format = "pipe"), "",
  "## Sample overview", "",      kable(sample_overview, format = "pipe"), "",
  "## Per condition", "",        kable(per_condition, format = "pipe"), "",
  "## Per participant", "",      kable(per_subject, format = "pipe")
)
writeLines(report_lines, file.path(output_dir, "examining_data_raw.md"))
```

`examining_data_processed.R` is the same file with `processed_dir`/`data_processed.RDS` in place of
the raw paths, the row table dropped, and its own name in the heading and the output file. The
exclusion accounting for that stage belongs to `summary_exclusions.R`.

See `../assets/example-examining-report.md` for a worked example of the rendered output.

## Rules for the code

- Read the stage by path from `raw_dir` or `processed_dir`, both set in `main.R`.
- Write the report to `output_dir`; a script that saves data to `data/` is a `converting_` script.
- Build every table from the data objects themselves, so each number recomputes when the data
  changes.
- Chain operations with the base pipe `|>` and named intermediate objects, calling functions
  directly and adding any missing package's `library()` call to `main.R`'s `#### SETUP ####` block.
- Keep the script to 50–80 lines. Where the five blocks plus assembly run longer, split the
  assembly into a second `examining_` script named for the part it reports.
