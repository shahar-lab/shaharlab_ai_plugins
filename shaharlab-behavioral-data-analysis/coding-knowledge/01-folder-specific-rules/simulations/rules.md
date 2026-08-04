# The `simulation/` folder

`simulation/` holds simulation studies — every job whose input is model-generated data rather than
collected data. The folder on disk is named `simulation/` (singular). One study, one folder.

```text
simulation/
└── [study_name]/          e.g. param_recovery, model_sim, model_comparison
    ├── code/              short, unnumbered R scripts (generate_data.R, fit_model.R, plot_recovery.R …)
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

## What these studies are for

- **Parameter recovery** — generate data from known parameters, fit the model back, and compare
  true against recovered values (a scatter plot with the diagonal reference line, per the
  `04-visualization` scatter routing).
- **Model simulation** — generate behavior under a set of parameters and check it reproduces the
  qualitative pattern the task is meant to elicit.
- **Model comparison** — generate under one model, fit several, and see which is recovered.

## The `main.R` path block

Identical to `analysis/`, with `simulation` as the parent:

```r
project_root  <- here::here()
code_dir      <- file.path(project_root, "simulation", "<folder_name>", "code")
artifacts_dir <- file.path(project_root, "simulation", "<folder_name>", "artifacts")
output_dir    <- file.path(project_root, "simulation", "<folder_name>", "output")
```

## Building one

Create `code/`, `artifacts/`, `output/`; inject `template_main.R` as `main.R` and
`template_summary.md` as `summary.md`; then replace
`<folder_name>` with the real name. To copy an existing
study, use `../../02-scaffolding/references/smart_clone.md`.
