# The Plan Card

A Plan Card is this request's job list: what each job is, which folder it writes into, and the order the jobs run. Each job later becomes one subagent that performs it. This document shows how to structure one.

## 

## 1. Structure of the Plan Card

The shape of every Plan Card. Names only in the box; what each name means is in the bullets. One job is one block: no blank line between `JOB` and `FOLDER`. A blank line starts the next job.

```text
Plan Card

## WAVE 1 ##
JOB
[one line — what this job produces]
FOLDER
[job-folder path]  (new / existing / repair)

## WAVE 2 ##
JOB
[one line]
FOLDER
[job-folder path]  (new / existing / repair)
```

- **Plan Card**
  
  The first line of the card.

- **`WAVE`**
  
  A numbered heading (`## WAVE 1 ##`, `## WAVE 2 ##`, …). WAVEs run in order. Jobs under the same WAVE run together. When the Plan Card is one job, skip this heading.

- **`JOB`**
  
  The one-line name of what this job produces. Take it from the user's request. This line is copied onto the Job Card and is how the Writer, which never saw the interview, knows what to do. Write it as the task, in their words.

- **`FOLDER`**
  
  The job-folder this job writes into, then `(new)`, `(existing)`, or `(repair)`. New: the folder is not on disk yet. Existing: it is, and this job adds to it. Repair: it is, and this job revises files already in it. Counting jobs is counting folders: one job, one folder.

## 2. From the user request to JOBs and WAVEs

The Plan Card is how you translate the user's prompt into an executable plan. The important part is to translate the request into the right number of jobs and WAVEs.

**Setting up the jobs.** A job is always a single folder, written by one fresh subagent with its own Job Card. Read `coding-knowledge/00-constitution/project-terms.md` for the five main-folders and how a lab project is structured. Then count jobs by how many folders the work needs. Remember that each job is a fresh subagent. Things to consider when you count the jobs:

* One job is one fresh subagent that writes into a single folder.
* Plots or tables that belong together are one job.
* `preprocessing/` with the `data/` stages it writes is one job.
* One simulation study is one job.
* Regression is one folder per regression equation, so two formulas or two analyzed subsets are two jobs.

**Setting up the WAVEs.** Once the list of jobs is set, structure the WAVEs. WAVEs are how you structure the flow of the jobs and their order. Some jobs depend on others — they read a file another job on this Plan Card still has to write — and those must run sequentially, in a later WAVE. Time to finish the whole work is critical. Therefore everything that does not wait should run together, so the work finishes as soon as it can. Putting jobs into WAVEs is how you encode that: WAVEs run in order (serial); jobs under the same WAVE run together (parallel). One job omits WAVE. Same-shape fits: the first job is its own WAVE; the copies share the next WAVE.

**When the prompt cannot be counted.** If the user named no folder and the request could land in more than one — send `AskUserQuestion` with one option per landing, then write the Plan Card from the answer.

## 3. Examples of Plan Cards

### Example 1. One brms fit plus a posterior-mean figure

The user named the formula, the data, and a posterior-mean figure of the two-way interaction.

```text
Plan Card

JOB
Fit a stay-by-reward regression, condition by trial-type, and plot the posterior means
FOLDER
analysis/stay_reward_x_condition/ (new)
```

### Example 2. Clean, then fit; two clones; then loo

The user wants the data cleaned, then a stay-by-reward fit, then the same fit in two more conditions by cloning, then a loo comparison. The new column has to exist in `data/processed/` before any fit can read it. Each clone needs the filled source folder. loo reads the three fits.

```text
Plan Card

## WAVE 1 ##
JOB
Add a choice-stay logical column to the data
FOLDER
preprocessing/ (repair)

## WAVE 2 ##
JOB
Fit a stay-by-reward regression of the new stay column, condition by trial-type
FOLDER
analysis/stay_reward_x_condition/ (new)

## WAVE 3 ##
JOB
Clone stay_reward_x_condition for the easy condition
FOLDER
analysis/stay_reward_x_condition_easy/ (new)

JOB
Clone stay_reward_x_condition for the hard condition
FOLDER
analysis/stay_reward_x_condition_hard/ (new)

## WAVE 4 ##
JOB
Compare the three stay-by-reward fits with loo
FOLDER
analysis/stay_reward_x_condition_loo/ (new)
```

### Example 3. A model, then a recovery study

The user wants a new RL model written, then a parameter-recovery study that generates from it.

```text
Plan Card

## WAVE 1 ##
JOB
Write the generating .R and fitting .stan for the new RL model
FOLDER
models/rl_twostep/ (new)

## WAVE 2 ##
JOB
Build a parameter-recovery study of that model
FOLDER
simulation/rl_twostep_recovery/ (new)
```

### Example 4. First preprocessing of an online study

The user has `data/collected/` from Pavlovia and wants it cleaned.

```text
Plan Card

JOB
Clean the Pavlovia export into tidy tables and apply exclusions
FOLDER
preprocessing/ (new)
```

### Example 5. Descriptives of the sample

The user wants a table of who is in the sample.

```text
Plan Card

JOB
Describe the sample: counts, demographics, and questionnaire scores
FOLDER
analysis/descriptives/ (new)
```
