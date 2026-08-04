# Coding Knowledge — Index

The file-by-file map of `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/`. Malka reads it at Step 2 to fill each card's `ROUTED READS`; the subagents read it only to locate a path their card already named.

Paths below are relative to `coding-knowledge/`. **W** = the Writer reads it, **R** = the Reviewer reads it. For the `02`–`05` rows that mark is the card slot: the file goes in that agent's `ROUTED READS`. For the `00` and `01` rows it is the standing read each agent takes on every job, delivered by the card's `FOLDER` slot rather than listed as a path.

## How to route a job

1. **Name the folder.** The card's `FOLDER` slot carries the one folder the dispatch works in. That slot is what delivers the `00` and `01` rows: both agents read the two constitution files and the `rules.md` for that folder's part on every job, on the standing instruction in their own agent files. Fill the slot and leave those rows off `ROUTED READS`. A job touching two folders is two dispatches in dependency order — see `dispatch.md`.
2. **Add the `02`–`05` rows for each stage the job involves**, working from the trigger table at the head of each of those sections.
3. **Split by mark.** The Writer's card takes the rows marked W, the Reviewer's the rows marked R. A row marked both goes on both cards.

Route the stages the job involves and nothing beyond them. `assets/` rows are examples the Writer imitates — route one for each deliverable the job produces.

**"Worked routes" at the end of this file resolves the common jobs end to end.** Start from the closest one and adjust; it is also the fastest way for a human to check that a route came out right.

## 00 · Constitution — every job, both cards

| Path | What it governs | W | R |
|---|---|:-:|:-:|
| `00-constitution/project-rules.md` | §0 the project tree, the scaffolding routing table, naming; then the one-model-one-folder paradigm, the Artifacts/Orchestration/Boundaries rules, the canonical set, the `main.R` path mandate | ✓ | ✓ |
| `00-constitution/coding-rules.md` | R style: base pipe, naming, headers, `main.R` vs sourced-script split, preferred libraries, calling external tools | ✓ | ✓ |

## 01 · Folder-Specific Rules — routed by where the work lands

One subfolder per top-level project part. Each `rules.md` states that folder's structure and how it is handled; the templates that build it sit beside it in the same subfolder. Route every type the job touches.

| Work lands in | Path | Templates beside it | W | R |
|---|---|---|:-:|:-:|
| `preprocessing/`, `data/` | `01-folder-specific-rules/preprocessing/rules.md` | `template_main.R` | ✓ | ✓ |
| `analysis/[NAME]/` | `01-folder-specific-rules/analysis/rules.md` | `template_main.R`, `template_summary.md` | ✓ | ✓ |
| `models/[NAME]/` | `01-folder-specific-rules/models/rules.md` | `template_model.R`, `template_model.stan` | ✓ | ✓ |
| `simulation/[NAME]/` | `01-folder-specific-rules/simulations/rules.md` | `template_main.R`, `template_summary.md` | ✓ | ✓ |

## 02 · Scaffolding — starting, cloning, or repairing a folder

Building a new folder routes through `00-constitution/project-rules.md` §0 and the `01` row for its type, both of which arrive with `FOLDER`. This domain covers only what those do not.

| The job | Route the Writer to |
|---|---|
| starts a new folder | nothing here — §0 and the `01` row already carry the structure and its templates |
| duplicates an `analysis/`/`simulation/` folder | `smart_clone.md` |
| repairs a folder against the canonical set | nothing here — the `01` row states the canonical set |

Route the Reviewer to `review-checklist.md` whenever the job creates, clones, or repairs a folder.

| Path | What it covers | W | R |
|---|---|:-:|:-:|
| `02-scaffolding/references/smart_clone.md` | Duplicating an `analysis/`/`simulation/` folder: what to copy, what to wipe, which paths to re-point | ✓ | |
| `02-scaffolding/references/review-checklist.md` | Two gates — the plan before execution, the folder on disk after | | ✓ |

## 03 · Preprocessing — cleaning, excluding, examining, reporting

