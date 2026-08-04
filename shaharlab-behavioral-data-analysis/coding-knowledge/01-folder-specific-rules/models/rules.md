# The `models/` folder

`models/` holds reusable model definitions — the computational or statistical model itself,
separate from any one study that uses it. One model, one folder.

```text
models/
└── [model_name]/
    ├── [model_name].R      generating code — simulates behavior from parameters
    └── [model_name].stan   Stan code — fits parameters to behavior
```

The two file names match the folder name exactly, so `models/rw_2alpha/` contains
`rw_2alpha.R` and `rw_2alpha.stan`.

## The one exception to the canonical set

This is the only folder type with no `code/`, `artifacts/`, `output/`, `main.R`, or `summary.md`.
A model definition produces nothing on its own — it is a definition that other folders load.
Fitting it to real data happens in `analysis/`; recovering its parameters or simulating from it
happens in `simulation/`.

## What each file holds

| File | Holds |
|---|---|
| `[model_name].R` | The forward/generating direction: given parameters and a task design, produce simulated choices and outcomes. Used by `simulation/` studies. |
| `[model_name].stan` | The inverse/fitting direction: `data`, `parameters`, and `model` blocks that estimate parameters from observed behavior. Compiled and sampled by `analysis/` or `simulation/` folders via cmdstanr. |

## How the folder is handled

- Both files are sourced or compiled by path from a `main.R` elsewhere; they are never run
  in place.
- Changing the model means editing these two files, and every folder that loads them picks up the
  change on its next run.
- A variant that differs in structure (a different number of learning rates, a different link)
  is a new folder under `models/`, not a branch inside an existing file.

## Building one

Create `models/[model_name]/`, then inject `template_model.R` as `[model_name].R` and
`template_model.stan` as `[model_name].stan`.
