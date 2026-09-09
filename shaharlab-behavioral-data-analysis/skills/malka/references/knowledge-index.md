# Coding Knowledge — Index

The file-by-file map of `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/`. Malka reads it at Step 3, once per job in her plan, to fill the Writer Card's `ROUTED READS`; the Writer reads it only to locate a path its card already named.

Paths below are relative to `coding-knowledge/`. One domain per top-level project part, each holding its own `rules.md`, the templates that build that folder, and its craft under `references/` and `assets/`.

**Two kinds of read, and the difference decides what goes on the card.** A domain's `rules.md` and the templates beside it are the Writer's standing read for any job landing in that part, delivered by the card's `FOLDER` slot rather than listed as a path. Every `references/…` and `assets/…` row is a `ROUTED READS` candidate, put on the card one at a time.

**This table routes the Writer alone.** The Code Reviewer takes the two constitution files and each folder's `rules.md` on its own standing instruction, reads the approved specification and the files the run produced, and takes no routed craft reads at all — its card has no `ROUTED READS` slot, per `references/reviewer-card.md`. That absence is what holds it to one spawn per run. A `references/` path appearing on a Reviewer Card, or a who-reads-it column appearing in this file, has rebuilt the wider reviewing role that `45d2c1b` removed.

## How to route a job

1. **Name the folder.** The card's `FOLDER` slot carries the one folder the dispatch works in. That slot is what delivers the standing reads: the Writer reads the two constitution files and the `rules.md` for that folder's part on every job, on the standing instruction in its own agent file. Fill the slot and leave those off `ROUTED READS`. Work touching two folders is two jobs, each routed for its own folder — see `planning.md`, which also places them in runs.
2. **Add the `references/` and `assets/` rows for each stage the job involves**, working from the trigger table at the head of that domain's section.

Route the stages the job involves and nothing beyond them. `assets/` rows are examples the Writer imitates — route one for each deliverable the job produces.

**Craft is routed across domains where a job needs it.** A domain owns its craft, and a job in another part routes into it rather than carrying a copy. Two routes cross regularly: `02-analysis/references/visualization/` serves the figures of both an `analysis/` and a `simulation/` job, and `02-analysis/references/regression/` serves a `simulation/` job that fits brms on generated data. The `FOLDER` slot still names the one folder the dispatch writes into.

**"Worked routes" at the end of this file resolves the common jobs end to end.** Start from the closest one and adjust; it is also the fastest way for a human to check that a route came out right.

## 00 · Constitution — every job

Governs no single folder type, so it holds the two rules files alone and both reach the Writer on every job.

| Path | What it governs |
|---|---|
| `00-constitution/project-rules.md` | §0 the project tree, the scaffolding routing table, naming; then the one-model-one-folder paradigm, the Artifacts/Orchestration/Boundaries rules, the canonical set, the `main.R` path mandate, and §5 the reserved set of values that come from the researcher |
| `00-constitution/coding-rules.md` | R style: base pipe, naming, headers, `main.R` vs sourced-script split, preferred libraries, calling external tools |

**Malka reads `project-rules.md` §0 and §5 as well**, at Step 1 via `interview.md`, to place the work and to leave the interview with every reserved value set. It reaches her on her own instruction rather than on a card — restructuring §0 changes what she plans from, so check `SKILL.md` Step 2 alongside this row.

## The four folder-type domains — routed by where the work lands

Each domain's `rules.md` states that part's structure, how it is handled, and how its files are named; the templates that build it sit beside it. These arrive with `FOLDER`, so they stay off `ROUTED READS`.

| Work lands in | Domain | `rules.md` + templates beside it |
|---|---|---|
| `preprocessing/`, `data/` | `01-preprocessing/` | `rules.md`, `template_main.R` |
| `analysis/[NAME]/` | `02-analysis/` | `rules.md`, `template_main.R`, `template_summary.md` |
| `models/[NAME]/` | `03-models/` | `rules.md`, `template_model.R`, `template_model.stan` |
| `simulation/[NAME]/` | `04-simulations/` | `rules.md`, `template_main.R`, `template_summary.md` |

