# Shahar Lab: Global Project Rules & Architectural Philosophy

This file is the global memory bank for the lab's AI architecture. All AI agents, hooks, and skills must adhere to these non-negotiable rules. It is the canonical folder tree and the single source of truth for lab topology.

## 0. Project Outlook: the whole tree at a glance

A lab project has five top-level parts. Each maps to one numbered domain under `coding-knowledge/`, which holds that part's `rules.md`, the templates that build it, and its craft `references/`; read the domain matching what is being built.

```text
Project_Root/
├── data/            raw material, three stages          → 01-preprocessing/
├── preprocessing/   code that moves data between stages → 01-preprocessing/
├── models/          reusable model definitions          → 03-models/
├── analysis/        empirical analyses of real data     → 02-analysis/
└── simulation/      analyses of model-generated data    → 04-simulations/
```

**Data flows one way.** `data/collected/` → `data/raw/` → `data/processed/`, built by `preprocessing/`. `analysis/` reads from `data/processed/` and writes only inside its own folder. `simulation/` generates its data from a `models/` definition into its own `artifacts/`, and reads nothing from `data/`.

```text
data/collected/  →  [preprocessing/]  →  data/raw/  →  [preprocessing/]  →  data/processed/
                                                                                   ↓
                                                                      analysis/ reads from here

models/[MODEL_NAME]/  →  generated into  →  simulation/[NAME]/artifacts/
```

**Scaffolding a new folder.** Each type's `rules.md` states its structure and carries the templates that build it, in the same subfolder. Read that `rules.md`, create the folders it shows, inject the templates beside it, then replace `<folder_name>` with the real name and set the headers to the user's model name or formula — the parent segment is already correct in each template.

| Request | Location | Rules + templates |
|---|---|---|
| New analysis | `analysis/[NAME]/` | `02-analysis/` |
| New simulation study | `simulation/[NAME]/` | `04-simulations/` |
| New model definition | `models/[MODEL_NAME]/` | `03-models/` |
| Preprocessing setup | `preprocessing/` | `01-preprocessing/` |
| Duplicate / clone a folder | same parent as the source | `02-analysis/references/smart_clone.md` |

**Naming.** Use `snake_case` for every folder and file: `model_stay_by_reward`, `param_recovery`, `03_converting_data_raw_to_processed.R`. Take the name from the approved specification. Keep names free of spaces and of formula notation (`~`, `+`, `|`, `/`) so paths and shell commands resolve.

Every script under a `code/` folder opens with its two-digit position in `main.R`'s source order, per §2.II. Scripts under `preprocessing/code/` carry one of three kind-prefixes after that number — `converting_`, `examining_`, or `summary_`, one per job the script does. `01-preprocessing/rules.md` states the set.

## 1. Core Architectural Paradigm: "One Model, One Folder"
Every analytical task must be housed in its own isolated subfolder: empirical analyses (e.g. brms regressions) under `analysis/`, synthetic simulation studies (e.g. parameter recovery) under the top-level `simulation/` directory. Both use the identical canonical folder set (§3).

A folder that fits models holds exactly one fit. A folder that only describes data — plots, tables, summary statistics — holds the coherent set of figures that belong together. `02-analysis/rules.md` states how the count is taken.

## 2. The Three Golden Rules of Operation

### I. The Artifacts Rule
- **No Data Duplication:** Data must NEVER be copied into local analysis/simulation folders.
- **Reading:** an `analysis/` folder's `main.R` reads clean data directly from the top-level `data/processed/` directory by default; the user may direct it to another stage (e.g. `data/raw/`). A `simulation/` folder generates its data instead of reading a stage.
- **Writing:** The `artifacts/` folder within an analysis/simulation directory is exclusively reserved for generated or derived files (e.g. .rds model fits, MCMC draws, matrices, simulated datasets).
- **Visualization:** The `output/` folder is exclusively reserved for human-facing outputs (plots, figures, and tables).
- **Every script saves its product:** each script sourced from `main.R` ends by writing what it produced — a data frame or model fit to `artifacts_dir`, a figure or table to `output_dir`.
- **Every script loads what it needs:** a script depending on an earlier step reads that step's file from `artifacts_dir` at its top, so each script runs on its own in a fresh session and `main.R` can be resumed from any `source()` line.

