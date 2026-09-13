# How to write a "creating-raw-data.R" script

## 1. Context for writing you script:

This document explains what needs to be addresed in order to preprocessed `collected-data` placed by the researcher under `data/collected` into `raw-data` placed by the code in `preprocessing` in `data/raw`. `collected-data` as you already know is what the machine collectes at time of testing 'as-is'. The process this document covers is how to handle major issues in `collected-data`. You should write a code that uses the user prompt and the `job-card` you have to address in code these issues:


- <u>Amount of files to generate under the `data/raw/` folder:</u> The user will guide you on which files should be merged from `collected-data` to become `raw-data` files. Typically, in behavioral analysis all participants' single files can be aggregated into one file. Yet, you might have several `raw-data` files. This could be files that integrates participants for different sections of the experiment, like a file for each task, a file for each self-report or demographic.

- <u>Columns</u>: Columns `collected-data` might have unessasry columns like a column that has no values, or has the same value across the whole set. These columns are not valuablefor further analysis. The columns might also not have the correct class and labels. Columns that should be a `factor` might actually render as `string`. Labels might be inaccurate. Arbitrarry coding like `1` for male and `2` for female might be in it.The user will guide you on which columns to save from `collected-data`, which to drop and what class and labels they should have. The point is to save only columns that really have information, and to tidy their names, class, labels, etcs.

- <u>Missing data</u>: you might have different ways that missing data is expressed here. No way of really telling whats a missing data without a user informed guidence.The user will inform you what exactly counts as missing data and how to code it. But for R missing data is `NA`, and this usually comes from `999` `""` and similar cell values in the `collected-data`.



## 2. Rules and guidelines

* start by loading the correct collected data. Read from `collected_dir` and leave `data/collected/` exactly as it is; write the tidy table to `raw_dir` and the data-validation HTML to `output_dir`.

* use `for` loop is you need to aggregate data from several participants into one file

* use `tidyverse` -  it was desniged for these type of things

* 
Anchor every path with `project_root <- here::here()` and build it with `file.path()`; both
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
* end by saving a `csv`, or and `rdata` or and `rds`. You can save more then one format.

* generate a data-validation html report



## Example

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

write_data_validation_report(df_raw, trials_dictionary, "trials", prefix = "01_")
```

`examining_data_raw.R` runs next and reports what came out, reading both stages from disk. This
script writes the tidy table to `data/raw/` and the data-validation HTML to
`preprocessing/output/` — the HTML is how the researcher verifies class and domain, not a
statistical summary.

## Rules for the code



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

| Script                               | File                                 |
| ------------------------------------ | ------------------------------------ |
| data-validation HTML                 | `how-to-build-data-validation.md`    |
| `examining_data_raw.R`               | `how-to-examine.md`                  |
| `converting_data_raw_to_processed.R` | `how-to-convert-raw-to-processed.md` |
