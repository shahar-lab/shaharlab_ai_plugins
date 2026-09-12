# Coding Knowledge — Index

Opened at Dispatch when filling a Code-Writer Card's `ROUTED READS`. Paths below are relative to `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/`. The Writer also opens this file when a deliverable has no craft on its card, and names every such file under `ADDED READS`.

Constitution files, the covering folder's `context.md`, its `rules.md` when it exists, and its templates arrive with `FOLDER`. Leave them off this list. `pre-deploy-checks.md` is not craft. `exploration.md` is the Data Explorer's standing read, never routed.

## How to route

1. Name `FOLDER`. That delivers the standing reads.
2. Add every trigger-matching craft row for the stages this job involves.
3. Route by path: a `simulation/` job still takes `02-analysis/visualization/` when it plots, and `02-analysis/regression/` when it fits brms on generated data.
4. Route an `assets/` row only for a deliverable this job writes.

Every file under `coding-knowledge/` that is craft is one row here, and every row is one file.

## 01 · Preprocessing

| The job writes | Route to |
|---|---|
| `converting_data_collected_to_raw.R` | `how-to-convert-collected-to-raw.md` |
| `converting_data_raw_to_processed.R` | `how-to-convert-raw-to-processed.md` |
| any `examining_` script | `how-to-examine.md` |
| `summary_exclusions.R` or `summary_manuscript_paragraph.R` | `how-to-summarise-exclusions.md` |
| any `converting_` script | `conversion-and-filter-traps.md`, alongside the `how-to-` file above |
| a data-validation HTML | `how-to-build-data-validation.md` |
| a figure of a cutoff | the matching `02-analysis/visualization/` plot-type |

`handling-leaving-window.md` — online / `window_status` column / the user mentions leaving the window. The file states when.

| Path | What it covers |
|---|---|
| `01-preprocessing/references/how-to-convert-collected-to-raw.md` | `converting_data_collected_to_raw.R`: restructure, type every column, drop what was never data, save `data/raw/` |
| `01-preprocessing/references/how-to-convert-raw-to-processed.md` | `converting_data_raw_to_processed.R`: two-phase exclusions, one named surviving dataset per criterion, save `data/processed/` |
| `01-preprocessing/references/how-to-examine.md` | The `examining_` scripts: five description blocks, report assembly |
| `01-preprocessing/references/how-to-summarise-exclusions.md` | The two `summary_` scripts: cascade tables and the manuscript paragraph |
| `01-preprocessing/references/how-to-build-data-validation.md` | Data-validation HTML per tidy table, class and domain meta-rows |
| `01-preprocessing/references/conversion-and-filter-traps.md` | Type coercion, `%in%` versus chained `!=`, `scale()`/`cut()`, counts to print |
| `01-preprocessing/references/handling-leaving-window.md` | `window_status`, one exit per sequence of `left` trials, `window_exit_max` |
| `01-preprocessing/references/exploration.md` | Data Explorer profile — standing read, never routed |
| `01-preprocessing/assets/example-examining-report.md` | Mockup of an `examining_` report |
| `01-preprocessing/assets/example-summary-exclusions.md` | Mockup of `summary_exclusions.md` |
| `01-preprocessing/assets/example-data-validation.html` | Mockup of a data-validation HTML |

## 02 · Analysis

Route by path, not by where the job lands. A `simulation/` or `preprocessing/` job that needs a figure or a brms fit takes these same rows.

### Regression

| The job | Route to |
|---|---|
| fits a brms model | `regression/01_sampling_and_priors.md` |
| writes or checks the post-fit diagnostics | `regression/02_diagnostics.md` |

| Path | What it covers |
|---|---|
| `02-analysis/regression/01_sampling_and_priors.md` | `brm()` workflow: load by `data_path`, approved priors, sampling, save the `.rds` |
| `02-analysis/regression/02_diagnostics.md` | ess/rhat table, trankplot, pairs plot, reported without interpretation |

### Visualization

| Request | Route to |
|---|---|
| posterior, credible interval, effect estimate | `plot-posterior.md` (+ `plot-posterior.png`) |
| scatter, x vs y, correlation, parameter recovery | `plot-scatter.md` |
| dot histogram, distribution of one variable | `plot-dot-histogram.md` |
| 2+ panels | `PANEL_TAGGING_STANDARD.md` |
| any figure | `EXPORT_STANDARD.md`; `COLOR_STANDARD.md` when the plot uses color |

