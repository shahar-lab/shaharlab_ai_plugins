# Preprocessing `main.R` Template

Copy this R block into `preprocessing/main.R`. It defines the preprocessing paths, including one report folder for each data stage, and runs the pipeline in order.

```r
rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)
library(knitr)

project_root          <- here::here()
preprocessing_dir     <- file.path(project_root, "preprocessing")
code_dir              <- file.path(preprocessing_dir, "code")
artifacts_dir         <- file.path(preprocessing_dir, "artifacts")
output_dir            <- file.path(preprocessing_dir, "output")
reports_collected_dir <- file.path(output_dir, "reports-collected")
reports_raw_dir       <- file.path(output_dir, "reports-raw")
reports_processed_dir <- file.path(output_dir, "reports-processed")
collected_dir         <- file.path(project_root, "data", "collected")
raw_dir               <- file.path(project_root, "data", "raw")
processed_dir         <- file.path(project_root, "data", "processed")

dir.create(reports_collected_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(reports_raw_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(reports_processed_dir, recursive = TRUE, showWarnings = FALSE)

#### EXECUTE PIPELINE ####

# Collected data — reports go to reports_collected_dir.
# Load the collected data once and save a reusable copy in artifacts/.
source(file.path(code_dir, "01_read_collected_data.R"))
source(file.path(code_dir, "02_print_collected_data_summary.R"))

# Raw data — reports go to reports_raw_dir.
source(file.path(code_dir, "03_create_raw_data.R"))
source(file.path(code_dir, "04_print_raw_data_validation.R"))
source(file.path(code_dir, "05_print_raw_data_rt_report.R"))
source(file.path(code_dir, "06_print_raw_data_window_exit_report.R"))

# Processed data — reports go to reports_processed_dir.
source(file.path(code_dir, "07_create_processed_data.R"))
source(file.path(code_dir, "08_print_exclusion_report.R"))
```
