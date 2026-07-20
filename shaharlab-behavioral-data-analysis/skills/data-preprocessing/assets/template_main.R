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



#### EXECUTE PIPELINE ####

# Running this script alone rebuilds data/raw/, data/processed/, and
# preprocessing/output/ from data/collected/. Never modify data/collected/.

# 1. Build Raw Data (Saves to data/raw/)
# Restructure collected data into the agreed tidy format (one row per trial).
# No exclusions at this stage.
# source(file.path(code_dir, "build_raw.R"))

# 2. Data-Quality Report (Saves PDF to output/)
# At minimum: aborted/no-response trials per subject, and an RT summary
# table with one row per subject.
# source(file.path(code_dir, "quality_report.R"))

# 3. Build Processed Data (Saves to data/processed/)
# Apply trial/subject exclusions using criteria DEFINED BY THE USER
# (e.g., no response, RT < X ms or > Y ms, subject-level thresholds).
# Never choose cutoff values yourself — ask the user for explicit values.
# source(file.path(code_dir, "build_processed.R"))

# 4. Manuscript Paragraph (Saves .md to output/)
# Single "Data treatment" paragraph; all numbers computed from the data,
# never hand-typed.
# source(file.path(code_dir, "manuscript_paragraph.R"))
