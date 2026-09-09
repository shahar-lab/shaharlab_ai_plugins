rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)
library(brms)
library(bayesplot)
library(posterior)
library(ggdist)

# here::here() anchors to the .Rproj root regardless of the working directory,
# so paths resolve identically on any machine without setwd() gymnastics.
# Paths are pre-set for an analysis folder; replace <folder_name> with the real name.
project_root  <- here::here()
code_dir      <- file.path(project_root, "analysis", "<folder_name>", "code")
artifacts_dir <- file.path(project_root, "analysis", "<folder_name>", "artifacts")
output_dir    <- file.path(project_root, "analysis", "<folder_name>", "output")
data_path     <- file.path(project_root, "data", "processed")



#### EXECUTE PIPELINE ####

# Each script's two-digit prefix is its position in this list; inserting a step
# renumbers the ones after it and the source() lines here in the same edit.

# 1. Data Preparation
# Read clean data through data_path. Per the Artifacts Rule, never copy data into
# this folder. Point data_path at another stage (e.g. data/raw/) only if the user
# asks for pre-exclusion data.
# df <- readr::read_csv(file.path(data_path, "your_file.csv"))
# source(file.path(code_dir, "01_prep_data.R"))

# 2. Model Fitting (Saves to artifacts/)
# source(file.path(code_dir, "02_fit_model.R"))

# 3. Diagnostics & Posterior Predictive Checks
# source(file.path(code_dir, "03_check_ppc.R"))

# 4. Plotting (Saves to output/)
# Posterior plots must use the visualization knowledge's posterior routing, not raw ggplot.
# source(file.path(code_dir, "04_plot_posteriors.R"))