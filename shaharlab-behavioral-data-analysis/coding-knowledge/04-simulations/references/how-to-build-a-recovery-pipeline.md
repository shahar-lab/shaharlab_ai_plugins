# Building a parameter-recovery pipeline

A recovery study asks one question: **when this model generates data from parameters we chose, does
fitting it back return those parameters?** Everything in the folder serves that comparison, so the
pipeline is built in three stages that each settle one half of the ground truth before any fitting
happens — the environment, the agent population, then generate and recover.

The stages hold whatever model family the study is about. Read the stage names through this table:

| Stage | RL / bandit | Regression | IRT / GRM | Bradley-Terry |
|---|---|---|---|---|
| the environment | arms, trials, reward schedule | design matrix, n observations | item set, response categories | pairing schedule, n comparisons |
| the agent population | subjects with learning rates | subjects with random effects | persons with abilities | players with strengths |
| generate and recover | simulate choices, fit the Stan model | simulate outcomes, fit the regression | simulate responses, fit the IRT model | simulate winners, fit the strengths |

The **environment** is the structure every unit faces; the **agent** is the unit that carries the
parameters being recovered — a subject, a person, an item, a player. The rest of this file uses the RL
wording, and it transfers term for term through the table.

## `main.R` names the three stages

`main.R` sources the `code/` scripts under one header per stage, so reading it top to bottom shows
the whole design before any result. `../assets/example_main.R` is the worked skeleton — start from
it and drop the scripts the study has no use for.

```r
#### SETTING THE ENVIRONMENT ####
#### SETTING THE AGENT POPULATION ####
#### GENERATE AND RECOVER ####
```

## What each stage holds

**Setting the environment** — three scripts: one that sets the environment constants and saves them,
one that generates the structure those constants describe (a reward schedule, a design matrix, an item
bank), and one that plots it. The plot is what lets the user confirm the environment before spending a
sampler on it.

**Setting the agent population** — the same three: one that sets the population-level values
(`mu_alpha`, `sigma_alpha`, `n_subjects` …), one that draws each agent's true parameters from them
and saves `true_parameters.rds`, and one that plots those draws against the population density they
came from. This stage is where the ground truth is created, so it saves the file every later
comparison reads.

**Generate and recover** — four scripts: one naming the models, one generating behavior, one
fitting, one comparing. Name the generating model and the fitted model as two separate variables:

```r
generative_model <- "alpha_beta"
fitted_model     <- "alpha_beta"
```

Equal names make the study a recovery study. Naming a different fitted model makes the same folder a
model-comparison study, with no other change to the pipeline.

## The three agreements that make a recovery result interpretable

The comparison at the end is only about the fitting model when these three hold, so state each one
where the code makes it true:

1. **The true parameters are drawn from the population form the fitting model assumes.** A model
   whose subject-level term is `inv_logit(mu + sigma * raw)` recovers a population drawn as
   `plogis(rnorm(n_subjects, mu_alpha, sigma_alpha))`. The generating draw and the fitting prior
   describe the same distribution.
2. **The generating and fitting parameters are on the same scale.** A generating function that
   applies `plogis()` to an incoming value expects a logit-scale argument; one that uses the value
   directly expects the probability scale. Pass each parameter on the scale its own generating
   function reads it on.
3. **The generating choice rule and the fitting likelihood express the same probability.** A
   two-option softmax `exp(beta * Q) / sum(exp(beta * Q))` and a
   `bernoulli_logit(beta * (Q_right - Q_left))` are the same rule written two ways; three or more
   options call for `categorical_logit`.

## What each script leaves on disk

Every script saves its product to `artifacts_dir` and reads its inputs back from there, per
`00-constitution/coding-rules.md`, so the sampler runs once and the comparison can be rerun
without it. The files the comparison stage needs by name:

| File | Written by | Holds |
|---|---|---|
| `expvalues.rds` (or the study's own name for it) | the environment stage | the generated structure every agent faces |
| `true_parameters.rds` | the population stage | one row per agent, one column per parameter |
| `simulated_data.rds` | generate behavior | the long-format generated dataset |
| `stan_fit.rds` | fit model | the fit object |
| `stan_draws_sbj.rds`, `stan_draws_pop.rds` | fit model | agent-level and population-level draws, extracted as `as_draws_df()` |
| `recovery_table.rds` | the comparison | true, recovered, and posterior SD per agent per parameter |

Saving the draws separately keeps the comparison stage independent of the fit object's temporary
CSV files, which a later session no longer has.

## The values that come from the user

Each of these is a decision rather than a fact, so it arrives in the card's `SPECIFICATION` and is
set in exactly one place in the code:

| Value | Set in |
|---|---|
| `n_subjects`, `n_trials`, `n_blocks` — how much data each agent contributes | the population and environment scripts |
| the population location and scale per parameter (`mu_*`, `sigma_*`) | the population script |
| the environment constants — arms per trial, options offered, schedule volatility | the environment script |
| chains, warmup, sampling iterations | the fitting script |
| the recovery criteria the result is judged against | see `how-to-read-recovery.md` |

Leave `set.seed()` out unless the user asks for a reproducible draw, per
`00-constitution/coding-rules.md`.

## Preconditions

`main.R` defines `project_root`, `code_dir`, `artifacts_dir`, and `output_dir`, and loads `here`,
`tidyverse`, `cmdstanr`, `posterior`, `ggplot2`, `patchwork`, and `ggdist`. The generating and
fitting definitions live in `models/[model_name]/` and are sourced or compiled by path:

```r
source(file.path(project_root, "models", generative_model, paste0(generative_model, ".r")))
stan_file <- file.path(project_root, "models", fitted_model, paste0(fitted_model, ".stan"))
```