**Malka reads `template_summary.md` as well**, at Step 4 via `references/folder-summary.md`, from the domain of the folder just scaffolded — `02-analysis/` or `04-simulations/` — for the shape of the `summary.md` she writes herself from the approved specification. It reaches her on her own instruction rather than on a card, so leave it off `ROUTED READS`: the Writer scaffolds `code/`, `artifacts/`, `output/`, and `main.R`, and the notebook is hers.

## 01 · Preprocessing — cleaning, excluding, examining, reporting

`preprocessing/code/` holds three kinds of script, named by prefix — `converting_` moves data
between stages, `examining_` inspects one stage, `summary_` reports for the researcher and the
manuscript. **The prefixes themselves are a binding read, not a routed one:** they are stated in
`01-preprocessing/rules.md`, which the Writer already reads on any job landing in
`preprocessing/`. This domain holds one `how-to-` file per script kind, so route by which
scripts the job writes.

| The job writes | Route the Writer to |
|---|---|
| `converting_data_collected_to_raw.R` | `how-to-convert-collected-to-raw.md` |
| `converting_data_raw_to_processed.R` | `how-to-convert-raw-to-processed.md` |
| any `examining_` script | `how-to-examine.md` |
| `summary_exclusions.R` or `summary_manuscript_paragraph.R` | `how-to-summarise-exclusions.md` |
| any `converting_` script | `conversion-and-filter-traps.md`, alongside the `how-to-` file above |

A first full pipeline writes all six scripts, so it routes all four `how-to-` files plus the traps.
A job that only revises the exclusions routes the raw→processed file, the traps, and the summarise
file, and nothing else.

**Then check for leaving the window.** `handling-leaving-window.md` is a measure that threads through
four of the six scripts rather than belonging to one, so it is routed on the data, not on the script.
Add it to the card when any of these holds:

- the study ran in a browser — Pavlovia, Prolific, MTurk, or any online sample
- `data/collected/` carries a `window_status` / `window_left_ms` column, or rows marked
  `event_type == "attention_event"` (the Exploration Pass sees this)
- the user mentions leaving the window, tab switching, losing focus, fullscreen exits, or being away
  from the screen

One exit is a *sequence* of `left` trials, not one flagged trial — the file states the count this way
because that is the failure this measure invites.

Route it on an in-person or non-browser study only if the user asks — there is no `window_status`
column to count, and the file says to leave the criterion out rather than substitute for it.

**A figure backing an exclusion routes across.** Where the job plots a distribution behind a cutoff,
add the plot-type row from `02-analysis/references/visualization/` — the `examining_` and `summary_`
reports are Markdown, so most pipelines need none.

| Path | What it covers |
|---|---|
| `01-preprocessing/references/how-to-convert-collected-to-raw.md` | `converting_data_collected_to_raw.R`: restructure, type every column, drop what was never data, save `data/raw/`; the type-coercion patterns |
| `01-preprocessing/references/how-to-convert-raw-to-processed.md` | `converting_data_raw_to_processed.R`: the two-phase exclusion pattern, one named surviving dataset per criterion, save `data/processed/` |
| `01-preprocessing/references/how-to-examine.md` | The `examining_` scripts: the five description blocks, report assembly, and how the raw and processed reports line up |
| `01-preprocessing/references/how-to-summarise-exclusions.md` | The two `summary_` scripts: the per-phase exclusion cascade tables and the manuscript "Data treatment" paragraph |
| `01-preprocessing/references/conversion-and-filter-traps.md` | The R traps a pipeline invites: type coercion, `%in%` versus chained `!=`, `scale()`/`cut()`, and the counts to print so a silent loss is visible |
| `01-preprocessing/references/handling-leaving-window.md` | Online studies: the `window_status` column, counting one exit per *sequence* of `left` trials, the `window_exit_max` cutoff, and the participant-phase exclusion — routed on the data, per the note above |
| `01-preprocessing/references/exploration.md` | What the Data Explorer profiles and how it reports — **its own standing read, never routed.** See worked route E |
| `01-preprocessing/assets/example-examining-report.md` | Worked mockup of an `examining_` report |
| `01-preprocessing/assets/example-summary-exclusions.md` | Worked mockup of `summary_exclusions.md` |