`preprocessing/code/` holds three kinds of script, named by prefix — `converting_` moves data
between stages, `examining_` inspects one stage, `summary_` reports for the researcher and the
manuscript. **The prefixes themselves are a binding read, not a routed one:** they are stated in
`01-folder-specific-rules/preprocessing/rules.md`, which is already on both cards for any job
landing in `preprocessing/`. This domain holds one `how-to-` file per script kind, so route by which
scripts the job writes.

| The job writes | Route the Writer to |
|---|---|
| `converting_data_collected_to_raw.R` | `how-to-convert-collected-to-raw.md` |
| `converting_data_raw_to_processed.R` | `how-to-convert-raw-to-processed.md` |
| any `examining_` script | `how-to-examine.md` |
| `summary_exclusions.R` or `summary_manuscript_paragraph.R` | `how-to-summarise-exclusions.md` |

A first full pipeline writes all six scripts, so it routes all four. A job that only revises the
exclusions routes the raw→processed and the summarise files, and nothing else.

**Then check for leaving the window.** `handling-leaving-window.md` is a measure that threads through
four of the six scripts rather than belonging to one, so it is routed on the data, not on the script.
Add it to **both** cards when any of these holds:

- the study ran in a browser — Pavlovia, Prolific, MTurk, or any online sample
- `data/collected/` carries a `window_status` / `window_left_ms` column, or rows marked
  `event_type == "attention_event"` (the exploration pass sees this)
- the user mentions leaving the window, tab switching, losing focus, fullscreen exits, or being away
  from the screen

It goes on the Reviewer's card as well as the Writer's: one exit is a *sequence* of `left` trials, and
a count that returns flagged trials instead of episodes is the failure this measure invites. The
Reviewer needs the definition to check the count against.

Route it on an in-person or non-browser study only if the user asks — there is no `window_status`
column to count, and the file says to leave the criterion out rather than substitute for it.

| Path | What it covers | W | R |
|---|---|:-:|:-:|
| `03-preprocessing/references/exploration.md` | First contact with collected data, before any pipeline code exists; produces the profile that feeds the interview | ✓ | |
| `03-preprocessing/references/how-to-convert-collected-to-raw.md` | `converting_data_collected_to_raw.R`: restructure, type every column, drop what was never data, save `data/raw/`; the type-coercion patterns | ✓ | |
| `03-preprocessing/references/how-to-convert-raw-to-processed.md` | `converting_data_raw_to_processed.R`: the two-phase exclusion pattern, one named surviving dataset per criterion, save `data/processed/` | ✓ | |
| `03-preprocessing/references/how-to-examine.md` | The `examining_` scripts: the five description blocks, report assembly, and how the raw and processed reports line up | ✓ | |
| `03-preprocessing/references/how-to-summarise-exclusions.md` | The two `summary_` scripts: the per-phase exclusion cascade tables and the manuscript "Data treatment" paragraph | ✓ | |
| `03-preprocessing/references/handling-leaving-window.md` | Online studies: the `window_status` column, counting one exit per *sequence* of `left` trials, the `window_exit_max` cutoff, and the participant-phase exclusion — routed on the data, per the note above | ✓ | ✓ |
| `03-preprocessing/references/review-checklist.md` | Six review phases, from script naming to final data readiness, with the script each phase lands on | | ✓ |
| `03-preprocessing/assets/example-examining-report.md` | Worked mockup of an `examining_` report | ✓ | |
| `03-preprocessing/assets/example-summary-exclusions.md` | Worked mockup of `summary_exclusions.md` | ✓ | |

**`template_main.R` is not here.** The `preprocessing/main.R` boilerplate lives with the folder
rules, at `01-folder-specific-rules/preprocessing/template_main.R`, so rules and boilerplate stay
one routed read.

## 04 · Visualization — creating or revising a figure

Route on what the user asked for, then add every standard that applies.

| Request | Plot rows to add |
|---|---|
| posterior, credible interval, effect estimate | `plot-posterior/` |
| scatter, x vs y, correlation, parameter recovery | `plot-scatter/` |
| multiple panels, composite | the panel-tagging standard |

