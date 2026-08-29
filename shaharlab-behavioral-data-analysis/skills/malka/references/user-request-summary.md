# Malka — Summary Card Examples

Reference for the plain-English **Summary Card** Malka presents at the end of the
interview, once every applicable slot of `writer-card.md`'s card is filled. Each card names the domain in plain language, states the folder it acts
on and the concrete choice the user made, and ends with the same two-item checklist so the
interactive terminal UI picks it up. Machinery stays off the card — file paths, slot names, and
AI-to-AI brief language live in the execution templates the user never sees.

**Values stay on it.** This gate is the only approval in the system, so a number the card leaves out
is a number nobody approved: "and your priors" reads as agreement while the card the Writer executes
says `normal(0, 1)` on the fixed effects. Every value that will appear in the code appears here too,
in plain English — "weakly informative priors, normal(0, 1) on the effects" is still a sentence a
researcher reads, and it is one they can correct. Plain language is the rule; vagueness is not.

**Say what the run will overwrite.** Where the plan rebuilds a `data/` stage that existing folders
read, the card says so and names them, since rerunning preprocessing invalidates every analysis
downstream of it. That is the one thing on the card the user cannot infer from their own request.

## Example 1: Bayesian Regression

📋 Summary: Bayesian Model

For `analysis/go_nogo_rt/`, we will run a Bayesian regression using formula
`rt ~ condition + (1|subject)`, with weakly informative priors — normal(0, 1) on the
effects, package defaults elsewhere — sampled over 4 chains of 2000 iterations, half
of them warmup. It produces the model fit, the convergence diagnostics, and a
posterior plot.

- [ ] Confirm & Execute
- [ ] Revise

## Example 2: Data Cleaning

📋 Summary: Pre-processing

For `preprocessing/`, we will drop participants with fewer than 50 valid trials, then drop
trials where RT is under 200 ms or over 3000 ms, save the clean output to
`data/processed/`, and report the exclusion counts at each phase.

This rewrites `data/processed/`, so `analysis/go_nogo_rt/` and `analysis/stay_by_reward/`
will need rerunning against the new file.

- [ ] Confirm & Execute
- [ ] Revise

## Example 3: Visualization

📋 Summary: Plots

Inside `analysis/value_learning/output/`, we will generate a side-by-side scatter plot and
histogram panel following lab themes.

- [ ] Confirm & Execute
- [ ] Revise

## Example 4: New Scaffolding

📋 Summary: New Analysis

We will initialize a new folder at `analysis/effort_discounting/` containing standard
subdirectories, `main.R`, and `summary.md`.

- [ ] Confirm & Execute
- [ ] Revise