**`template_main.R` is not a `references/` row.** The `preprocessing/main.R` boilerplate sits beside
the folder rules at `01-preprocessing/template_main.R` and arrives with `FOLDER`, so rules and
boilerplate stay one standing read.

## 02 · Analysis — fitting, describing, plotting, cloning

`analysis/` holds empirical analyses of real data, so this domain's craft covers what such a folder
produces. Three of its four `references/` groups are also routed by jobs in other parts, per the
cross-domain note above.

### Regression — fitting or checking a brms model

A brms regression is an empirical workflow, so its `FOLDER` slot names a folder under `analysis/` — `models/` holds mechanistic `.stan` definitions, per `project-rules.md` §2.III. A regression fit to model-generated data lands under `simulation/` on the same rule and routes these same two files.

| The job | Route to |
|---|---|
| fits a brms model | `regression/01_sampling_and_priors.md` |
| writes or checks the post-fit diagnostics | `regression/02_diagnostics.md` |

| Path | What it covers |
|---|---|
| `02-analysis/references/regression/01_sampling_and_priors.md` | The `brm()` workflow: load by `data_path`, translate approved priors, sampling settings, save the `.rds` |
| `02-analysis/references/regression/02_diagnostics.md` | The post-fit script: ess/rhat table, trankplot, pairs plot, reported without interpretation |

### Visualization — creating or revising a figure

Route on what the user asked for, then add every standard that applies. A `simulation/` or `preprocessing/` job needing a figure routes these same rows.

| Request | Plot rows to add |
|---|---|
| posterior, credible interval, effect estimate | `plot-posterior.md` (+ `plot-posterior.png`) |
| scatter, x vs y, correlation, parameter recovery | `plot-scatter.md` |
| dot histogram, distribution of one variable, show individual observations | `plot-dot-histogram.md` |
| multiple panels, composite | the panel-tagging standard |

| Path | What it covers |
|---|---|
| `02-analysis/references/visualization/plot-types/plot-posterior.md` | ggdist rules: wide-and-short canvas, the three x-axis cases, zero/median lines, the 0.90 CI, annotation; runnable code inline under `## Examples`, no separate `example.R` |
| `02-analysis/references/visualization/plot-types/plot-posterior.png` | The rendered reference — awaiting regeneration from that file's Example 3 |
| `02-analysis/references/visualization/plot-types/plot-scatter.md` | ggplot2 rules: square panel, shared limits and the diagonal on a same-scale pair, trend line, Pearson annotation, mandatory color; runnable code inline under `## Examples`, no separate `example.R` |
| `02-analysis/references/visualization/plot-types/plot-dot-histogram.md` | ggdist `geom_dots()` rules: full-range x-axis, default binning, rebuilt count y-axis; runnable code inline under `## Examples`, no separate `example.R` |
| `02-analysis/references/visualization/standards/COLOR_STANDARD.md` | When color is required, which palettes, what to avoid — route whenever the plot uses color |
| `02-analysis/references/visualization/standards/EXPORT_STANDARD.md` | Dual PDF+PNG export, canvas, naming — route always |
| `02-analysis/references/visualization/standards/PANEL_TAGGING_STANDARD.md` | patchwork assembly and A/B/C tags — route for 2+ panels |

### Descriptives — reporting the sample and its measures

| The job | Route to |
|---|---|
| reports participant counts, demographics, or questionnaire distributions | `descriptives/how-to-report-descriptives.md` |

| Path | What it covers |
|---|---|
| `02-analysis/references/descriptives/how-to-report-descriptives.md` | The descriptive folder's tables and figures: participant counts by group, the demographics table, per-measure distributions, and the values the researcher supplies |

### Cloning a folder

Building a new folder routes through `project-rules.md` §0 and the domain's `rules.md`, both of which arrive with `FOLDER`. This row covers only what those do not.

| The job | Route to |
|---|---|
| starts a new folder | nothing — §0 and the domain's `rules.md` already carry the structure and its templates |
| duplicates an `analysis/`/`simulation/` folder | `smart_clone.md` |
| repairs a folder against the canonical set | nothing — the domain's `rules.md` states the canonical set |

| Path | What it covers |
|---|---|
| `02-analysis/references/smart_clone.md` | Duplicating an `analysis/`/`simulation/` folder: what to copy, what to wipe, which paths to re-point |

