# The `simulation/` folder

`simulation/` holds simulation studies — every job whose input is model-generated data rather than
collected data. The folder on disk is named `simulation/` (singular). One study, one folder.

```text
simulation/
└── [study_name]/          e.g. param_recovery, model_sim, model_comparison
    ├── code/              short R scripts, numbered in main.R's order (01_generate_data.R, 02_fit_model.R, 03_plot_recovery.R …)
    ├── artifacts/         machine-readable derived files (generated data, fitted .rds)
    ├── output/            human-facing results (recovery scatter plots, tables)
    ├── main.R             the orchestrator — sources code/ scripts in order
    └── summary.md         the notebook — what is being validated, and the verdict
```

## Same shape as `analysis/`, different input

The canonical set and every rule about it are identical to `analysis/` (see
`../analysis/rules.md`). The one difference is where the data comes from:

| | `analysis/` | `simulation/` |
|---|---|---|
| Input | real data, read from `data/processed/` | data generated inside the folder by a `models/` definition |
| Question | what did participants do | does the model behave and recover as intended |

Because the data is generated, a simulation folder's first `code/` script writes its generated
dataset into this folder's own `artifacts/` and nothing is read from `data/`.

**The one-folder-per-fit count is an `analysis/` rule and stops there.** A study here holds as many
fits as its design calls for — a recovery study fits the model back once per simulated dataset, and
those hundred fits are one study in one folder. The unit that earns a folder under `simulation/` is
the study: one generating design, one question about how the model behaves.

## What these studies are for

- **Parameter recovery** — generate data from known parameters, fit the model back, and compare
  true against recovered values (a scatter plot with the diagonal reference line, per the
  `04-visualization` scatter routing).
- **Model simulation** — generate behavior under a set of parameters and check it reproduces the
  qualitative pattern the task is meant to elicit.
- **Model comparison** — generate under one model, fit several, and see which is recovered.

## The `main.R` path block

Same as `analysis/`'s block, with `simulation` as the parent and no `data_path` — nothing is read
from `data/`:

```r
project_root  <- here::here()
code_dir      <- file.path(project_root, "simulation", "<folder_name>", "code")
artifacts_dir <- file.path(project_root, "simulation", "<folder_name>", "artifacts")
output_dir    <- file.path(project_root, "simulation", "<folder_name>", "output")
```

## Building one

Create `code/`, `artifacts/`, `output/`; inject `template_main.R` as `main.R`; then replace
`<folder_name>` with the real name. To copy an existing
study, use `../../02-scaffolding/references/smart_clone.md`.

`summary.md` is written by Malka from the approved specification, not by the Writer building the
folder — the same split `../analysis/rules.md` states. Scaffold the three directories and `main.R`;
the notebook arrives separately, shaped by `template_summary.md` in this same subfolder.
