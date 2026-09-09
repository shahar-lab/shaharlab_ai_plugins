# Planning — the runs and jobs the request breaks into

You know need to make a plan that will settle how  the user-request will be executed. This plan translated the user-request into a set of runs and jobs.

## The plan has two levels

* A **plan** is the ordered list of runs.

- A **run**  - which is the set of jobs executed at the same time. Runs go out in order, and the jobs inside one
  are dispatched together.
- A **job** is one folder. One job is one card, one dispatch, one Writer. This holds on every plan.

A single-job request is one run holding one job, which is what most requests are. Runs start earning
their keep once a request holds several jobs.

## One job, one folder

The Writer writes only inside the folder it is given, which makes `project-rules.md` §1 ("One Model, One
Folder") the boundary of a job too — one canonical set, one `rules.md`, one surface the Writer checks
itself against before returning. `preprocessing/` counts as one job together with the `data/` stages its
`converting_` scripts write.

The boundary binds both ways:

- **No smaller.** A fit, its diagnostics, and its plot are one job, not three.
- **No bigger.** Work that crosses folders is several jobs, each its own Writer spawn. Each leaves a
  saved product behind (`project-rules.md` §2.I), so a job in a later run starts from a file on disk
  rather than from another agent's context, and what crosses travels in the next card's `PROJECT STATE`.

## Count the jobs first

Count by what each folder produces, rather than by the word the request used for it:

| The work produces | How many jobs |
|---|---|
| fitted model objects (`brm()`, `stan()`, any saved fit) | **one job per fit** — one per distinct combination of formula, family, and analyzed subset |
| plots, tables, descriptive or summary statistics, data checks | **one job** for the coherent set, however many figures it holds |
| a `preprocessing/` pipeline and the `data/` stages it writes | **one job** |
| one `simulation/` study | **one job**, however many fits its design runs |

So two different formulas are two jobs, one formula fit to four filtered subsets is four jobs, and five
plot scripts producing five figures are one job. The per-fit rule belongs to `analysis/` and stops there:
`simulations/rules.md` states that a recovery study fitting its model back a hundred times is one study
in one folder.

Name every folder in the plan before dispatching. When the job count is greater than one, say the count
and the folder names to the user — a user who described "an analysis" in the singular may not realize
they specified six fits, and this is the last moment it is cheap to find out.

## Place each job in a run

A job joins the earliest run where everything it reads is already on disk.

Two reads create a wait:

| A job that reads | waits for |
|---|---|
| `data/processed/` or `data/raw/` | the `preprocessing/` job that writes that stage |
| a `models/` definition | the `models/` job that writes it |

Everything else runs together, and `project-rules.md` §0 is what settles it: an `analysis/` folder "reads
from `data/processed/` and writes only inside its own folder", while a `simulation/` folder "generates its
data from a `models/` definition into its own `artifacts/`, and reads nothing from `data/`". Two jobs
writing different folders, each reading only what is already on disk, belong in the same run.

Ask what is already there. A `preprocessing/` job belongs in the plan when `data/processed/` needs
rebuilding; when that stage is already current, every analysis job reading it goes straight into the first
run. The user is the one who knows which case it is.

## Same-shape jobs: send one, then clone the rest

When a run would hold several jobs of the same shape — one formula over six filtered subsets — give the
first one a run of its own, then send the rest together in the run after it.

The first job is built on the full craft route and leaves a finished folder on disk. The rest are that
folder with one value changed, so their cards route to
`coding-knowledge/02-analysis/smart_clone.md` and the folder's own `rules.md` instead of
the whole craft stack. The extra run earns itself twice over: the craft library is read once rather than
six times, and the folders come out consistent because the later ones were copied from one that already
works. A gap in the specification also surfaces on the first job, while the other five are still unspent.

Jobs of different shapes share a run and go out together. Their failure modes have nothing in common, so
sending one first would teach the others nothing.

## The plan's shape

One line per job, grouped under its run — what the job produces, and the folder it writes into.
`project-rules.md` §0's request-to-location table places each folder.

```
run 1  preprocessing/                revise the exclusions, regenerate the exclusion summary
       simulation/param_recovery/    generate from the model definition, fit back, plot recovery
run 2  analysis/descriptives/        summary statistics and distribution figures
       analysis/reward_history/      fit the regression on the processed data, plot its posteriors
```

Each job's folder becomes that dispatch's `FOLDER`. Step 3 happens once per job, and Step 4 once per run.
The Step 1 Exploration Pass stays off the list: it ran before the gate and writes nothing.

## Worked examples

### One job, one run

> "Add a posterior plot to the stay-by-reward analysis I already have."

One job. The plot joins the folder that already exists, and both the fit and `data/processed/` are on
disk, so nothing waits.

```
run 1  analysis/stay_by_reward/      add the posterior plot to the existing folder
```

Most requests look like this, and here the plan is a formality — say nothing to the user and carry on.

### Four jobs, two runs

> "Clean the data with these exclusions, run a parameter-recovery simulation for my RL model, give me
> descriptive plots, and fit the reward-history regression."

Four jobs: one preprocessing pipeline, one simulation study, one descriptive folder (five figures still
merge into one job), and one fit. Both analysis jobs read `data/processed/`, so they wait for
preprocessing. The simulation reads its `models/` definition and nothing from `data/`, so it waits for
nothing once that definition is on disk.

```
run 1  preprocessing/                revise the exclusions, regenerate the exclusion summary
       simulation/param_recovery/    generate from models/rl_model.stan, fit back, plot recovery
run 2  analysis/descriptives/        summary statistics and distribution figures
       analysis/reward_history/      fit the regression, plot its posteriors
```

The simulation runs while preprocessing does. When `models/rl_model.stan` is missing, a `models/` job
takes run 1 by itself and the simulation moves to run 2 — the same request plans differently depending
on what is already on disk, which is why the question gets asked.

### Six fits of one formula

> "Fit the reward-history model separately for each of my six age groups."

Six jobs, because one formula over six subsets is six fits and therefore six folders. Say that count to
the user. All six read `data/processed/` and none reads another's output, which makes them same-shape
siblings: the first goes alone, the rest follow as clones.

```
run 1  preprocessing/                     rebuild data/processed/ with the agreed exclusions
run 2  analysis/reward_history_age_1/     full craft route — fit, diagnose, plot
run 3  analysis/reward_history_age_2/     clone of age_1, its own subset filter
       analysis/reward_history_age_3/     clone of age_1, its own subset filter
       analysis/reward_history_age_4/     clone of age_1, its own subset filter
       analysis/reward_history_age_5/     clone of age_1, its own subset filter
       analysis/reward_history_age_6/     clone of age_1, its own subset filter
```

## What you return

The ordered list of runs and nothing else.

## Where the plan is kept

Write the plan, and the approved specification it was built from, to `.malka/current_job.md` in the
project root — the last act of Step 2, before the first card is built. Create `.malka/` if it is not
there. The folder sits outside `project-rules.md` §0's five-part tree because it holds working state
rather than a project part, and it carries one job at a time: the next job overwrites it, and the
durable record of what was built stays each folder's own `summary.md`.

```markdown
# Current job — <the request in one line>

## Plan
run 1  preprocessing/                revise the exclusions, regenerate the exclusion summary
run 2  analysis/reward_history/      fit the regression, plot its posteriors

## Specification — preprocessing/
Participant-level (phase 1): exclude a subject with fewer than 50 valid trials.
Trial-level (phase 2): drop a trial with RT < 200 ms or RT > 3000 ms.

## Specification — analysis/reward_history/
Model: brms, stay_ch ~ reward_oneback + (reward_oneback | subject)
...
```

One section per job, headed by the folder it writes into, in the user's own values and in full.

Keeping it on disk is what lets Step 3 build every card by quoting a fixed text rather than by
recalling one. Step 4 comes back to this file after every run, and the Code Reviewer reads it directly
— so a plan or a value re-derived mid-job can no longer come back different from the one the user
approved.

## What you tell the user

Nothing, for the single-job plan that most requests are. For two or more jobs, state the runs and what
each one leaves behind — a statement rather than a gate: Step 1's approval is the only one, so say it and
carry straight on. Say it because a wrong plan costs a full dispatch cycle per run, and the user is the
one who knows whether `data/processed/` is already current, or whether the model they want fitted already
exists.

> This happens as two runs. First, together: `preprocessing/` — revising the exclusions and regenerating
> the exclusion summary, which rewrites `data/processed/` — and `simulation/param_recovery/`, which
> generates its own data from your model definition. Then, once the processed data is saved:
> `analysis/descriptives/` and `analysis/reward_history/`, both reading it. Each run finishes and saves
> its products before the next starts, so you can check the processed data before the models run.

Name the folders as folders and say what each run leaves behind. The cards, and the number of Writers a
run spawns, are machinery the user has no call to make.