| Path | What it covers | W | R |
|---|---|:-:|:-:|
| `04-visualization/references/plot-types/plot-posterior/instructions.md` | ggdist rules: shape, axes, zero/median lines, nested CIs, annotation | ✓ | ✓ |
| `04-visualization/references/plot-types/plot-posterior/example.R` | Runnable single- and multi-posterior code | ✓ | |
| `04-visualization/references/plot-types/plot-posterior/example.png` | The rendered reference | ✓ | |
| `04-visualization/references/plot-types/plot-scatter/instructions.md` | ggplot2 rules: equal axes, trend and diagonal lines, Pearson annotation, mandatory color | ✓ | ✓ |
| `04-visualization/references/plot-types/plot-scatter/example.R` | Runnable scatter template | ✓ | |
| `04-visualization/references/standards/COLOR_STANDARD.md` | When color is required, which palettes, what to avoid — route whenever the plot uses color | ✓ | ✓ |
| `04-visualization/references/standards/EXPORT_STANDARD.md` | Dual PDF+PNG export, canvas, naming — route always | ✓ | ✓ |
| `04-visualization/references/standards/PANEL_TAGGING_STANDARD.md` | patchwork assembly and A/B/C tags — route for 2+ panels | ✓ | ✓ |

**No `review-checklist.md` exists here.** The rows marked R above are the Reviewer's checklist — route the plot-type `instructions.md` and every applicable standard to the Reviewer as well as the Writer, and review the figure code against those.

## 05 · Bayesian Regression — fitting or checking a brms model

These files sit directly in the domain folder, with no `references/`.

A brms regression is an empirical workflow, so its `FOLDER` slot names a folder under `analysis/` — `models/` holds mechanistic `.stan` definitions, per `project-rules.md` §2.III. A regression fit to model-generated data lands under `simulation/` on the same rule.

| The job | Route both cards to |
|---|---|
| fits a brms model | `01_sampling_and_priors.md` |
| writes or checks the post-fit diagnostics | `02_diagnostics.md` |

| Path | What it covers | W | R |
|---|---|:-:|:-:|
| `05-bayesian-regression/01_sampling_and_priors.md` | The `brm()` workflow: load by `data_path`, translate approved priors, sampling settings, save the `.rds` | ✓ | ✓ |
| `05-bayesian-regression/02_diagnostics.md` | The post-fit script: ess/rhat table, trankplot, pairs plot, reported without interpretation | ✓ | ✓ |

**No `review-checklist.md` exists here.** Route the Reviewer to these two files themselves alongside the approved specification, and treat the specification match — formula, priors, sampling settings — as the checklist.

## Worked routes

Five common jobs, routed end to end. Each shows what the two cards actually carry, so a route can be
checked against a worked answer instead of re-derived from the steps. Take the closest one and adjust
for what the job differs on.

The three reads that arrive with `FOLDER` are the same in every route below —
`00-constitution/project-rules.md`, `00-constitution/coding-rules.md`, and the
`01-folder-specific-rules/<type>/rules.md` for that folder's part — so the counts read "3 + n".

### A · First preprocessing pipeline, study run online

`FOLDER: preprocessing/` (which covers the `data/` stages it builds). Writes all six pipeline scripts, so all four `how-to-` files route.
The data carries a `window_status` column, which puts `handling-leaving-window.md` on both cards. Both
report deliverables are produced, so both `assets/` examples route.

| Card | `ROUTED READS` | Reads |
|---|---|---|
| Writer | `03-preprocessing/references/how-to-convert-collected-to-raw.md`, `how-to-convert-raw-to-processed.md`, `how-to-examine.md`, `how-to-summarise-exclusions.md`, `handling-leaving-window.md`, `03-preprocessing/assets/example-examining-report.md`, `example-summary-exclusions.md` | 3 + 7 |
| Reviewer | `03-preprocessing/references/review-checklist.md`, `handling-leaving-window.md` | 3 + 2 |

### B · Revising the exclusion criteria on an existing pipeline, study run in person

