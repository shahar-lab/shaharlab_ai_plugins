# Coding Knowledge Index

Opened at Plan when filling a Job Card's `ROUTED READS` and `CHECKS`. Dispatch copies `ROUTED READS` onto the spawn card. Paths below are relative to `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/`. The Writer also opens this file when a deliverable has no craft on its card, and names every such file under `ADDED READS`.

Constitution files, the covering folder's `context.md`, its `rules.md` when it exists, and its templates arrive with `FOLDER`. Leave them off this list. `exploration.md` is the Data Explorer's standing read, never routed. Leftover questions live in that entry's **Deploy-checks** — there is no separate checks file. An em dash means that entry has no leftovers. Clarify walks those bullets in the order written. The Writer reads the how-to.

## The entry

Each craft file is one heading and one box. The heading is the filename. The box holds three bullets, always in this order, each name on its own line and its value on the next.

```text
### `filename.md`

> - **Path**
> - **What it covers**
> - **Deploy-checks**
```

- **Heading**
  
  The filename in backticks. Leftover-only entries (no how-to) use the leftover-only label instead.

- **Path**
  
  The path Plan copies onto the Job Card's `ROUTED READS` and, when Deploy-checks is not an em dash, onto `CHECKS`. An em dash means leftover-only: Plan lists the leftover-only label from **What it covers** on `CHECKS` only.

- **What it covers**
  
  The file's subject, and when needed the job that matches it. Match an entry by this line.

- **Deploy-checks**
  
  Leftover questions as nested bullets, one leftover per line, in ask order. Clarify walks them top to bottom. An em dash means none. The how-to remains the only place its craft lives.

Every file under `coding-knowledge/` that is craft is one entry here, and every craft entry is one file.

## 01 · Preprocessing

### `how-to-convert-collected-to-raw.md`

> - **Path**
>   
>   `01-preprocessing/references/how-to-convert-collected-to-raw.md`
> 
> - **What it covers**
>   
>   `converting_data_collected_to_raw.R`: restructure, type every column, drop what was never data, save `data/raw/`.
> 
> - **Deploy-checks**
>   
>   - Do we know what files from collected should be pulled to be converted to raw?
>   - Do we know class and domain per column?
>   - Do we know what counts as missing data ?

### `how-to-convert-raw-to-processed.md`

> - **Path**
>   
>   `01-preprocessing/references/how-to-convert-raw-to-processed.md`
> 
> - **What it covers**
>   
>   `converting_data_raw_to_processed.R`: two-phase exclusions, one named surviving dataset per criterion, save `data/processed/`.
> 
> - **Deploy-checks**
>   
>   - Participant-level exclusion criteria and cutoffs
>   - Trial-level exclusion criteria and cutoffs
>   - Calculated columns and formulae

### `how-to-examine.md`

> - **Path**
>   
>   `01-preprocessing/references/how-to-examine.md`
> 
> - **What it covers**
>   
>   Any `examining_` script: five description blocks, report assembly.
> 
> - **Deploy-checks**
>   
>   —

### `how-to-summarise-exclusions.md`

> - **Path**
>   
>   `01-preprocessing/references/how-to-summarise-exclusions.md`
> 
> - **What it covers**
>   
>   `summary_exclusions.R` and `summary_manuscript_paragraph.R`: cascade tables and the manuscript paragraph.
> 
> - **Deploy-checks**
>   
>   —

### `conversion-and-filter-traps.md`

> - **Path**
>   
>   `01-preprocessing/references/conversion-and-filter-traps.md`
> 
> - **What it covers**
>   
>   Read alongside any `converting_` script: type coercion, `%in%` versus chained `!=`, `scale()`/`cut()`, counts to print.
> 
> - **Deploy-checks**
>   
>   —

### `how-to-build-data-validation.md`

> - **Path**
>   
>   `01-preprocessing/references/how-to-build-data-validation.md`
> 
> - **What it covers**
>   
>   Data-validation HTML per tidy table, class and domain meta-rows.
> 
> - **Deploy-checks**
>   
>   - raw, processed, or both

### `handling-leaving-window.md`

> - **Path**
>   
>   `01-preprocessing/references/handling-leaving-window.md`
> 
> - **What it covers**
>   
>   `window_status`, one exit per sequence of `left` trials, `window_exit_max`. Route when the study is online, the column is present, or the user mentions leaving the window.
> 
> - **Deploy-checks**
>   
>   - `window_exit_max` (one exit is one sequence of `left` trials)

### `exploration.md`

