rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)

# here::here() anchors to the .Rproj root regardless of the working directory,
# so paths resolve identically on any machine without setwd() gymnastics.
project_root  <- here::here()
code_dir      <- file.path(project_root, "preprocessing", "code")
output_dir    <- file.path(project_root, "preprocessing", "output")
collected_dir <- file.path(project_root, "data", "collected")   # data as it arrived — READ-ONLY
raw_dir       <- file.path(project_root, "data", "raw")
processed_dir <- file.path(project_root, "data", "processed")

# Exclusion cutoffs — one variable per criterion, each holding the value the user
# approved in the interview. Both build scripts read them from here, so the
# criteria appear in exactly one place and the reports quote the same numbers.
rt_min_sec      <- 0.2   # the user's value
rt_max_sec      <- 4     # the user's value
max_pct_fast_rt <- 15    # the user's value

# Renders empty report cells as blanks rather than "NA".
options(knitr.kable.NA = "")



#### EXECUTE PIPELINE ####

# Running this script alone rebuilds data/raw/, data/processed/, and
# preprocessing/output/ from data/collected/, reading data/collected/ as read-only.

# 1. Build Raw Data (Saves to data/raw/, plus collected-to-raw-report.md to output/)
# Restructure collected data into the agreed tidy format (one row per trial),
# keeping every real observation and participant. Ends by writing
# collected-to-raw-report.md: rows kept/dropped, numeric and categorical column
# tables, sample overview, per-condition and per-participant tables.
# source(file.path(code_dir, "build_raw.R"))

# 2. Build Processed Data (Saves to data/processed/, plus raw-to-processed-report.md to output/)
# Run the exclusions in order: participant criteria first (e.g. did not complete
# the session, subject-level RT thresholds), then trial criteria on the
# participants that remain (e.g. no response, RT bounds). Give each surviving
# dataset its own name so the order reads off the code, and take every cutoff
# from the SETUP variables above.
# Ends by writing raw-to-processed-report.md: one exclusion table per phase (one
# row per criterion, in the order it ran, with omitted/percent/remaining), the
# final count, then the same description tables computed on the processed data.
# source(file.path(code_dir, "build_processed.R"))

# 3. Manuscript Paragraph (Saves .md to output/)
# Single "Data treatment" paragraph; compute every number from the data.
# source(file.path(code_dir, "manuscript_paragraph.R"))
