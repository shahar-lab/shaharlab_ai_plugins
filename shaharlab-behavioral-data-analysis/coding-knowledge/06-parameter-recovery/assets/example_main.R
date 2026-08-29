rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)
library(cmdstanr)
library(posterior)
library(ggplot2)
library(patchwork)
library(ggdist)

project_root  <- here::here()
code_dir      <- file.path(project_root, "simulation", "<folder_name>", "code")
artifacts_dir <- file.path(project_root, "simulation", "<folder_name>", "artifacts")
output_dir    <- file.path(project_root, "simulation", "<folder_name>", "output")


#### SETTING THE ENVIRONMENT ####

# The structure every agent faces, and a figure confirming it before a sampler is spent.
source(file.path(code_dir, "01_set_environment_parameters.R"))
source(file.path(code_dir, "02_generate_environment.R"))
source(file.path(code_dir, "03_visualize_environment.R"))


#### SETTING THE AGENT POPULATION ####

# The ground truth: population location and scale, each agent's draw from it, and a
# figure of those draws against the density they came from.
source(file.path(code_dir, "04_set_agent_population_parameters.R"))
source(file.path(code_dir, "05_generate_agents_parameters.R"))
source(file.path(code_dir, "06_visualize_agents_parameters.R"))


#### GENERATE AND RECOVER ####

# 07 names the generating and the fitted model as two variables; equal names make this
# a recovery study, different names make it a model comparison.
source(file.path(code_dir, "07_set_model.R"))
source(file.path(code_dir, "08_generate_behavior.R"))
source(file.path(code_dir, "09_fit_model.R"))
source(file.path(code_dir, "10_visualize_recovery.R"))