> - **Path**
>   
>   `01-preprocessing/references/exploration.md`
> 
> - **What it covers**
>   
>   Data Explorer profile — standing read, never routed.
> 
> - **Deploy-checks**
>   
>   —

### `example-examining-report.md`

> - **Path**
>   
>   `01-preprocessing/assets/example-examining-report.md`
> 
> - **What it covers**
>   
>   Mockup of an `examining_` report.
> 
> - **Deploy-checks**
>   
>   —

### `example-summary-exclusions.md`

> - **Path**
>   
>   `01-preprocessing/assets/example-summary-exclusions.md`
> 
> - **What it covers**
>   
>   Mockup of `summary_exclusions.md`.
> 
> - **Deploy-checks**
>   
>   —

### `example-data-validation.html`

> - **Path**
>   
>   `01-preprocessing/assets/example-data-validation.html`
> 
> - **What it covers**
>   
>   Mockup of a data-validation HTML.
> 
> - **Deploy-checks**
>   
>   —

A figure of a cutoff takes the matching `02-analysis/visualization/` plot-type entry.

## 02 · Analysis

Route by path, not by where the job lands. A `simulation/` or `preprocessing/` job that needs a figure or a brms fit takes these same entries.

**Regression**

### `01_sampling_and_priors.md`

> - **Path**
>   
>   `02-analysis/regression/01_sampling_and_priors.md`
> 
> - **What it covers**
>   
>   `brm()` workflow: load by `data_path`, approved priors, sampling, save the `.rds`.
> 
> - **Deploy-checks**
>   
>   - Formula and RE structure
>   - Family
>   - Priors (offer weakly informative)
>   - Sampling (offer 4 / 2000 / half warmup)

### `02_diagnostics.md`

> - **Path**
>   
>   `02-analysis/regression/02_diagnostics.md`
> 
> - **What it covers**
>   
>   Post-fit diagnostics: ess/rhat table, trankplot, pairs plot, reported without interpretation.
> 
> - **Deploy-checks**
>   
>   —

**Visualization**

### `plot-posterior.md`

> - **Path**
>   
>   `02-analysis/visualization/plot-types/plot-posterior.md`
> 
> - **What it covers**
>   
>   Posterior / credible interval / effect estimate. ggdist: wide-and-short canvas, three x-axis cases, 0.90 CI.
> 
> - **Deploy-checks**
>   
>   - Which parameters or effects
>   - Effect vs bounded vs other
>   - Single figure or composite

### `plot-scatter.md`

> - **Path**
>   
>   `02-analysis/visualization/plot-types/plot-scatter.md`
> 
> - **What it covers**
>   
>   Scatter, x vs y, correlation, parameter recovery. ggplot2: square panel, shared limits, diagonal, Pearson, mandatory color.
> 
> - **Deploy-checks**
>   
>   - x and y columns
>   - Same-scale or different
>   - Colour mapping
>   - Trend-line band or line alone
>   - Single figure or composite

### `plot-dot-histogram.md`

> - **Path**
>   
>   `02-analysis/visualization/plot-types/plot-dot-histogram.md`
> 
> - **What it covers**
>   
>   Dot histogram, distribution of one variable. ggdist `geom_dots()`: full-range x-axis, rebuilt count y-axis.
> 
> - **Deploy-checks**
>   
>   - Which column
>   - Theoretical range or none
>   - Grouping or none
>   - Single figure or composite

### `plot-posterior.png`

> - **Path**
>   
>   `02-analysis/visualization/plot-types/plot-posterior.png`
> 
> - **What it covers**
>   
>   Rendered reference for the posterior plot.
> 
> - **Deploy-checks**
>   
>   —

### `PANEL_TAGGING_STANDARD.md`

> - **Path**
>   
>   `02-analysis/visualization/standards/PANEL_TAGGING_STANDARD.md`
> 
> - **What it covers**
>   
>   Two or more panels: patchwork assembly and A/B/C tags.
> 
> - **Deploy-checks**
>   
>   —

### `EXPORT_STANDARD.md`

> - **Path**
>   
>   `02-analysis/visualization/standards/EXPORT_STANDARD.md`
> 
> - **What it covers**
>   
>   Every figure: dual PDF+PNG export, canvas, naming.
> 
> - **Deploy-checks**
>   
>   —

### `COLOR_STANDARD.md`

> - **Path**
>   
>   `02-analysis/visualization/standards/COLOR_STANDARD.md`
> 
> - **What it covers**
>   
>   When the plot uses color: which palettes.
> 
> - **Deploy-checks**
>   
>   —