## 03 · Models — writing the `.R`/`.stan` pair

Route this domain whenever the job writes or revises a `models/[model_name]/` definition. `FOLDER`
names a folder under `models/`, per `project-rules.md` §2.III — fitting and evaluating that definition
happen in `analysis/` or `simulation/` and are a different job.

| The job | Route the Writer to |
|---|---|
| writes or revises a `models/` definition | `how-to-write-a-model-definition.md` |
| writes one that a recovery study will generate from and fit back | that file, plus `04-simulations/references/how-to-build-a-recovery-pipeline.md` for the three agreements the pair has to satisfy |

| Path | What it covers |
|---|---|
| `03-models/references/how-to-write-a-model-definition.md` | The generating `.R` and fitting `.stan` as one pair: what each block holds, non-centred varying effects, the scale and choice-rule agreements between the two files, and what changing a definition does to the folders that load it |

## 04 · Simulations — generating from known parameters and fitting back

Route this domain whenever the job generates data from parameters it chose and fits the model back —
whatever the model family is (RL, regression, IRT/GRM, Bradley-Terry). `FOLDER` names a folder under
`simulation/`, per `project-rules.md` §0. A model-comparison study — generate under one model, fit
several — runs the same pipeline and routes the same two files.

| The job | Route the Writer to |
|---|---|
| builds or extends a recovery pipeline | `how-to-build-a-recovery-pipeline.md` and `assets/example_main.R` |
| writes or revises the recovery comparison and its figure | `how-to-read-recovery.md` |

A first recovery study routes all three. Add the `02-analysis/references/visualization/` rows the
figures call for — `plot-scatter.md` for the recovery panels, `plot-posterior.md` for the population
panels, `plot-dot-histogram.md` for the true-parameter distributions, plus the panel-tagging and
export standards. A study that fits brms rather than raw Stan also routes
`02-analysis/references/regression/01_sampling_and_priors.md`.

| Path | What it covers |
|---|---|
| `04-simulations/references/how-to-build-a-recovery-pipeline.md` | The three pipeline stages and their scripts, the model-family mapping table, the three generating-versus-fitting agreements, and the artifacts each stage saves |
| `04-simulations/references/how-to-read-recovery.md` | The six recovery checks in order, the criteria the user supplies, and what a poor result points at |
| `04-simulations/assets/example_main.R` | The worked recovery `main.R` — three stage headers, ten numbered scripts |

## Worked routes

Seven common jobs, routed end to end. Each shows what the card actually carries, so a route can be
checked against a worked answer instead of re-derived from the steps. Take the closest one and adjust
for what the job differs on.

The three reads that arrive with `FOLDER` are the same in every route below —
`00-constitution/project-rules.md`, `00-constitution/coding-rules.md`, and the `rules.md` of the
domain for that folder's part — so the counts read "3 + n".

### A · First preprocessing pipeline, study run online

`FOLDER: preprocessing/` (which covers the `data/` stages it builds). Writes all six pipeline scripts, so all four `how-to-` files route.
The data carries a `window_status` column, which puts `handling-leaving-window.md` on the card. Both
report deliverables are produced, so both `assets/` examples route.

| `ROUTED READS` | Reads |
|---|---|
| `01-preprocessing/references/how-to-convert-collected-to-raw.md`, `how-to-convert-raw-to-processed.md`, `how-to-examine.md`, `how-to-summarise-exclusions.md`, `conversion-and-filter-traps.md`, `handling-leaving-window.md`, `01-preprocessing/assets/example-examining-report.md`, `example-summary-exclusions.md` | 3 + 8 |

### B · Revising the exclusion criteria on an existing pipeline, study run in person

`FOLDER: preprocessing/`. Only the exclusions and the summary that quotes them change, so the
collected→raw and `examining_` files stay off the card. `summary_exclusions.md` is regenerated, so
its example routes and the examining example does not. In person means no `window_status` column to
count, so `handling-leaving-window.md` routes only if the user asks for it.

| `ROUTED READS` | Reads |
|---|---|
| `01-preprocessing/references/how-to-convert-raw-to-processed.md`, `conversion-and-filter-traps.md`, `how-to-summarise-exclusions.md`, `01-preprocessing/assets/example-summary-exclusions.md` | 3 + 4 |

