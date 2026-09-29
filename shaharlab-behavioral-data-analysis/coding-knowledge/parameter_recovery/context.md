# The `parameter_recovery` job-folder

## Purpose

This covering folder is for **parameter-recovery** analysis. Each recovery analysis is one job-folder under the `simulation/` main-folder (the project-root directory named `simulation/`). Do not place a recovery job-folder under `analyses/`, `models/`, or `preprocessing/`. Nothing here is read from `data/` the input is generated inside the job-folder.

A recovery study asks one question: when known parameters generate data, does fitting the model
back return those parameters? `main.R` execute code in four parts, in this order: generating true parameters, generating data, recovering parameters, then visualization and output.

```text
simulation/
└── [analysis_name]/        e.g. alpha_beta_param_recovery
    ├── code/               
    ├── artifacts/          
    ├── output/             
    ├── main.R              
    └── summary.md          
```


- **Generating true parameters**  The known values the rest of the study is judged against: the population (or single true) values set in `main.R`, the drawn agent-level parameters, their plots, and the saved true-parameter artifacts.

- **Generating data**   The artificial dataset: sample-size and task constants set in `main.R`, the generating function sourced from `models/`, and the simulated trial-level file in this job-folder's `artifacts/`. The input is generated inside the job-folder.

- **Recovering parameters**  The fit back onto that data: the researcher's estimator, sampler settings, the saved fit, extracted draws, and the recovered-parameter artifacts.

- **Visualization and output**  The human-facing evaluation: three custom recovery figures built from the saved artifacts, a Word narrative, and a multi-page PDF, all written under `output/`.

## The rules

`main.R` uses these headers, in this order.

```r
#### SETUP ####
#### GENERATING TRUE PARAMETERS ####
#### GENERATING DATA ####
#### RECOVERING PARAMETERS ####
#### VISUALIZATION AND OUTPUT ####
```

- **`#### SETUP ####`**

  Libraries, `rm(list = ls())`, the path block, and the generative and fitted model names live here. Scripts in `code/` use these variables.

- **`#### GENERATING TRUE PARAMETERS ####`**

	 * If this is hierarchical model, set the population location (`mu_*`) and scale (`sigma_*`) of each parameter in `main.R`, or the single true value when the study is not hierarchical. 
	 * A `code/` script draws one row per agent and saves `true_population.rds` and `true_parameters.rds` to `artifacts/`. 
	 * Another code then plots **dot histograms** (`../visualization/plot-types/plot-dot-histogram.md`) with one panel per parameter, with the theoretical distribution overlayed (making sure the y-scale is set so that both the distribution and the dots are well visible ). Then export PDF+PNG per `../visualization/standards/EXPORT_STANDARD.md`. 
	 * Draw a unit-interval parameter on the unconstrained (logit) scale and apply `plogis()` before the generating function; state that transform in `main.R` and in the Word narrative.

- **`#### GENERATING DATA ####`**

  Set `n_subjects`, `n_trials`, `n_sessions`, and task constants (arms, blocks, item set) in `main.R`. Source `models/[generative_model]/[generative_model].R` and pass the saved true parameters on the scale that function reads. Write `simulated_data.rds` to this job-folder's `artifacts/`: long format, one row per trial, columns the fitting model reads. Generate the data inside the job-folder.

- **`#### RECOVERING PARAMETERS ####`**

  Fit the estimator named in the specification (`models/[fitted_model]/[fitted_model].stan` via cmdstanr, a `brms` fit, or another). Set chains, warmup, and sampling iterations from the Job Card in `main.R` or the fitting script. Extract agent- and population-level draws (`as_draws_df()` or tidybayes `spread_draws()`) and save them separately from the fit: `stan_fit.rds` or `brms_fit.rds`, `draws_sbj.rds`, `draws_pop.rds`, and `recovered_parameters.rds` (true, recovered, and posterior SD per agent per parameter). A brms study also follows `../regression/01_sampling_and_priors.md` and `../regression/02_diagnostics.md`. Report convergence (`rhat`, ess, divergences) before treating a recovery figure as a result (`../04-simulations/references/how-to-read-recovery.md`).

- **`#### VISUALIZATION AND OUTPUT ####`**

  Build every recovery figure from the saved artifacts with custom ggplot2 / tidybayes / ggdist scripts (`theme_minimal(base_size = 13)`; colour from `../visualization/standards/COLOR_STANDARD.md`; PDF+PNG per `EXPORT_STANDARD.md`). Wrappers such as `bayesplot::mcmc_recover_*`, `plot(fit)`, `brms::pp_check()`, shinystan, or rstan shortcuts stay optional extras. Two deliverables go in `output/` with the writing script's two-digit prefix: a Word `.docx` and a multi-page vector PDF.