| Path | What it covers |
|---|---|
| `02-analysis/visualization/plot-types/plot-posterior.md` | ggdist: wide-and-short canvas, three x-axis cases, 0.90 CI |
| `02-analysis/visualization/plot-types/plot-posterior.png` | Rendered reference |
| `02-analysis/visualization/plot-types/plot-scatter.md` | ggplot2: square panel, shared limits, diagonal, Pearson, mandatory color |
| `02-analysis/visualization/plot-types/plot-dot-histogram.md` | ggdist `geom_dots()`: full-range x-axis, rebuilt count y-axis |
| `02-analysis/visualization/standards/COLOR_STANDARD.md` | When color is required, which palettes |
| `02-analysis/visualization/standards/EXPORT_STANDARD.md` | Dual PDF+PNG export, canvas, naming |
| `02-analysis/visualization/standards/PANEL_TAGGING_STANDARD.md` | patchwork assembly and A/B/C tags |

### Descriptives

| The job | Route to |
|---|---|
| participant counts, demographics, or questionnaire distributions | `descriptives/how-to-report-descriptives.md` |

| Path | What it covers |
|---|---|
| `02-analysis/descriptives/how-to-report-descriptives.md` | Sample tables and per-measure distributions |

### Cloning

| The job | Route to |
|---|---|
| starts a new job-folder | nothing — `FOLDER` delivers structure and templates |
| duplicates an `analysis/`/`simulation/` job-folder | `smart_clone.md` |
| repairs a job-folder against the canonical set | nothing — that covering folder's `context.md` |

| Path | What it covers |
|---|---|
| `02-analysis/smart_clone.md` | Duplicating a job-folder: what to copy, what to wipe, which paths to re-point |

## 03 · Models

| The job | Route to |
|---|---|
| writes or revises a `models/` definition | `how-to-write-a-model-definition.md` |
| writes one a recovery study will generate from and fit back | that file, plus `04-simulations/references/how-to-build-a-recovery-pipeline.md` |

| Path | What it covers |
|---|---|
| `03-models/references/how-to-write-a-model-definition.md` | Generating `.R` and fitting `.stan` as one pair |

## 04 · Simulations

| The job | Route to |
|---|---|
| builds or extends a recovery pipeline | `how-to-build-a-recovery-pipeline.md` and `assets/example_main.R` |
| writes or revises the recovery comparison and its figure | `how-to-read-recovery.md` |

A first recovery study routes all three, plus the `02-analysis/visualization/` rows its figures call for. A study that fits brms also routes `02-analysis/regression/01_sampling_and_priors.md`.

| Path | What it covers |
|---|---|
| `04-simulations/references/how-to-build-a-recovery-pipeline.md` | Three pipeline stages, model-family mapping, generating-versus-fitting agreements |
| `04-simulations/references/how-to-read-recovery.md` | Six recovery checks in order |
| `04-simulations/assets/example_main.R` | Worked recovery `main.R` |

## Common jobs

Standing reads (`FOLDER`) are the same in every row. Extra paths only:

| Job | Extra paths |
|---|---|
| First preprocessing, study online | all four `how-to-` script files, `how-to-build-data-validation.md`, `conversion-and-filter-traps.md`, `handling-leaving-window.md`, three `01-preprocessing/assets/` examples |
| Revising exclusions, study in person | `how-to-convert-raw-to-processed.md`, `conversion-and-filter-traps.md`, `how-to-summarise-exclusions.md`, `example-summary-exclusions.md` |
| New brms folder with a posterior plot | both regression files, `plot-posterior.md`, `plot-posterior.png`, `EXPORT_STANDARD.md`, `COLOR_STANDARD.md` if colour |
| Revising a two-panel scatter | `plot-scatter.md`, `COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md` |
| First parameter-recovery, model already in `models/` | both `04-simulations` references, `example_main.R`, `plot-scatter.md`, `plot-posterior.md`, `plot-dot-histogram.md`, `COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md` |
| Writing the `models/` pair a recovery needs | `how-to-write-a-model-definition.md`, `how-to-build-a-recovery-pipeline.md` |
