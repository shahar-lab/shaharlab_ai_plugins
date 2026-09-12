# The Plan Card

A Plan Card is this request's job list: what each job is, which folder it writes into, the order the jobs run, and the values the prompt already gave. Each job later becomes one subagent that performs it. This document shows how to structure one.

## 1. Structure of the Plan Card

```text
Plan Card

## WAVE 1 ##
JOB
[one line — what this job produces]

FOLDER
[job-folder path]  (new / clone / repair)

CHECKS
- [this job's pre-deploy-checks.md paths]

SPECIFICATION
- [each value the prompt already gave]


## WAVE 2 ##
JOB
[one line]

FOLDER
[job-folder path]  (new / clone / repair)

CHECKS
- [this job's pre-deploy-checks.md paths]

SPECIFICATION
- [each value the prompt already gave]
```

- **`Plan Card`**
  
  The name. First line of every copy. One Plan Card per request.

- **`WAVE`**
  
  A batch of jobs. WAVEs run in order: WAVE 1, then WAVE 2. That is serial. Jobs listed under the same WAVE run together. That is parallel. Omit WAVE when the Plan Card is one job.

- **`JOB`**
  
  The one-line name of what this job produces. Take it from the user's request. This line is copied onto the Code-Writer Card and is how the Writer, which never saw the interview, knows what to do. Write it as the task, in their words.

- **`FOLDER`**
  
  The path of the folder this job writes into. The first segment is the main-folder — cleaning, an empirical analysis, a model definition, or a simulation — which is Malka translating the user's request into lab terms. That choice is how she and the Writer know what kind of work this is. One job is always done in one folder. Mark new / clone / repair on the path line so the Writer knows whether to start it, copy one, or edit what is already there.

- **`CHECKS`**
  
  Paths to the `pre-deploy-checks.md` files this job needs. Critique opens these against this job's `SPECIFICATION` and asks the leftover questions. Fill from `FOLDER` and the `JOB` line, per §2. This slot stays on the Plan Card; omit it when printing the card in the conversation.

- **`SPECIFICATION`**
  
  The values for this job — formula, cutoffs, family, priors, sampling, plot type. Write each value the prompt already gave, one per line. Keep the slot even when the prompt gave none yet, so later beats have a place to write.

## 2. From the user request to JOBs and WAVEs

The Plan Card is how you translate the user's prompt into an executable plan. The important part is to translate the request into the right number of jobs and WAVEs.

**Setting up the jobs.** A job is always a single folder, written by one fresh subagent with its own card. Read `coding-knowledge/00-constitution/project-terms.md` for the five main-folders and how a lab project is structured. Then count jobs by how many folders the work needs. Remember that each job is a fresh subagent. Things to consider when you count the jobs:

* One job is one fresh subagent that writes into a single folder.
* Plots or tables that belong together are one job.
* `preprocessing/` with the `data/` stages it writes is one job.
* One simulation study is one job.
* Regression is one folder per regression equation, so two formulas or two analyzed subsets are two jobs.

**Setting up the WAVEs.** Once the list of jobs is set, structure the WAVEs. WAVEs are how you structure the flow of the jobs and their order. Some jobs depend on others — they read a file another job on this Plan Card still has to write — and those must run sequentially, in a later WAVE. Time to finish the whole work is critical. Therefore everything that does not wait should run together, so the work finishes as soon as it can. Putting jobs into WAVEs is how you encode that: WAVEs run in order (serial); jobs under the same WAVE run together (parallel). One job omits WAVE. Same-shape fits: the first job is its own WAVE; the copies share the next WAVE.

## 3. Examples

### Example 1 — one job

A filled Plan Card. One job, so no WAVE.

```
Plan Card

JOB
Fit the stay-by-reward regression and plot its posteriors.

FOLDER
analysis/stay_by_reward/ (new)

CHECKS
- 02-analysis/pre-deploy-checks.md
- 02-analysis/regression/pre-deploy-checks.md
- 02-analysis/visualization/pre-deploy-checks.md

SPECIFICATION
- Figure: posterior plot
```

### Example 2

WAVE 1 runs first, then WAVE 2, then the two jobs under WAVE 3 run together, then WAVE 4.

```
Plan Card

## WAVE 1 ##
JOB
Add a choice-stay logical column to the data

FOLDER
preprocessing/ (revise)

CHECKS
- 01-preprocessing/pre-deploy-checks.md

SPECIFICATION
- Calculated column: choice-stay, logical


## WAVE 2 ##
JOB
Fit a stay-by-reward regression with an interaction with condition and plot its posteriors.

FOLDER
analysis/stay~reward x condition (new)

CHECKS
- 02-analysis/pre-deploy-checks.md
- 02-analysis/regression/pre-deploy-checks.md
- 02-analysis/visualization/pre-deploy-checks.md

SPECIFICATION
- Formula includes the interaction of stay-by-reward with condition
- Figure: posterior plot


## WAVE 3 ##
JOB
Clone the regression from WAVE 2 only drop the interaction with condition

FOLDER
analysis/stay~reward + condition (new)

CHECKS
- 02-analysis/pre-deploy-checks.md
- 02-analysis/regression/pre-deploy-checks.md
- 02-analysis/visualization/pre-deploy-checks.md

SPECIFICATION
- Same regression as WAVE 2, without the interaction with condition
- Figure: posterior plot


JOB
Clone the regression from WAVE 2 only drop the condition predictor completely

FOLDER
analysis/stay~reward (new)

CHECKS
- 02-analysis/pre-deploy-checks.md
- 02-analysis/regression/pre-deploy-checks.md
- 02-analysis/visualization/pre-deploy-checks.md

SPECIFICATION
- Same regression as WAVE 2, without the condition predictor
- Figure: posterior plot


## WAVE 4 ##
JOB
Make a model comparison using loo package and print the results output to pdf

FOLDER
analysis/stay~reward_model_compare/ (new)

CHECKS
- 02-analysis/pre-deploy-checks.md

SPECIFICATION
- Model comparison with loo
- Print the results to PDF
```

### Example 3 — two jobs, serial

Each WAVE has one job. WAVE 2 waits for WAVE 1. The prompt named the jobs and left the values unset, so each `SPECIFICATION` is present and empty.

```
Plan Card

## WAVE 1 ##
JOB
Write the RL model definition.

FOLDER
models/rl_model/ (new)

CHECKS
- 03-models/pre-deploy-checks.md

SPECIFICATION


## WAVE 2 ##
JOB
Run parameter recovery for the RL model.

FOLDER
simulation/param_recovery/ (new)

CHECKS
- 04-simulations/pre-deploy-checks.md
- 03-models/pre-deploy-checks.md

SPECIFICATION
```
