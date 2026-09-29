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



## Structuring the analysis in four parts

### Generating true parameters

Set the highest-level parameters in `main.R`. For a hierarchical model that is the population
  location (`mu_*`) and scale (`sigma_*`) of each parameter. Non-hierarchical studies set the
  single true value of each parameter in `main.R` instead.

A `code/` script draws the lower-level parameters from those values (one row per agent, one
  column per parameter), plots them, and saves them to `artifacts/` (typically
  `true_population.rds` and `true_parameters.rds`).

Plotting at this stage is mostly **dot histograms** of the drawn agent-level values, following
  `../visualization/plot-types/plot-dot-histogram.md`. One panel (or facet) per parameter. Export a  PDF+PNG to `output/` per `../visualization/standards/EXPORT_STANDARD.md`. Where a parameter is used on the unit interval, draw it on the unconstrained (logit) scale the
  fitting model assumes and apply `plogis()` before it enters the generating function. State that
  transform in `main.R` and again in the Word narrative.

### Generating data

This stage uses the saved true parameters and a data-generating model the researcher pinpoints in
a subfolder of the `models/` main-folder (`models/[generative_model]/[generative_model].R`).

Sample-size quantities — `n_subjects`, `n_trials`, `n_sessions` — are set in `main.R`. Task  constants the generating function also needs (arms, blocks, item set) are set there too.

Source the generating definition by path from `models/`. Pass the true parameters on the scale that function reads them on. Do not draw parameters inside the generating function.

The end result is artificial data saved into this job-folder's `artifacts/` (typically
  `simulated_data.rds`): long format, one row per trial (or observation), with the columns the
  fitting model reads.

Nothing is read from `data/`.

### Recovering parameters

This stage activates the fitting method the researcher chose: a `.stan` file in the model's
subfolder (`models/[fitted_model]/[fitted_model].stan` via cmdstanr), a `brms` fit, or another
estimator named in the specification.

Compile and sample here. Chains, warmup, and sampling iterations are reserved values; they  arrive in the Job Card and are set in `main.R` or the fitting script, not invented later.

Extract agent-level and population-level draws (`as_draws_df()` or tidybayes `spread_draws()`)  and save them **separately** from the fit object, so comparison does not depend on the sampler's temporary CSV files. Typical artifacts: `stan_fit.rds` (or `brms_fit.rds`), `draws_sbj.rds`, `draws_pop.rds`.

The end result is a saved set of recovered parameters in this job-folder's `artifacts/`   (typically `recovered_parameters.rds`: true, recovered, and posterior SD per agent per  parameter).

A study that fits brms also follows `../regression/01_sampling_and_priors.md` and
`../regression/02_diagnostics.md`. Convergence (`rhat`, ess, divergences) is reported before any
recovery figure is treated as a result — see `../04-simulations/references/how-to-read-recovery.md`.

### Visualization and output

Evaluate Bayesian parameter recovery by **writing and executing custom plotting scripts from the
raw saved draws and true values** (ggplot2, tidybayes, ggdist, and document-export tools). Do not
rely on built-in diagnostic wrappers as the recovery figures: `bayesplot::mcmc_recover_*`, `plot(fit)`, `brms::pp_check()`, shinystan, rstan plotting shortcuts, or any other canned recover/trace helper. Those may be used only as optional extra diagnostics, never as the three required figures or as a substitute for the Word narrative.

Build every recovery figure from `artifacts/` (`true_parameters.rds`, `draws_pop.rds`,
`draws_sbj.rds`, `recovered_parameters.rds`). Apply clean publication aesthetics
(`theme_minimal(base_size = 13)`, no cluttered grids, readable strip labels). Colour follows
`../visualization/standards/COLOR_STANDARD.md` when colour is used. Export each figure as PDF+PNG to `output/` per `EXPORT_STANDARD.md`, then compile the three figures into the multi-page PDF.

This stage produces **two primary deliverables**, both written under `output/` with the writing
script's two-digit prefix:

1. A formatted Word document (`.docx`)
2. A standalone multi-page vector PDF (one figure per page)

#### Word document (`.docx`)

Write it with `officer` (and `flextable` if a table is needed). Do not leave the narrative as
markdown only — the `.docx` is required. It contains an empirical-results narrative of the
recovery simulation, embedded figures, and formal APA-style captions. The narrative must state:

- **Sample size** — `n_subjects`, `n_trials`, `n_sessions`, and any other design quantities set in
  `main.R`
- **Generative prior distributions** — the population form each parameter was drawn from (family
  and numeric location/scale), named as they appear in `main.R`
- **Explicit logistic transformations to the unit interval** where they apply (e.g. a learning
  rate drawn as `plogis(rnorm(n_subjects, mu_alpha, sigma_alpha))`)
- **Quantitative evaluations of recovery** — at least posterior median vs true value and interval
  coverage for each population parameter, and per-parameter Pearson *r*, bias, and precision for
  agent-level recovery (`../04-simulations/references/how-to-read-recovery.md`)

Embed the three figures below, each followed by an APA caption (`Figure 1.`, `Figure 2.`,
`Figure 3.` in italics, then a sentence that states what is plotted, what the blue dotted line
marks, and — for Figure 3 — that the line is the OLS fit and *r* is Pearson's correlation).

#### The three figures

**Figure 1 — population location parameters.** Custom posterior density of each population
location (`mu_*`) with its median and credible interval. Facet one panel per location parameter.
Label strips with mathematical notation (`mu[alpha]`, `mu[beta]`, … via `label_parsed` or
equivalent). Draw a **vertical dotted blue** reference line at the true generating value on every
facet.

**Figure 2 — population scale parameters.** The same structure for each population scale
(`sigma_*`): faceted posterior densities, medians and credible intervals, mathematical strip
labels, and a **vertical dotted blue** line at the true generating scale on every facet.

**Figure 3 — individual-level recovery.** Faceted scatter plots, one panel per agent-level
parameter. Horizontal axis: true generating value. Vertical axis: recovered posterior estimate
(posterior median unless the specification names another summary). Add a linear-regression fit
line on each panel and annotate that panel with its Pearson correlation coefficient. Same-scale
axes and an identity line follow `../visualization/plot-types/plot-scatter.md` so bias is readable
against *r*.

Suggested geom stack for Figures 1–2, one data frame of long draws plus a `true_value` column:

```r
geom_vline(aes(xintercept = true_value), linetype = "dotted", colour = "blue", linewidth = 0.8)
# then ggdist/tidybayes density + median + interval, faceted with labeller = label_parsed
```

#### Multi-page PDF

Compile Figures 1–3 sequentially into a **single multi-page vector PDF**, one figure per page
(e.g. `pdf(..., onefile = TRUE)` then `print()` each ggplot). Save it beside the Word deliverable
in `output/`. This PDF is in addition to the per-figure PDF+PNG pair.



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

source(file.path(code_dir, "01_generate_true_parameters.R"))
source(file.path(code_dir, "02_plot_true_parameters.R"))


#### GENERATING DATA ####

n_subjects = NA_integer_   # number of agents
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