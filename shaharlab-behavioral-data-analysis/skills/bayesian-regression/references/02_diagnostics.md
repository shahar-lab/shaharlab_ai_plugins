# Reference: MCMC Diagnostics

After a model is fit, write a separate R script that produces one `diagnostic.pdf` with these pages, in order:

1. **Summary table** — effective sample size (`ess_bulk`, `ess_tail`) and `rhat` per parameter
2. **Trankplot** — rank-based trace plot per parameter (`mcmc_rank_overlay`)
3. **Pairs plot** — pairwise posterior draws (`mcmc_pairs` or `pairs()` on the fit)

Save the script to `code_dir` and the PDF to `output_dir`. Do not print interpretation or flag convergence issues yourself — that is the user's call.

```r
library(brms)
library(bayesplot)
library(gridExtra)
library(posterior)

model_fit <- readRDS(file.path(artifacts_dir, "model_fit.rds"))
draws     <- as_draws_array(model_fit)

summary_table <- summarise_draws(draws, ess_bulk, ess_tail, rhat)
summary_table[-1] <- round(summary_table[-1], 2)

trank_plot <- mcmc_rank_overlay(draws)
pairs_plot <- mcmc_pairs(draws)

pdf(file.path(output_dir, "diagnostic.pdf"), width = 8, height = 6)
grid.arrange(tableGrob(summary_table))
print(trank_plot)
print(pairs_plot)
dev.off()
```