- **Word document**

  Write it with `officer` (and `flextable` if a table is needed). The `.docx` is the narrative: sample size (`n_subjects`, `n_trials`, `n_sessions`), generative prior distributions as named in `main.R`, any logistic transform onto the unit interval, and quantitative recovery — posterior median vs true and interval coverage at the population; Pearson *r*, bias, and precision at the agent level (`../04-simulations/references/how-to-read-recovery.md`). Embed Figures 1–3, each followed by an APA caption (`Figure N.` in italics, then what is plotted, what the blue dotted line marks, and for Figure 3 that the line is the OLS fit and *r* is Pearson's correlation).

- **The three figures**

  Figure 1 is a faceted posterior density of each population location (`mu_*`), with median, credible interval, mathematical strip labels (`mu[alpha]` via `label_parsed`), and a vertical dotted blue line at the true value. Figure 2 is the same for each population scale (`sigma_*`). Figure 3 is a faceted scatter of true vs recovered (posterior median unless the specification names another summary), with an OLS line and Pearson *r* on each panel and same-scale axes plus an identity line per `../visualization/plot-types/plot-scatter.md`. For Figures 1–2, start from long draws plus a `true_value` column and `geom_vline(aes(xintercept = true_value), linetype = "dotted", colour = "blue", linewidth = 0.8)`, then ggdist/tidybayes density, median, and interval.

- **Multi-page PDF**

  Compile Figures 1–3 into one multi-page vector PDF (`pdf(..., onefile = TRUE)` then `print()` each ggplot), one figure per page, beside the Word file in `output/`. Keep the per-figure PDF+PNG pair as well.

## Examples

main.R example:

```r
rm(list = ls())

#### SETUP ####

library(here)
library(tidyverse)
library(cmdstanr)
library(brms)
library(posterior)
library(tidybayes)
library(ggplot2)
library(ggdist)
library(patchwork)
library(officer)

# Directories
project_root  <- here::here()
code_dir      <- file.path(project_root, "simulation", "<folder_name>", "code")
artifacts_dir <- file.path(project_root, "simulation", "<folder_name>", "artifacts")
output_dir    <- file.path(project_root, "simulation", "<folder_name>", "output")
models_dir    <- file.path(project_root, "models")

# Models
generative_model <- "<model_name>"   
fitted_model     <- "<model_name>"   



#### GENERATING TRUE PARAMETERS ####
# Draw agent-level parameters from the population values above, plot them
# (dot histograms), and save true_population.rds / true_parameters.rds to artifacts/.

mu_alpha    <- NA_real_
sigma_alpha <- NA_real_
mu_beta     <- NA_real_
sigma_beta  <- NA_real_

n_subjects = NA_integer_   # number of agents

source(file.path(code_dir, "01_generate_true_parameters.R"))
source(file.path(code_dir, "02_plot_true_parameters.R"))


#### GENERATING DATA ####

n_trials   = NA_integer_   # trials (or observations) per agent per session
n_sessions = NA_integer_   # sessions per agent; 1 when the task has no sessions

# Source models/<generative_model>/<generative_model>.R, simulate from the saved
# true parameters, and write simulated_data.rds to artifacts/. Nothing is read
# from data/. n_subjects, n_trials, and n_sessions are the quantities set above.
# source(file.path(code_dir, "03_generate_data.R"))


#### RECOVERING PARAMETERS ####
# Fit the researcher's chosen estimator (models/<fitted_model>/<fitted_model>.stan,
# brms, or other). Save the fit, population and agent draws, and recovered
# parameters to artifacts/.

n_chains   = 4
n_iter     = 2000
n_warmup   = 1000

source(file.path(code_dir, "04_fit_model.R"))
source(file.path(code_dir, "05_extract_recovered_parameters.R"))


#### VISUALIZATION AND OUTPUT ####

# Custom ggplot2 / tidybayes / ggdist from the saved draws — not bayesplot recovery
# wrappers. Three figures, then one multi-page vector PDF and one Word report.
source(file.path(code_dir, "06_plot_population_location.R"))
source(file.path(code_dir, "07_plot_population_scale.R"))
source(file.path(code_dir, "08_plot_individual_recovery.R"))
source(file.path(code_dir, "09_compile_recovery_pdf.R"))
source(file.path(code_dir, "10_write_recovery_docx.R"))


```


Example for a "Parameter recovery manuscript excerpt":
```
**

Parameter recovery

We assessed whether the model parameters can be reliably recovered from the simulated full model dataset. For this purpseo, we simulated data from 200 agents, each assigned a distinct set of parameters drawn from broad distributions [α ~ N(0, 1.5); β ∼ N(4, 1.5); λ ~ N(0, 1.5); ⍴spatial ~ N(0, 1.5); ⍴visual ~ N(0, 1.5); ηspatial ~ N(0, 1.5); ηvisual ~ N(0, 1.5)]. Parameters α, λ, ηspatial, and ηvisual were logistically transformed to constrain their values between 0 and 1. We observed strong recovery at both the population and individual levels. Estimated parameters closely matched the true generating values across agents, resulting in high correlations between true and recovered parameters (see Figure 2). These findings indicate that the model is well-identified and suitable for application to empirical data.

**
```

Example for a "Parameter recovery manuscript figure caption":
```
**

Figure 2. Parameter recovery. We simulated data from 200 agents with parameters drawn from broad distributions. (A) For each parameter, we compared the true population mean (dotted blue line) to the corresponding posterior estimate, demonstrating accurate recovery at the population level. (B) To assess recovery at the individual level, we plotted the true simulated parameter values (x-axis) against the recovered posterior estimates (y-axis). Recovered estimates closely tracked the generating values, yielding high correlations across all parameters.

**
```