`FOLDER: preprocessing/`. Only the exclusions and the summary that quotes them change, so the
collected→raw and `examining_` files stay off both cards. `summary_exclusions.md` is regenerated, so
its example routes and the examining example does not. In person means no `window_status` column to
count, so `handling-leaving-window.md` routes only if the user asks for it.

| Card | `ROUTED READS` | Reads |
|---|---|---|
| Writer | `03-preprocessing/references/how-to-convert-raw-to-processed.md`, `how-to-summarise-exclusions.md`, `03-preprocessing/assets/example-summary-exclusions.md` | 3 + 3 |
| Reviewer | `03-preprocessing/references/review-checklist.md` | 3 + 1 |

### C · brms regression in a new analysis folder, with a posterior plot

`FOLDER: analysis/[analysis_name]/` — an empirical fit lands under `analysis/`, per §05's note. The
folder is new, which routes the scaffolding checklist to the Reviewer while the structure itself
arrives with `FOLDER`. §05 ships no `review-checklist.md`, so the Reviewer reads its two files
directly. The fit, the diagnostics, and the plot all land in this one folder, so the job is one
dispatch.

| Card | `ROUTED READS` | Reads |
|---|---|---|
| Writer | `05-bayesian-regression/01_sampling_and_priors.md`, `02_diagnostics.md`, `04-visualization/references/plot-types/plot-posterior/instructions.md`, `plot-posterior/example.R`, `plot-posterior/example.png`, `04-visualization/references/standards/EXPORT_STANDARD.md`, and `COLOR_STANDARD.md` when the figure uses color | 3 + 6 or 7 |
| Reviewer | `05-bayesian-regression/01_sampling_and_priors.md`, `02_diagnostics.md`, `04-visualization/references/plot-types/plot-posterior/instructions.md`, `04-visualization/references/standards/EXPORT_STANDARD.md`, `02-scaffolding/references/review-checklist.md` | 3 + 5 |

### D · Revising an existing two-panel scatter figure

`FOLDER: analysis/[analysis_name]/`. The folder already exists, so no `02` row routes. Two panels put the
panel-tagging standard on both cards, and the scatter instructions make color mandatory, so
`COLOR_STANDARD.md` routes on both as well. §04 ships no checklist, so the Reviewer reviews against
the same instructions and standards the Writer built from.

| Card | `ROUTED READS` | Reads |
|---|---|---|
| Writer | `04-visualization/references/plot-types/plot-scatter/instructions.md`, `plot-scatter/example.R`, `04-visualization/references/standards/COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md` | 3 + 5 |
| Reviewer | `04-visualization/references/plot-types/plot-scatter/instructions.md`, `04-visualization/references/standards/COLOR_STANDARD.md`, `EXPORT_STANDARD.md`, `PANEL_TAGGING_STANDARD.md` | 3 + 4 |

### E · The exploration pass, dispatched at Step 1

The one card that goes out before the approval gate, and the one Writer card with no `FOLDER`:
`exploration.md` states that this pass runs over `data/collected/` before any pipeline code exists, so
it lands in no project part and takes no `01` read. It routes one file, runs Writer-only with no
review round, and returns the profile the interview works from.

| Card | `ROUTED READS` | Reads |
|---|---|---|
| Writer | `03-preprocessing/references/exploration.md` | 1 |

## Maintaining this index

Every row is one file on disk, and every file on disk is one row. Adding, renaming, or removing a file under `coding-knowledge/` changes its row here in the same edit. The **What it covers** column names the file's subject in one line; the file itself is the only place its content lives.

Three things move together with a row: its section's trigger table, so the new file has a stated
condition that routes it; its `W` / `R` mark, which is the whole routing decision for that file; and
any **Worked routes** entry whose job now touches it, so the worked answers stay true. A route that
disagrees with its worked example is the signal that one of the two is stale.

**A routed file states its own preconditions.** Every variable it expects to be defined and every
package it calls are named in the file itself, since the card no longer carries a summary of them. A
file that assumes `patchwork` or a `data_path` without saying so produces code that fails in the
user's session, and neither agent can catch it.
