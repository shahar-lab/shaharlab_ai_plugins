# Confirm

Step 1's last beat. The plain-English **Summary Card** and the halt. Machinery stays off the Summary Card — file paths, slot names, and AI-to-AI brief language live in the Code-Writer Cards the user never sees.

**Values stay on it.** This gate is the only approval in the system, so a number the card leaves out is a number nobody approved. Every value that will appear in the code appears here too, in plain English.

**Say what the job will overwrite.** Where the Plan Card rebuilds a `data/` stage that existing folders read, the Summary Card says so and names them. That is the one thing on the Summary Card the user cannot infer from their own request.

Present the Summary Card, then halt until yes. Treat **Revise** as a return to Talk. Treat an ambiguous reply as a no and ask again.

On yes, write the Plan Card and each job's specification to `.malka/current_job.md`. Then go to Step 2.

Each Summary Card ends with the same two-item checklist so the interactive terminal UI picks it up. The first line is the name.

## Example 1: One analysis

Summary Card

📋 Summary: Bayesian Model

For `analysis/go_nogo_rt/`, we will run a Bayesian regression using formula
`rt ~ condition + (1|subject)`, with weakly informative priors — normal(0, 1) on the
effects, package defaults elsewhere — sampled over 4 chains of 2000 iterations, half
of them warmup. It produces the model fit, the convergence diagnostics, and a
posterior plot.

- [ ] Confirm & Execute
- [ ] Revise

## Example 2: Two jobs — clean, then fit

Summary Card

📋 Summary: Preprocessing and stay-by-reward

Two jobs. `preprocessing/` drops participants with fewer than 50 valid trials, then drops
trials where RT is under 200 ms or over 3000 ms, writes `data/processed/`, and reports
the exclusion counts. Then `analysis/stay_by_reward/` fits
`stay_ch ~ reward_oneback + (reward_oneback | subject)`, bernoulli, weakly informative
priors — normal(0, 1) on the effects — 4 chains of 2000 iterations, half warmup, and a
posterior plot of the fixed effects.

This rewrites `data/processed/`, so `analysis/go_nogo_rt/` will need rerunning against
the new file. `analysis/stay_by_reward/` waits until preprocessing is done.

- [ ] Confirm & Execute
- [ ] Revise

## Example 3: Visualization

Summary Card

📋 Summary: Plots

Inside `analysis/value_learning/output/`, we will generate a side-by-side scatter plot and
histogram panel following lab themes.

- [ ] Confirm & Execute
- [ ] Revise
