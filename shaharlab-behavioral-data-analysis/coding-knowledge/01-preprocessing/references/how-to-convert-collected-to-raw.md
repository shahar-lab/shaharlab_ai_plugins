# How to write `converting_data_collected_to_raw.R`

The first `converting_` script in the pipeline. It reads `data/collected/`, restructures it into
one tidy typed table, and saves that to `data/raw/`. The folder it writes into and the three
prefixes it is named under are defined in
`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-preprocessing/context.md`.

## What this stage does

`raw/` is the collected data made usable, with nothing that was ever data removed. Three jobs, and
only these three:

1. **Restructure** into the agreed tidy shape — one row per trial (or per whatever unit the study
   measures), one column per variable.
2. **Type** every column, so a downstream script can filter and summarise without coercing first.
3. **Drop what was never data** — empty and irrelevant columns, housekeeping rows, and the
   researcher's own test runs.

Keep every real observation and every participant. The exclusions the manuscript reports happen
in `converting_data_raw_to_processed.R`, on the data this script produces.

## Skeleton

```r
#### CONVERT COLLECTED DATA TO RAW ####

df_collected <- readRDS(file.path(collected_dir, "data_collected.RDS"))

# Restructure to one row per trial
df <- df_collected |>
  filter(trial_type == "task") |>
  select(subject_id, session_status, condition, block, trial_number,
         choice, rt, reward, accuracy)

# Type conversions — every column leaves this script as the class it should be
df <- df |>
  mutate(
    subject_id = as.character(subject_id),
    condition  = factor(condition, levels = c("control", "treatment")),
    choice     = factor(choice, levels = c("left", "right")),
    rt         = as.numeric(rt),
    reward     = as.numeric(reward)
  )

df_raw <- df

saveRDS(df_raw, file = file.path(raw_dir, "data_raw.RDS"))

# Class and domain are verified by the data-validation HTML — see
# how-to-build-data-validation.md. Intended class per column comes from the specification.
trials_dictionary <- tribble(
  ~column,      ~class,      ~meaning,
  "subject_id", "character", "Participant identifier.",
  "condition",  "factor",    "Levels: control (reference), treatment.",
  "choice",     "factor",    "Levels: left (reference), right.",
  "rt",         "numeric",   "Response time in seconds.",
  "reward",     "numeric",   "Trial reward."
)

write_data_validation_report(df_raw, trials_dictionary, "trials")
```

`examining_data_raw.R` runs next and reports what came out, reading both stages from disk. This
script writes the tidy table to `data/raw/` and the data-validation HTML to
`preprocessing/output/` — the HTML is how the researcher verifies class and domain, not a
statistical summary.

## Rules for the code

- Read from `collected_dir` and leave `data/collected/` exactly as it is; write the tidy table to
  `raw_dir` and the data-validation HTML to `output_dir`.
- Anchor every path with `project_root <- here::here()` and build it with `file.path()`; both
  variables come from `main.R`.
- Chain operations with the base pipe `|>`, and call functions directly, adding any missing
  package's `library()` call to `main.R`'s `#### SETUP ####` block.
- Convert values that only look like data (`"NA"`, `"."`, `""`) to proper `NA` before coercing the
  column, so the coercion cannot fail silently.
- Give factors explicit `levels`, and give dates the format the data actually uses — an inferred
  level order or an assumed date format is the other way this stage fails silently.
- Name the surviving table `df_raw`, and leave `df_collected` in the environment, so
  `examining_data_raw.R` can account for the rows the conversion dropped.
- After `saveRDS`, call `write_data_validation_report()` on the in-memory frame. The helper is
  sourced from `main.R`'s `#### SETUP ####` (`converting_data_validation.R`).
- Keep the script to 50–80 lines. A restructuring step long enough to break that belongs in a
  second `converting_` script named for what it does.

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

## What comes next

| Script | File |
|---|---|
| data-validation HTML | `how-to-build-data-validation.md` |
| `examining_data_raw.R` | `how-to-examine.md` |
| `converting_data_raw_to_processed.R` | `how-to-convert-raw-to-processed.md` |
