# Reading a recovery result

The comparison script's job is to put the numbers a researcher judges recovery by in front of them,
computed from the draws and reported as they came out. The verdict itself is the user's: the criteria
arrive in the card's `SPECIFICATION`, held in named variables at the top of the script so the same
value drives the report and anything that quotes it.

Compute the six checks below in this order — each one qualifies the next, and the first one qualifies
them all.

## 1 · Sampler convergence, before anything else

Report `rhat`, `ess_bulk`, and the divergent-transition count for the population parameters and the
agent-level vector. A recovery figure drawn from a fit that has not converged describes the sampler
rather than the model, so this table is printed first and the criteria variable for it
(`rhat_max` — the user's value) sits beside the rest.

## 2 · Correlation between true and recovered, per parameter

Posterior mean per agent against that agent's true value, as a Pearson `r` per parameter. This is the
headline number and it goes on the recovery scatter as an annotation.

```r
recovered <- draws_sbj |>
  pivot_longer(starts_with(c("alpha_sbj", "beta_sbj")), names_to = "var_name", values_to = "value") |>
  mutate(subject = as.numeric(str_extract(var_name, "\\d+"))) |>
  group_by(var_name, subject) |>
  summarize(mean_val = mean(value), posterior_sd = sd(value), .groups = "drop")
```

## 3 · Bias — where the cloud sits relative to the diagonal

`r` measures whether the ordering survived; bias measures whether the values did. Report the mean
signed error (`recovered - true`) and the slope of the fitted line, both per parameter. A cloud that
is tight but sits off the identity line is a systematically over- or under-estimated parameter, and
only these two numbers show it.

## 4 · Precision and shrinkage

Report the median posterior SD per parameter, and the recovered range against the true range. A
hierarchical fit pulls agent estimates toward the group mean, which compresses the recovered spread —
expected, and worth quantifying, because heavy compression is the same picture as a parameter the data
barely constrains.

## 5 · The population-level parameters against their true values

For each `mu_*` and `sigma_*`, report the posterior median and whether the generating value falls
inside the interval. Agent-level recovery can be middling while the population level is recovered
well, and a study whose conclusion is about the group is answered here.

## 6 · Trade-offs between parameters

Correlate the recovery errors of each parameter pair (`alpha` error against `beta` error). A strong
correlation here is what a non-identifiable pair looks like: two parameters that compensate for each
other, so the fit finds the likelihood ridge rather than the point on it.

## The figure

Four panels, per the pattern the lab works from: the two population posteriors on top, the two
true-versus-recovered scatters below. Each panel is a routed plot type under
`visualization/plot-types/` — `plot-posterior.md` for the population panels,
`plot-scatter.md` for the recovery panels (same-scale pair, identity diagonal, Pearson annotation), and
`plot-dot-histogram.md` for the true-parameter distributions back in the population stage. The
assembly follows `visualization/standards/PANEL_TAGGING_STANDARD.md` and
`EXPORT_STANDARD.md`.

## Reporting the verdict

State each number against the criterion the user gave, and where recovery falls short of it, name
which of the three causes the numbers point at:

| The numbers show | Points at |
|---|---|
| errors of two parameters strongly correlated (check 6) | the pair is not identifiable in this design |
| wide posterior SDs, heavy shrinkage, low `r` on every parameter (checks 2, 4) | each agent contributes too few observations |
| high `r` with a slope well off 1, or a population parameter outside its interval (checks 3, 5) | the generating and fitting specifications disagree — recheck the three agreements in `how-to-build-a-recovery-pipeline.md` |

Report the numbers and the cause they point at; the user is the one who decides what the study
concludes.

## Preconditions

`main.R` defines `artifacts_dir` and `output_dir` and loads `tidyverse`, `posterior`, `ggplot2`,
`ggdist`, and `patchwork`. This script reads `true_parameters.rds`, `stan_draws_sbj.rds`, and
`stan_draws_pop.rds` from `artifacts_dir`, and saves `recovery_table.rds` back to it.