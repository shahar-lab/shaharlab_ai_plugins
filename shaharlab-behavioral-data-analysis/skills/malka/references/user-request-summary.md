# Malka — Summary Card Examples

Reference for the plain-English "summary card" Malka presents at the end of the
interview, once every applicable field of `execution-card.md`'s writer card is filled. Each card names the domain in plain language, states the folder it acts
on and the concrete choice the user made, and ends with the same two-item checklist so the
interactive terminal UI picks it up. No file paths, technical fields, or AI-to-AI brief
language belong in the card — those stay in the execution templates the user never sees.

## Example 1: Bayesian Regression

📋 Summary: Bayesian Model

For `analysis/go_nogo_rt/`, we will run a Bayesian regression using formula
`rt ~ condition + (1|subject)` and your priors to generate the model fit and posterior
check.

- [ ] Confirm & Execute
- [ ] Revise

## Example 2: Data Cleaning

📋 Summary: Pre-processing

For `preprocessing/`, we will filter out trials where RT < 200ms and save the clean output
directly to `data/data_filtered/`.

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
