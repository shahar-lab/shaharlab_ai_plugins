# shaharlab-behavioral-data-analysis

Behavioral data analysis in R for the Shahar Lab (Tel Aviv University).
Bundles the lab's brms Bayesian-regression workflow, data preprocessing,
visualization standards, project scaffolding, and R code walkthroughs — plus Malka,
the orchestrator skill that interviews you and directs the subagents that build and check the work.

> Installation is documented once at the [repo root README](../README.md).
> This file lists what the plugin provides.

## Skills

There are only two real skills in this plugin — `malka` and `code-walkthrough`. Invoke
with `/shaharlab-behavioral-data-analysis:<skill>`, or just describe the task and Claude
routes to the right one.

| Skill              | Use it when you…                                                                                                                                                                                                                                       |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `malka`            | have any lab analysis task — create, revise, extend, or repair. She interviews you, you approve one card, then she writes and checks the code. The reliable entry point. |
| `code-walkthrough` | want R code explained statement by statement to learn or verify it — always runs in the main thread, never as a subagent.                                                                                                                              |

## How Malka works

Three steps.

1. **Interview** — Talk, Plan, Critique, Confirm. You approve one Summary Card. Nothing is built until you say yes.
2. **Dispatch subagents** — build one Code-Writer Card per ready job, spawn those Writers, then the Code Reviewer. Later WAVEs wait until earlier WAVEs are done.
3. **Hand back** — what to run and what to look at. Malka does not run R.

A new formula or a new cutoff is **new science**: that is a new interview.

## Knowledge

`SKILL.md` is the spine: each step carries its goal, the reference file to read, and nothing that reference already states.

How the subagent *behaves* — the reads it always takes, how it reports, what it returns — lives in
its own agent file rather than in the card, so a card carries only what varies from job to job.

`coding-knowledge/` is not a skills folder — nothing under it has a `SKILL.md`, triggers on its
own, or runs independently. Each numbered subfolder holds the `context.md`, templates, and craft
for one or two main-folders, which Malka points the subagent at through the card. Each covering
folder also holds a short `pre-deploy-checks.md` list; optional stages
(`regression/`, `visualization/`, `descriptives/`) hold their own. Critique opens only the
pre-deploy-checks this request needs, to finish that job's specification.

| Path                                 | Malka reads it for…                                                                                                                                                                                                                                                                                                     |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `coding-knowledge/00-constitution/`  | the project rules and R coding rules every build reads                                                                                                                                                                                                                                                                  |
| `coding-knowledge/01-preprocessing/` | cleaning, reshaping, excluding, examining, or reporting behavioral data — one `how-to-` file per script kind (`converting_`, `examining_`, `summary_`), building `data/raw` + `data/processed`, the Markdown examination and exclusion reports, a data-validation HTML per tidy table, and a manuscript-ready exclusions paragraph |
| `coding-knowledge/02-analysis/`      | empirical analyses of real data. Holds `regression/` (Bayesian/brms sampling, priors, diagnostics), `visualization/` (color, panel-tagging, plot-type, and export standards), `descriptives/` (participant counts, demographics tables, questionnaire distributions), and `smart_clone.md` for duplicating a job-folder |
| `coding-knowledge/03-models/`        | writing a `models/` definition as a generating `.R` and fitting `.stan` pair                                                                                                                                                                                                                                            |
| `coding-knowledge/04-simulations/`   | parameter-recovery and other studies on model-generated data — building the pipeline and reading its recovery                                                                                                                                                                                                           |

Every covering folder holds one `context.md` stating the structure and file naming of the
main-folder it documents, the templates that build that job-folder beside it, and the craft the
subagent reads while it works. `00-constitution/` matches no main-folder, so it holds the two
rules files alone.

How the craft is arranged follows how much of it there is. `01-preprocessing/`, `03-models/`,
and `04-simulations/` keep theirs in a `references/` folder, with worked examples in `assets/`.
`02-analysis/` holds enough to group by kind instead, so `regression/`, `visualization/`, and
`descriptives/` sit directly beside `smart_clone.md`.

`context.md` and the templates are the standing read for any job landing in that main-folder. The
craft files are routed per card, from `knowledge-index.md`, which carries every one of their paths.

Craft is routed by path, not owned by one main-folder: an `analysis/` job and a `simulation/` job
both route into `02-analysis/visualization/` for figures, and a `simulation/` job fitting brms on
generated data routes into `02-analysis/regression/`.

## Agents

Three subagent types, available once the plugin is loaded — dispatched by `malka`, not
invoked directly:

- **`data-explorer`** — profiles a `data/` stage during Step 1 after Plan by running R over it (`data/collected/` for a preprocessing job, `data/processed/` for an analysis job in WAVE 1). The only agent here with a shell, and it writes nothing.
- **`code-writer`** — prepares the job-folder, writes the code from the `coding-knowledge/` files Malka named on the Code-Writer Card, then checks its own work against the same rules and the approved specification before returning. One spawn per job.
- **`code-reviewer`** — a general after-write check: reads the finished files against the Code-Writer Card and the constitution coding rules, and reports what the code actually sets, plus any value that contradicts the card, any product that never reached disk, and any threshold the Writer chose that was the user's to set. Read-only, one spawn per job, and it opens no main-folder craft — the library the Writer reads stays out of its context.

There is no orchestrator agent — the orchestrator is the `malka` skill itself, so it runs in the main conversation thread where the user actually is (a subagent has no one to interview or wait on for approval).

The Reviewer checks that the code matches the Code-Writer Card and the coding rules; whether the craft is right stays with the Writer, which read the standards. Nothing here runs the code, so a job with real stakes is still worth reading before it ships.

## How to invoke

The plugin ships no slash commands of its own — skills and agents are the only
entry points.

- **`/shaharlab-behavioral-data-analysis:malka`** — the reliable way in for any build task. Explicitly dispatches Malka.
- **Plain language** — describe the task ("clean my behavioral data," "fit a brms model on choice ~ reward"). Claude routes to Malka based on her `description`. This depends on the model recognizing the match, so it isn't guaranteed the way naming the skill is.
- **`code-walkthrough` directly** — `/shaharlab-behavioral-data-analysis:code-walkthrough` to go straight to it without Malka.

Lab rules (folder topology, R style) are **not** injected automatically into every session — the code-writer reads them on demand from `coding-knowledge/00-constitution/`, only when a lab task is actually in progress. This keeps unrelated sessions free of lab-specific context.

## Terms

See [`TERMS.md`](TERMS.md) for the vocabulary of the Malka workflow — Summary Card, Plan Card, Code-Writer Card,
job, dispatch, fit, `ASSUMED`, `BLOCKED`, and the rest.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
