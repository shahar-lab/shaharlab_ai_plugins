rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)
library(knitr)

# here::here() anchors to the .Rproj root regardless of the working directory,
# so paths resolve identically on any machine without setwd() gymnastics.
project_root  <- here::here()
code_dir      <- file.path(project_root, "preprocessing", "code")
output_dir    <- file.path(project_root, "preprocessing", "output")
collected_dir <- file.path(project_root, "data", "collected")   # data as it arrived — READ-ONLY
raw_dir       <- file.path(project_root, "data", "raw")
processed_dir <- file.path(project_root, "data", "processed")

# Exclusion cutoffs — one variable per criterion, each holding the value the user
# approved in the interview. The converting script filters on them and the summary
# scripts quote them, so each criterion appears in exactly one place.
rt_min_sec      <- 0.2   # the user's value
rt_max_sec      <- 4     # the user's value
max_pct_fast_rt <- 15    # the user's value

# Online studies: the most window exits a participant may have and still be included.
# One exit is one sequence of consecutive trials away — see 03-preprocessing's
# handling-leaving-window.md. Uncomment and set from the user's approved value.
# window_exit_max <- NA_integer_   # the user's value

# Renders empty report cells as blanks rather than "NA".
options(knitr.kable.NA = "")



#### EXECUTE PIPELINE ####

# Running this script alone rebuilds data/raw/, data/processed/, and every report in
# preprocessing/output/ from data/collected/, reading data/collected/ as read-only.
# Each script inherits the paths, libraries, and cutoffs set above, and the scripts
# below it also inherit the named objects it leaves behind.

# 1. Convert collected data to raw (saves data_raw.RDS to data/raw/)
# Restructure the collected data into the agreed tidy format (one row per trial),
# type every column, and drop housekeeping rows and empty columns — keeping every
# real observation and participant.
# source(file.path(code_dir, "converting_data_collected_to_raw.R"))

# 2. Examine the raw data (writes examining_data_raw.md to output/)
# Report what is in data/raw/ before any criterion runs: rows kept and dropped in
# the conversion, the numeric and categorical column tables, the sample overview,
# and the per-design-cell and per-participant tables that surface exclusion
# candidates.
# source(file.path(code_dir, "examining_data_raw.R"))

# 3. Convert raw data to processed (saves data_processed.RDS to data/processed/)
# Run the exclusions in order: participant criteria first (e.g. did not complete
# the session, subject-level RT thresholds), then trial criteria on the
# participants that remain (e.g. no response, RT bounds). Give each surviving
# dataset its own name so the order reads off the code, and take every cutoff from
# the SETUP variables above.
# source(file.path(code_dir, "converting_data_raw_to_processed.R"))

# 4. Examine the processed data (writes examining_data_processed.md to output/)
# The same description tables computed on data/processed/, so the surviving sample
# reads side by side with examining_data_raw.md, column for column.
# source(file.path(code_dir, "examining_data_processed.R"))

# 5. Summarise the exclusions (writes summary_exclusions.md to output/)
# One table per phase, one row per criterion in the order it ran, with omitted,
# percent, and remaining — computed from the named datasets left behind by step 3 —
# then the final N.
# source(file.path(code_dir, "summary_exclusions.R"))

# 6. Manuscript paragraph (writes summary_manuscript_paragraph.md to output/)
# Single "Data treatment" paragraph; compute every number from the data.
# source(file.path(code_dir, "summary_manuscript_paragraph.R"))
