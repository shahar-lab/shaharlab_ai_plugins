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
# Paths are pre-set for a simulation folder; replace <folder_name> with the real name.
project_root  <- here::here()
code_dir      <- file.path(project_root, "simulation", "<folder_name>", "code")
artifacts_dir <- file.path(project_root, "simulation", "<folder_name>", "artifacts")
output_dir    <- file.path(project_root, "simulation", "<folder_name>", "output")



#### EXECUTE PIPELINE ####

# 1. Data Generation (Saves to artifacts/)
# Generate the dataset from a models/ definition and known parameters; nothing
# is read from data/ — a simulation's input is generated, not collected.
# source(file.path(code_dir, "generate_data.R"))

# 2. Model Fitting (Saves to artifacts/)
# source(file.path(code_dir, "fit_model.R"))

# 3. Diagnostics & Posterior Predictive Checks
# source(file.path(code_dir, "check_ppc.R"))

# 4. Plotting (Saves to output/)
# Posterior plots must use the visualization knowledge's posterior routing, not raw ggplot.
# source(file.path(code_dir, "plot_posteriors.R"))