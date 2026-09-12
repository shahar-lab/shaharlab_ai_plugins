# Shahar Lab: Project Stracture and Rules

## 1. The project main-folders

A lab project that can have only five specific **main-folders**. These main-folders are the only parent subfolders in the project and can only be `data/`, `preprocessing/`, `analysis/`, `simulation/`, and `models/`. 

```text
Project_Root/
├── data/                                                  
├── preprocessing/     
├── models/            
├── analysis/          
└── simulation/        
```

- `data/` — is the project's datasets, that can have only these three subfolders:
  - `collected/` — data "as-is" from the platform that collected it. 
  - `raw/` — tidy data. 
  - `processed/` — after observation exclusions and added calculated columns. 
- `preprocessing/` — the only code that is allowed to handle the data folder. 
- `models/` — the mathematical code for generating and fitting data.
- `analysis/` — hold subfolders that reads and anlyze the data
- `simulation/` —  reads nothing from `data/`, only generates and fit models.

## 2. The job-folder

A **job-folder** is the directory one job writes into.

```text
[job-folder]/
├── code/
├── artifacts/
├── output/
├── main.R
└── summary.md
```

- `code/` — numbered scripts, sourced in `main.R`'s order; renumber in the same edit
- `artifacts/` — machine-readable files that are specific to the job. This could be .rds, .pkl, .csv, etc.
- `output/` — human-facing output inclding figures, tables and manuscript excerpts.
- `main.R` — the orchestrator; paths come from `here::here()` variables; the templates carry the block
- `summary.md` — a human facging notebook that summrizes the job-folder