### C · brms regression in a new analysis folder, with a posterior plot

`FOLDER: analysis/[analysis_name]/` — an empirical fit lands under `analysis/`, per the regression
note. The folder is new, so its structure and templates arrive with `FOLDER`. The fit, the
diagnostics, and the plot all land in this one folder, so the job is one dispatch.

| `ROUTED READS` | Reads |
|---|---|
| `02-analysis/references/regression/01_sampling_and_priors.md`, `02_diagnostics.md`, `02-analysis/references/visualization/plot-types/plot-posterior.md`, `plot-posterior.png`, `02-analysis/references/visualization/standards/EXPORT_STANDARD.md`, and `COLOR_STANDARD.md` when the figure uses color | 3 + 5 or 6 |

### D · Revising an existing two-panel scatter figure

`FOLDER: analysis/[analysis_name]/`. The folder already exists, so no clone row routes. Two panels put the
panel-tagging standard on the card, and the scatter instructions make color mandatory, so
`COLOR_STANDARD.md` routes as well.

| `ROUTED READS` | Reads |
|---|---|
| `02-analysis/references/visualization/plot-types/plot-scatter.md`, `02-analysis/references/visualization/standards/COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md` | 3 + 4 |

### E · The Exploration Pass, dispatched at Step 1

**Not a Writer dispatch and not routed from this index.** The Exploration Pass goes to the **Data
Explorer**, a separate agent that runs R over `data/collected/` and returns a profile rather than
writing anything. `01-preprocessing/references/exploration.md` is its own standing read, stated in
`agents/data-explorer.md`, so it appears in no `ROUTED READS`. Its card carries the data path and the
study context — see `interview.md`.

| `ROUTED READS` | Reads |
|---|---|
| none — the Data Explorer routes nothing | 0 |

### F · First parameter-recovery study for a model already in `models/`

`FOLDER: simulation/[study_name]/` — generated data lands under `simulation/`, per `project-rules.md`
§0. The folder is new, so its structure and templates arrive with `FOLDER`. The whole pipeline is one
job however many fits it runs, per `04-simulations/rules.md`. Both `04-simulations` references route
plus the worked `main.R`, and the four-panel figure puts three plot types and both assembly standards
on the card — routed across into `02-analysis/references/visualization/`, which owns them.

| `ROUTED READS` | Reads |
|---|---|
| `04-simulations/references/how-to-build-a-recovery-pipeline.md`, `how-to-read-recovery.md`, `04-simulations/assets/example_main.R`, `02-analysis/references/visualization/plot-types/plot-scatter.md`, `plot-posterior.md`, `plot-dot-histogram.md`, `02-analysis/references/visualization/standards/COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md` | 3 + 9 |

The `models/` definition is a read, not a write: `PROJECT STATE` names its path and the Writer sources
it. When that definition does not exist yet, it is a `models/` job in an earlier run — see
`planning.md`, and route it as G below.

### G · Writing the `models/` definition a recovery study needs

`FOLDER: models/[model_name]/`. The folder type carries no canonical set — two files and nothing else,
per `03-models/rules.md`, which arrives with `FOLDER` along with its two templates. The recovery reference
routes as well, because the pair has to satisfy its three agreements for the study in the next run to
mean anything.

| `ROUTED READS` | Reads |
|---|---|
| `03-models/references/how-to-write-a-model-definition.md`, `04-simulations/references/how-to-build-a-recovery-pipeline.md` | 3 + 2 |

## Maintaining this index

Every row is one file on disk, and every file on disk is one row. Adding, renaming, or removing a file under `coding-knowledge/` changes its row here in the same edit. The **What it covers** column names the file's subject in one line; the file itself is the only place its content lives.

Two things move together with a row: its section's trigger table, so the new file has a stated
condition that routes it; and any **Worked routes** entry whose job now touches it, so the worked
answers stay true. A route that disagrees with its worked example is the signal that one of the two is
stale.

**A routed file states its own preconditions.** Every variable it expects to be defined and every
package it calls are named in the file itself, since the card no longer carries a summary of them. A
file that assumes `patchwork` or a `data_path` without saying so produces code that fails in the
user's session, and neither agent can catch it.