### II. The Orchestration Rule
- **Numbered Scripts:** Every script in `code/` opens with a two-digit prefix stating its position in `main.R`'s source order — `01_prep_data.R`, `02_fit_model.R` — so the folder listing reads in pipeline order and a script's place is visible without opening `main.R`.
- **Renumber in the same edit:** Inserting, removing, or reordering a step renumbers the scripts after it and rewrites the matching `source()` lines, so the prefixes stay contiguous and in order. Revising a folder's pipeline includes this renumbering; a numbered file whose prefix disagrees with `main.R` is the one failure this rule invites.
- **Source of Truth:** `main.R` is the ultimate conductor. Execution order is dictated entirely by reading the `source()` calls in `main.R` from top to bottom, and the prefixes agree with that order.
- **Polyglot Execution:** If a script is R, use `source()`. If Python, use `system("python code/script.py")` or `reticulate::source_python()`.

### III. The Clear Boundaries Rule
- **Mechanistic Models:** All .stan and mechanistic architecture files must live exclusively in `models/[MODEL_NAME]/`, one folder per model, containing `[MODEL_NAME].R` (generating code) and `[MODEL_NAME].stan` (fitting code).
- **Analytical Hub:** All workflows that evaluate, fit, or test models live in `analysis/` (empirical) or `simulation/` (synthetic) — never inside `models/`.

## 3. Standard Folder Structure (analysis/ and simulation/)
Every `analysis/[NAME]/` and `simulation/[NAME]/` folder must contain this exact hierarchy:
- `code/` : Short, highly targeted execution scripts, each prefixed with its position in `main.R`'s order (§2.II).
- `artifacts/` : Derived model objects (machine-readable).
- `output/` : Human-readable figures and tables.
- `main.R` : The top-to-bottom execution orchestrator.
- `summary.md` : Metadata, hypotheses, and model outcomes.

## 4. Path Definition Mandate
**Every `main.R` must define directory paths explicitly at the top of the file** (after libraries are loaded, before any execution). This ensures portability, auditability, and reproducibility.

Required structure (`<parent>` is `analysis` or `simulation`):
```r
library(here)

project_root <- here::here()
artifacts_dir <- file.path(project_root, "<parent>", "<folder_name>", "artifacts")
output_dir    <- file.path(project_root, "<parent>", "<folder_name>", "output")
code_dir      <- file.path(project_root, "<parent>", "<folder_name>", "code")
data_path     <- file.path(project_root, "data", "processed")   # folders that read a stored stage
```

**Rules:**
- `project_root` must use `here::here()` to find the repository root dynamically.
- All three directory variables (`artifacts_dir`, `output_dir`, `code_dir`) must be present and correctly reference the folder.
- A folder that reads a stored stage also defines `data_path` — `data/processed/` by default, or the stage the user directed it to (§2.I). A simulation generating its own data leaves it out.
- All `source()` calls must use these variables: `source(file.path(code_dir, "script.R"))` — never hardcode paths.
- The parent and folder name in the paths must match the actual directory (e.g., if the analysis lives in `analysis/anxiety_exam_gender_interaction/`, the paths must say `"analysis", "anxiety_exam_gender_interaction"`).

**Why:** This contract ensures cloud runners, validation scripts, and future AI agents can locate and archive outputs consistently, and guarantees analyses run identically across machines.

## 5. The Reserved Set: values that come from the researcher

Some values in an analysis are facts about the code and some are claims about the science. The second
kind is the researcher's to set, and no agent in this system chooses one:

- an **exclusion cutoff** — the trial count, RT bound, or window-exit limit that removes data
- a **prior** — its family and its parameters
- a **threshold** — any number that decides what counts as a case, a group, or an effect
- a **recovery criterion** — the correlation, bias, or precision a recovery study is judged by

These are the numbers that appear in a manuscript, so each one traces back to a person who chose it.
Where a specification is silent on one, the answer is to ask rather than to default: the interview
settles them before any code is written, the Writer returns `BLOCKED` on one that reached it unset,
and the Reviewer reports `UNAPPROVED` where one was taken anyway.

A value outside this set — how a script is split, what an object is called, the order of panels in a
figure — is the Writer's to take, recorded with an `ASSUMED` tag where the specification left it open.