rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)
library(knitr)

# here::here() anchors to the .Rproj root regardless of the working directory,
# so paths resolve identically on any machine without setwd() gymnastics.
project_root  <- here::here()
code_dir      <- file.path(project_root, "preprocessing", "code")
artifacts_dir <- file.path(project_root, "preprocessing", "artifacts")
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
# One exit is one sequence of consecutive trials away — see 01-preprocessing's
# handling-leaving-window.md. Uncomment and set from the user's approved value.
# window_exit_max <- NA_integer_   # the user's value

# Renders empty report cells as blanks rather than "NA".
options(knitr.kable.NA = "")

# Functions that write data-validation HTML. Sourced here so every converting
# script can call write_data_validation_report() after it types its table.
# Uncomment once converting_data_validation.R exists.
# source(file.path(code_dir, "converting_data_validation.R"))



#### EXECUTE PIPELINE ####

# Running this script alone rebuilds data/raw/, data/processed/, and every report in
# preprocessing/output/ from data/collected/, reading data/collected/ as read-only.
# Each script inherits the paths, libraries, and cutoffs set above, and the scripts
# below it also inherit the named objects it leaves behind. Each script's two-digit
# prefix is its position in this list; every file it writes to output/ takes that
# same prefix. Inserting a step renumbers the scripts and output files after it
# and the source() lines here in the same edit.

# 1. Convert collected data to raw (saves data_raw.RDS to data/raw/; writes
#    01_data-validation-<name>-raw.html to output/)
# Restructure the collected data into the agreed tidy format (one row per trial),
# type every column, and drop housekeeping rows and empty columns — keeping every
# real observation and participant. The HTML is how the researcher verifies class
# and domain.
# source(file.path(code_dir, "01_converting_data_collected_to_raw.R"))

# 2. Examine the raw data (writes 02_examining_data_raw.md to output/)
# Report what is in data/raw/ before any criterion runs: rows kept and dropped in
# the conversion, the numeric and categorical column tables, the sample overview,
# and the per-design-cell and per-participant tables that surface exclusion
# candidates.
# source(file.path(code_dir, "02_examining_data_raw.R"))

# 3. Convert raw data to processed (saves data_processed.RDS to data/processed/;
#    writes 03_data-validation-<name>-processed.html to output/ when specified)
# Run the exclusions in order: participant criteria first (e.g. did not complete
# the session, subject-level RT thresholds), then trial criteria on the
# participants that remain (e.g. no response, RT bounds). Give each surviving
# dataset its own name so the order reads off the code, and take every cutoff from
# the SETUP variables above.
# source(file.path(code_dir, "03_converting_data_raw_to_processed.R"))

# 4. Examine the processed data (writes 04_examining_data_processed.md to output/)
# The same description tables computed on data/processed/, so the surviving sample
# reads side by side with 02_examining_data_raw.md, column for column.
# source(file.path(code_dir, "04_examining_data_processed.R"))

# 5. Summarise the exclusions (writes 05_summary_exclusions.md to output/)
# One table per phase, one row per criterion in the order it ran, with omitted,
# percent, and remaining — computed from the named datasets left behind by step 3 —
# then the final N.
# source(file.path(code_dir, "05_summary_exclusions.R"))

# 6. Manuscript paragraph (writes 06_summary_manuscript_paragraph.md to output/)
# Single "Data treatment" paragraph; compute every number from the data.
# source(file.path(code_dir, "06_summary_manuscript_paragraph.R"))
