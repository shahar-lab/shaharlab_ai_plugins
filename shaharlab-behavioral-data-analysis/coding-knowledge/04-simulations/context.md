# The `simulation/` folder

`simulation/` holds simulation studies — every job whose input is model-generated data rather than
collected data. The main-folder on disk is named `simulation/` (singular). One study, one job-folder.

```text
simulation/
└── [study_name]/          e.g. param_recovery, model_sim, model_comparison
    ├── code/              short R scripts, numbered in main.R's order (01_generate_data.R, 02_fit_model.R, 03_plot_recovery.R …)
    ├── artifacts/         machine-readable derived files (generated data, fitted .rds)
    ├── output/            human-facing results, same NN as the writing script (04_recovery_scatter.pdf)
    ├── main.R             the orchestrator — sources code/ scripts in order
    └── summary.md         the notebook — what is being validated, and the verdict
```

## Same shape as `analysis/`, different input

The canonical set and every rule about it are identical to `analysis/` (see
`../02-analysis/context.md`). The one difference is where the data comes from:

| | `analysis/` | `simulation/` |
|---|---|---|
| Input | real data, read from `data/processed/` | data generated inside the folder by a `models/` definition |
| Question | what did participants do | does the model behave and recover as intended |

Because the data is generated, a simulation job-folder's first `code/` script writes its generated
dataset into this job-folder's own `artifacts/` and nothing is read from `data/`.

**The one-job-folder-per-fit count is an `analysis/` rule and stops there.** A study here holds as many
fits as its design calls for — a recovery study fits the model back once per simulated dataset, and
those hundred fits are one study in one job-folder. The unit that earns a job-folder under `simulation/` is
the study: one generating design, one question about how the model behaves.

## What these studies are for

- **Parameter recovery** — covering files live in `../parameter_recovery/`. Write `main.R` from
  the example in that folder's `context.md`, not from this folder's `template_main.R`. That covering
  folder states the four `main.R` stages, the Word and multi-page PDF deliverables, and the three
  required recovery figures.
- **Model simulation** — generate behavior under a set of parameters and check it reproduces the
  qualitative pattern the task is meant to elicit.
- **Model comparison** — generate under one model, fit several, and see which is recovered.

## The `main.R` path block

`template_main.R` beside this file carries it, with `simulation` as the main-folder and no `data_path` —
nothing here is read from `data/`. `project-rules.md` §2 states the contract.

## Building one

Create `code/`, `artifacts/`, `output/`; inject this folder's `template_main.R` as `main.R` for a
model-simulation or model-comparison study; when the study is a recovery, write `main.R` from the
example in `../parameter_recovery/context.md`. Then replace `<folder_name>` with the real name. To
copy an existing study, use `../02-analysis/smart_clone.md`.

`summary.md` is written by Malka from the approved specification, not by the Writer building the
job-folder — the same split `../02-analysis/context.md` states. Scaffold the three directories and `main.R`;
the notebook arrives separately, shaped by this folder's `template_summary.md` or, for a recovery,
by `../parameter_recovery/template_summary.md`.
