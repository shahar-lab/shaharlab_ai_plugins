# Coding Knowledge — Index

The map of `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/`. Malka reads it at Step 2 to decide which files go into a card's `ROUTED READS`; the Code Writer and Code Reviewer read it only to locate a file their card already named.

The numeric prefix is build order. `00` applies to every job. `01`–`04` run in dependency order: scaffolding → preprocessing → bayesian-regression → visualization.

```
00-constitution/           project-rules.md · coding-rules.md
01-scaffolding/
  references/              folder_structure.md · new_folder.md · smart_clone.md
                           review-checklist.md
  assets/                  template_main.R · template_summary.md
                           template_model.R · template_model.stan
02-preprocessing/
  references/              exploration.md · writing-code.md
                           review-checklist.md
  assets/                  template_main.R · example-collected-to-raw-report.md
                           example-raw-to-processed-report.md
03-visualization/
  references/
    plot-types/
      plot-posterior/      instructions.md · example.R · example.png
      plot-scatter/        instructions.md · example.R
    standards/             COLOR_STANDARD.md · EXPORT_STANDARD.md
                           PANEL_TAGGING_STANDARD.md
04-bayesian-regression/     01_sampling_and_priors.md · 02_diagnostics.md
```

Every domain except **04-bayesian-regression** has a `review-checklist.md` — that is the file the Reviewer gets routed to, and it is never the file the Writer gets. **04-bayesian-regression currently has no `review-checklist.md` on disk**; until one is added, route the Reviewer to the two reference files themselves (`01_sampling_and_priors.md`, `02_diagnostics.md`) alongside the approved specification, and rely on the specification match (formula, priors, sampling settings) as the checklist.

## 00 · Constitution

Lab-wide rules. Both files are binding on every card, both agents, every round.

- **`project-rules.md`** — the "one model, one folder" paradigm; the Artifacts / Orchestration / Clear-Boundaries golden rules; the canonical `code/` · `artifacts/` · `output/` · `main.R` · `summary.md` set; the mandatory `main.R` path-definition block (`project_root`, `artifacts_dir`, `output_dir`, `code_dir` via `here::here()` + `file.path()`); the rule that all posterior plots route through `03-visualization`; the 80-line script-splitting guidance.
- **`coding-rules.md`** — R style: base pipe `|>`, naming (`df`, `reward`, `choice`, `stay_ch`), header format (`#### HEADER ####` vs `# subtitle`), the `main.R` vs sourced-script split (libraries and `rm(list = ls())` only in `main.R`), preferred libraries (tidyverse, cmdstanr, ggdist, bayesplot, …), what to avoid (`set.seed()`, `tryCatch()`, `stop()`, `apply`-family, custom `function()`s — unless the task clearly needs them), and how to call external tools (`shQuote()`, absolute paths).

## 01 · Scaffolding

Starting, cloning, or repairing a folder.

- **`references/folder_structure.md`** — the canonical project tree, single source of truth: `data/collected → raw → processed`, `preprocessing/`, `models/[MODEL_NAME]/`, `analysis/[NAME]/`, `simulation/[NAME]/`, and the canonical `code/ · artifacts/ · output/ · main.R · summary.md` set.
- **`references/new_folder.md`** — the build blueprint: a routing table (new analysis, new simulation, new model, preprocessing setup, clone) mapping request → location → template; naming rules (`snake_case`, no `~ + | /` or spaces); step-by-step for each folder type.
- **`references/smart_clone.md`** — duplicating an existing `analysis/`/`simulation/` folder safely: copy `code/`, `main.R`, `summary.md`; wipe `artifacts/` and `output/` completely; re-point `code_dir`/`artifacts_dir`/`output_dir` in the cloned `main.R` to the new folder name; ask the user for the new formula/model name.
- **`references/review-checklist.md`** — two gates: Phase A reviews the plan before execution (rule citations, snake_case names, correct parent folder, no data copying); Phase B reviews the folder on disk after (canonical set present, clone artifacts/output empty, paths match actual names, no numbered scripts).
- **`assets/template_main.R`, `assets/template_summary.md`** — boilerplate for an `analysis/`/`simulation/`/preprocessing `main.R` and its `summary.md`, injected by `new_folder.md`.
- **`assets/template_model.R`, `assets/template_model.stan`** — boilerplate for a `models/[MODEL_NAME]/` pair, injected by `new_folder.md`.

## 02 · Preprocessing

Cleaning, excluding, scoring, validating.

