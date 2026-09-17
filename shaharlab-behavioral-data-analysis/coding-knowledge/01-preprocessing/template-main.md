# Preprocessing `main.R` Template

Copy this R block into `preprocessing/main.R`. It defines the preprocessing paths, including one report folder for each data stage, and runs the pipeline in order.

Cutoffs come from the Job Card and are set once in `#### SETUP ####`. Each exclusion criterion is its own `source()` call, with the criterion as the comment above it.

```r
rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)
library(knitr)

project_root            <- here::here()
preprocessing_dir       <- file.path(project_root, "preprocessing")
code_dir                <- file.path(preprocessing_dir, "code")
artifacts_dir           <- file.path(preprocessing_dir, "artifacts")
output_dir              <- file.path(preprocessing_dir, "output")
reports_collected_dir   <- file.path(output_dir, "reports-collected")
reports_raw_dir         <- file.path(output_dir, "reports-raw")
reports_processed_dir   <- file.path(output_dir, "reports-processed")
collected_dir           <- file.path(project_root, "data", "collected")   # data as it arrived — READ-ONLY
raw_dir                 <- file.path(project_root, "data", "raw")
processed_dir           <- file.path(project_root, "data", "processed")

# Cutoffs the Job Card approved. Use these variables in the filters and in exclusion.md.
n_sessions_required     <- 2
window_exit_max         <- 1
rt_min_ms               <- 300
rt_max_ms               <- 3000
max_trial_exclusion_pct <- 20

dir.create(artifacts_dir,         recursive = TRUE, showWarnings = FALSE)
dir.create(reports_collected_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(reports_raw_dir,       recursive = TRUE, showWarnings = FALSE)
dir.create(reports_processed_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(raw_dir,               recursive = TRUE, showWarnings = FALSE)
dir.create(processed_dir,         recursive = TRUE, showWarnings = FALSE)

# Renders empty report cells as blanks rather than "NA".
options(knitr.kable.NA = "")

#### COLLECTED DATA ####

# Load the collected data once and save a reusable copy in artifacts/.
source(file.path(code_dir, "01_read_collected.R"))
source(file.path(code_dir, "02_describe_collected.R"))

#### RAW DATA ####

# Tidy collected data into data/raw/. Reports go to reports-raw/.
source(file.path(code_dir, "03_create_raw_data.R"))
source(file.path(code_dir, "04_print_raw_data_validation.R"))

#### PROCESSED DATA ####

# Exclude participants that did not complete all sessions
source(file.path(code_dir, "05_exclude_participants_incomplete_sessions.R"))

# Exclude participants who left the window twice or more
source(file.path(code_dir, "06_exclude_participants_leave_window.R"))

# Exclude trials with NA, RT under rt_min_ms, or RT over rt_max_ms
source(file.path(code_dir, "07_exclude_trials_rt.R"))

# Exclude participants with more than max_trial_exclusion_pct of trials omitted
source(file.path(code_dir, "08_exclude_participants_few_trials.R"))
```
