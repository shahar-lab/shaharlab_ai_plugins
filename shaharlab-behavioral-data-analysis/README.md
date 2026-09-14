# shaharlab-behavioral-data-analysis

Behavioral data analysis in R for the Shahar Lab (Tel Aviv University).
Bundles the lab's brms Bayesian-regression workflow, data preprocessing,
visualization standards, project scaffolding, and R code walkthroughs — plus Malka,
the orchestrator skill that specifies, executes, and checks each job.

> Installation is documented once at the [repo root README](../README.md).
> This file lists what the plugin provides.

## Skills

There are only two real skills in this plugin — `malka` and `code-walkthrough`. Invoke
with `/shaharlab-behavioral-data-analysis:<skill>`, or just describe the task and Claude
routes to the right one.

| Skill              | Use it when you…                                                                                                                                                                                                                                       |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `malka`            | have any lab analysis task — create, revise, extend, or repair. She interviews you, you approve one card, then she writes the code. The reliable entry point. |
| `code-walkthrough` | want R code explained statement by statement to learn or verify it — always runs in the main thread, never as a subagent.                                                                                                                              |

## How Malka works

Three steps.

1. **Specify and confirm** — one Job Card per job, Clarify, then one Summary Card for approval.
2. **Execute** — Malka handles one job directly; multiple jobs use one Code Writer per Job Card, with dependent jobs waiting for their inputs.
3. **Hand back** — what to run and what to look at. Malka does not run R.

A new formula or a new cutoff is **new science**: that is a new interview.

## Knowledge

`SKILL.md` is the spine: each step carries its goal, the reference file to read, and nothing that reference already states.

Execution behavior lives in `05-executing-job.md`, shared by Malka and the Code Writer.
A Job Card carries only what varies from job to job.

`coding-knowledge/` is not a skills folder — nothing under it has a `SKILL.md`, triggers on its
own, or runs independently. Each numbered subfolder holds its templates and craft, plus `context.md`
or `rules.md` where present,
for one or two main-folders, which Malka points the subagent at through the card. Each covering
folder's craft files are listed in `02-knowledge-index.md`. Each file is one heading
and one box of three bullets — Path, What it covers, CHECKS. Malka copies matching
Paths onto each Job Card's `ROUTED READS` and copies the actual CHECKS bullets onto `CHECKS`.

| Path                                 | Malka reads it for…                                                                                                                                                                                                                                                                                                     |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `coding-knowledge/00-constitution/`  | the project rules and R coding rules every build reads                                                                                                                                                                                                                                                                  |
| `coding-knowledge/01-preprocessing/` | cleaning, reshaping, excluding, examining, or reporting behavioral data — `template-main.md`, `template-summary.md`, and stage-specific report folders under `output/`, plus one `how-to-` file per script kind |
| `coding-knowledge/02-analysis/`      | structure, templates, rules, and `smart_clone.md` for empirical-analysis job-folders |
| `coding-knowledge/regression/`       | Bayesian/brms sampling, priors, and diagnostics |
| `coding-knowledge/visualization/`    | color, panel-tagging, plot-type, and export standards |
| `coding-knowledge/descriptives/`     | participant counts, demographics tables, questionnaire distributions |
| `coding-knowledge/03-models/`        | writing a `models/` definition as a generating `.R` and fitting `.stan` pair                                                                                                                                                                                                                                            |
| `coding-knowledge/04-simulations/`   | parameter-recovery and other studies on model-generated data — building the pipeline and reading its recovery                                                                                                                                                                                                           |

Each covering folder holds the templates that build its job-folder, any applicable `context.md` or
`rules.md`, and the craft the subagent reads while it works. `00-constitution/` matches no
main-folder, so it holds the two rules files alone.

`01-preprocessing/`, `03-models/`, and `04-simulations/` keep craft in `references/`,
with worked examples in `assets/`. Analysis craft is grouped at the coding-knowledge root
under `regression/`, `visualization/`, and `descriptives/`.

Templates and any applicable `context.md` or `rules.md` are standing reads for a job landing in that
main-folder. Craft files are routed per card from `02-knowledge-index.md`, which carries every one of
their paths.

Craft is routed by path, not owned by one main-folder: an `analysis/` job and a `simulation/` job
both route into `visualization/` for figures, and a `simulation/` job fitting brms on
generated data routes into `regression/`.

## Agents

One subagent type is available once the plugin is loaded:

- **`code-writer`** — executes one approved Job Card when the request contains multiple jobs.

There is no orchestrator agent — the orchestrator is the `malka` skill itself, so it runs in the main conversation thread where the user actually is (a subagent has no one to interview or wait on for approval).

Whether the craft is right stays with the Writer, which read the standards. Nothing here runs the code, so a job with real stakes is still worth reading before it ships.

## How to invoke

The plugin ships no slash commands of its own — skills and agents are the only
entry points.

- **`/shaharlab-behavioral-data-analysis:malka`** — the reliable way in for any build task. Explicitly dispatches Malka.
- **Plain language** — describe the task ("clean my behavioral data," "fit a brms model on choice ~ reward"). Claude routes to Malka based on her `description`. This depends on the model recognizing the match, so it isn't guaranteed the way naming the skill is.
- **`code-walkthrough` directly** — `/shaharlab-behavioral-data-analysis:code-walkthrough` to go straight to it without Malka.

Lab rules (folder topology, R style) are **not** injected automatically into every session — the executor reads them on demand only when a lab task is in progress. This keeps unrelated sessions free of lab-specific context.

## Terms

See [`TERMS.md`](TERMS.md) for the vocabulary of the Malka workflow — Summary Card, Job Card, Handback Card,
job, dispatch, fit, `ASSUMED`, `BLOCKED`, and the rest.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