- **`references/exploration.md`** — first contact with raw data: load and inspect structure, examine each column (type, range, uniques, missingness), whole-dataset missing pattern, data-quality issues (out-of-range values, string-encoded NAs, duplicates, wrong types), and the summary-report format that feeds Malka's interview.
- **`references/writing-code.md`** — the pipeline: file layout (`preprocessing/code/`, `output/`, `main.R`; `data/collected → raw → processed`), the type-convert → exclude → save skeleton in straight-line `dplyr` with named intermediate objects, type-coercion patterns, the ordered two-phase exclusion pattern (participant criteria first, then trial criteria on the survivors, each step named `after_<criterion>` so the pipeline order reads off the code and counts come from comparing two named datasets, with every cutoff held in a named variable from the approved plan), the five "Describing the data" blocks that adapt to whatever columns exist (numeric columns via `pivot_longer` + `group_by`/`summarise`; categorical columns with their labels; sample overview; per-participant table sorted worst-first; per-design-cell table), how `collected-to-raw-report.md` (rows kept/dropped + all five description blocks) and `raw-to-processed-report.md` (exclusion cascade per phase with omitted/percent/remaining + final count + the same description blocks on the processed data) are assembled with `knitr::kable(format = "pipe")` + `writeLines()`, and the manuscript "Data treatment" paragraph (every number computed by the script, cutoffs always the user's own values).
- **`references/review-checklist.md`** — six review phases: code structure (including straight-line `dplyr` with named intermediate objects rather than custom `function()`s or `apply`-family calls), type conversions (silent-NA red flags), exclusion logic (participant-phase-before-trial-phase ordering, each step consuming the previous step's named dataset, cutoffs held in named variables used by both filter and report, `%in%` vs `!=` traps, `complete.cases` scope), transformations/derived variables, validation output (row counts, missing values), and final data readiness (both reports present with matching description tables, exclusion criteria user-supplied not invented).
- **`assets/template_main.R`** — boilerplate for the top-level `preprocessing/` folder's `main.R`, sourcing `build_raw.R` → `build_processed.R` → `manuscript_paragraph.R` and naming each one's report deliverable.
- **`assets/example-collected-to-raw-report.md`, `assets/example-raw-to-processed-report.md`** — worked mockups of the two reports' rendered content.

## 03 · Visualization

Creating or revising a figure. Route on what the user asked for:

| Request | Plot type | Route to |
|---|---|---|
| posterior, credible interval, effect estimate | posterior (single) | `references/plot-types/plot-posterior/` |
| the same, two or more distributions | posterior (multi) | `references/plot-types/plot-posterior/` |
| scatter, x vs y, correlation, parameter recovery | scatter | `references/plot-types/plot-scatter/` |
| multiple panels, composite, combine plots | composite | `references/standards/PANEL_TAGGING_STANDARD.md` |

- **`references/plot-types/plot-posterior/instructions.md`** — ggdist + ggplot2 rules: wide/short shape, symmetric zero-centered x-axis for effect posteriors (padded axis for non-effect posteriors), no y-axis, dashed zero and median lines with `[median = X.XX, pd = XX.XX%]` annotation, two nested CIs (0.80/0.90) as line-thickness only (never slab fill), legend placement, panel tagging for 2+ panels, when color is required. `example.R` in the same folder holds runnable single- and multi-posterior code; `example.png` is the rendered reference.
- **`references/plot-types/plot-scatter/instructions.md`** — ggplot2 rules: matched x/y length check, `coord_equal`/`coord_fixed` equal axes, shared limits and four tick marks when x/y share a scale, mandatory linear trend + dashed diagonal reference line, mandatory `[Pearson r = ...]` annotation, mandatory color (colorblind-safe). `example.R` holds the runnable template.
- **`references/standards/COLOR_STANDARD.md`** — when color is required per plot type (table), the Okabe-Ito and Paul Tol palettes, viridis for continuous scales, 2-color point/line pairs for scatter, what to avoid (pure red/green, `rainbow()`, pure hues), and a pre-submission verification checklist. Route whenever the plot uses color.
- **`references/standards/EXPORT_STANDARD.md`** — mandatory dual PDF+PNG export, default canvas (10×8in, 300 DPI, white background), naming convention (descriptive snake_case, shared basename), and the post-export checklist. Route always.
- **`references/standards/PANEL_TAGGING_STANDARD.md`** — patchwork-only assembly (never gridExtra/cowplot), tag only when 2+ panels, bold uppercase A/B/C tags at 14pt via `plot_annotation(tag_levels = 'A')`, common forgetting-to-tag error. Route for 2+ panels.

**Adding a plot type:** create `references/plot-types/plot-<name>/` with `instructions.md` and `example.R`, then add a row above. A rule that applies to every plot type belongs in `references/standards/` instead.

## 04 · Bayesian Regression

Fitting or checking a brms model. These files sit directly in the domain folder, not under `references/`.

- **`01_sampling_and_priors.md`** — the `brm()` workflow: load data via the caller-supplied `data_path` (never copy data locally), translate user-approved priors into `brms::prior()`, fit with 4 chains / 2000 iter / 1000 warmup / `cmdstanr` backend, save the `.rds` to `artifacts_dir`. Worked examples for a simple fixed-effects model and a hierarchical (random intercept/slope) model. Explicitly forbids compiling before the user has approved formula and priors.
- **`02_diagnostics.md`** — the post-fit script producing one `diagnostic.pdf` with, in order: an ess/rhat summary table, a trankplot (`mcmc_rank_overlay`), and a pairs plot (`mcmc_pairs`). Reported without interpretation; judging convergence is the user's call.
- **No `review-checklist.md` exists here yet** — see the note at the top of this index for what to route the Reviewer to in the meantime.