**Descriptives**

### `how-to-report-descriptives.md`

> - **Path**
>   
>   `02-analysis/descriptives/how-to-report-descriptives.md`
> 
> - **What it covers**
>   
>   Participant counts, demographics, or questionnaire distributions: sample tables and per-measure distributions.
> 
> - **Deploy-checks**
>   
>   - Which variables
>   - Grouping
>   - Which measures get a distribution figure
>   - Each named measure exists as a scored column in `data/processed/`

**Cloning**

A new job-folder takes structure from `FOLDER`. A repair reads that covering folder's `context.md`.

### `smart_clone.md`

> - **Path**
>   
>   `02-analysis/smart_clone.md`
> 
> - **What it covers**
>   
>   Duplicating an `analysis/` or `simulation/` job-folder: what to copy, what to wipe, which paths to re-point.
> 
> - **Deploy-checks**
>   
>   - Source job-folder
>   - What changes in the clone

**Model comparison**

### Model comparison / `loo`

> - **Path**
>   
>   —
> 
> - **What it covers**
>   
>   Model comparison / `loo` — leftover-only; no how-to.
> 
> - **Deploy-checks**
>   
>   - Which fitted objects
>   - Which metric (`loo` or another)
>   - Where the PDF goes

## 03 · Models

### `how-to-write-a-model-definition.md`

> - **Path**
>   
>   `03-models/references/how-to-write-a-model-definition.md`
> 
> - **What it covers**
>   
>   Generating `.R` and fitting `.stan` as one pair.
> 
> - **Deploy-checks**
>   
>   - Parameters, what each does, and the scale each is on
>   - Task structure
>   - New definition or structural variant
>   - The three generating/fitting agreements if a recovery will use the pair

A definition a recovery study will generate from and fit back also matches `04-simulations/references/how-to-build-a-recovery-pipeline.md`.

## 04 · Simulations

### `how-to-build-a-recovery-pipeline.md`

> - **Path**
>   
>   `04-simulations/references/how-to-build-a-recovery-pipeline.md`
> 
> - **What it covers**
>   
>   Three pipeline stages, model-family mapping, generating-versus-fitting agreements.
> 
> - **Deploy-checks**
>   
>   - Environment (trials, blocks, task constants)
>   - Population (n agents, location and scale per parameter)
>   - Which `models/` definition generates and which is fitted
>   - Sampler

### `how-to-read-recovery.md`

> - **Path**
>   
>   `04-simulations/references/how-to-read-recovery.md`
> 
> - **What it covers**
>   
>   Six recovery checks in order.
> 
> - **Deploy-checks**
>   
>   - Success criterion: correlation
>   - Success criterion: bias
>   - Success criterion: precision
>   - Offer conventional defaults

### `example_main.R`

> - **Path**
>   
>   `04-simulations/assets/example_main.R`
> 
> - **What it covers**
>   
>   Worked recovery `main.R`.
> 
> - **Deploy-checks**
>   
>   —

A first recovery study matches both reference entries, `example_main.R`, and the `02-analysis/visualization/` entries its figures call for. A study that fits brms also matches `02-analysis/regression/01_sampling_and_priors.md`.

## Common jobs

Standing reads (`FOLDER`) are the same in every job. Extra paths only — Plan copies them onto the Job Card's `ROUTED READS`. Deploy-checks stay on the catalog entries above.

| Job                                                  | Extra paths                                                                                                                                                                                 |
| ---------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| First preprocessing, study online                    | all four `how-to-` script files, `how-to-build-data-validation.md`, `conversion-and-filter-traps.md`, `handling-leaving-window.md`, three `01-preprocessing/assets/` examples               |
| Revising exclusions, study in person                 | `how-to-convert-raw-to-processed.md`, `conversion-and-filter-traps.md`, `how-to-summarise-exclusions.md`, `example-summary-exclusions.md`                                                   |
| New brms folder with a posterior plot                | both regression files, `plot-posterior.md`, `plot-posterior.png`, `EXPORT_STANDARD.md`, `COLOR_STANDARD.md` if colour                                                                       |
| Revising a two-panel scatter                         | `plot-scatter.md`, `COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md`                                                                                                   |
| First parameter-recovery, model already in `models/` | both `04-simulations` references, `example_main.R`, `plot-scatter.md`, `plot-posterior.md`, `plot-dot-histogram.md`, `COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md` |
| Writing the `models/` pair a recovery needs          | `how-to-write-a-model-definition.md`, `how-to-build-a-recovery-pipeline.md`                                                                                                                 |
