# Shahar Lab: Project Structure and Rules

## 1. The project's main folders

A lab project can have only five specific **main folders**. These are the only top-level folders in the project: `data/`, `preprocessing/`, `analyses/`, `simulation/`, and `models/`.

```text
Project_Root/
├── data/ 
├──── collected/                                                
├──── raw/
├──── processed/
├── preprocessing/     
├── models/            
├── analyses/          
└── simulation/        
```

- **`data/`**
  This main folder holds the empirical data. It can have only these three subfolders: `data/collected/`, `data/raw/`, and `data/processed/`.

- **`data/collected/`**
  
  <u>Read/Write rules:</u> `data/collected/` is a READ-ONLY folder that can be accessed only by code written under the `preprocessing/` main folder. No other code in the repository may read from it. No code may write to it, rename it, move it, tidy it, or change any of its files.
  <u>Context:</u> The `data/collected/` folder holds the `collected-data` dataset. This is the behavioral data copied "as is" from the machine that created it. It can contain multiple files for different participants, sessions, tasks, self-reports, demographics, etc. Typically, code in the `preprocessing/` main folder reads from `data/collected/` to populate `data/raw/`.

- **`data/raw/`**
  <u>Read/Write permission:</u> Only code from the `preprocessing/` main folder may READ from or WRITE to this folder. No other code in the repository may access this folder.
  <u>Context:</u> The `collected-data` under `data/collected/` has several major issues. The `preprocessing/` main folder reads the `collected-data` and creates a tidier version called `raw-data`, which it places in the `data/raw/` subfolder. `raw-data` contains all the data and is ready to be shared publicly when the time is right. It will typically contain one file for each measure (e.g., demographics, depression self-report, anxiety self-report, task data, etc.). Each file will usually aggregate the observations of all participants. Because the raw data is intended for public sharing, it will usually be in CSV format.

- **`data/processed/`**
  <u>Read/Write permission:</u> Only code from the `preprocessing/` main folder may WRITE to this folder. All other code in the repository may freely READ from this folder but may not WRITE to it.
  <u>Context:</u> The `data/processed/` folder contains an advanced version of the data called `processed-data`. This is the final form of the data and is used as input for all types of analyses. The user will almost always refer to `processed-data` as "the data" when prompting you to write a new `job-folder` in the `analyses/` main folder.

- **`preprocessing/`**
  <u>Read/Write permission:</u> Code in this folder may read from `data/collected/` and read from and write to both `data/raw/` and `data/processed/`.
  <u>Context:</u> This main folder holds the code and outputs for converting `collected-data` into `raw-data` and excluding observations to create `processed-data`. The `preprocessing/` folder is one of the five main folders and must be a single `job-folder` with the subfolders defined for it. It should not include any other structure. Its outputs (figures, tables, data views, and manuscript excerpts) allow the researcher to review observation exclusions and added calculated columns.

- **`models/`** 
  <u>Read/Write permission:</u> The files here may be used by code from the `simulation/` or `analyses/` main folder. Only the researcher or an approved agent may write to this folder.
  <u>Context:</u> This main folder holds mathematical and computational models. Each subfolder is named after a model and includes data-generating and model-fitting code (e.g., `[model-name].R` and `[model-name].stan`). It contains only code that generates and fits data. Different job folders under `analyses/` or `simulation/` call these functions for data generation, model fitting, posterior predictive checks, etc.

- **`analyses/`**
  <u>Read/Write permission:</u> Code in this main folder can and should read the empirical data under `data/processed/`. It may use models under `models/` to complete the required tasks.
  <u>Context:</u> This main folder holds the code that runs regressions, creates plots, fits and compares models, calculates descriptive statistics, and performs all other major data and statistical analyses of the behavioral data. Each analysis within the `analyses/` main folder is a standalone `job-folder`, so each model, regression analysis, etc. has its own `job-folder`.

- **`simulation/`**
  <u>Read/Write permission:</u> Code in this main folder should not read or use empirical data under `data/`. Unless the user specifically requests otherwise, this folder generates its own artificial data.
  <u>Context:</u> Code in this folder may use models under `models/` to complete the required tasks. It reads nothing from `data/`; it only generates data and fits models.

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

- **`main.R`**
  This script is the orchestrator. It starts with clearning the workspace uisng `rm(list = ls()` and  loads the R libraries that will be use in `code/`. Next, it uses `here::here()` to settle path variables for the job-folder root, the `code`, `output`, and `artifacts` subfolder, and the path to the data that needs to be read for this specific analysis. The `main.R` files then lists the scripts one by one, ordered and numbered in a `source()` script that allows the user to run these one at  a time.

- **`code/`** 
  Human-facing scripts that perfom the task that is required for the specific job-folder. These can be files that run a regression, make a figure, fit a model etcs. They are run by the researcher in the main.R file, where they are sourced one-by-one. They are numbered according to their sorting in `main.R`. These scripts are written according to the lab coding rules. They are human-facing in every possible aspect since the reesrcher will need to validate them from time-to-time. Optimally, they are not too long (50-100 rows) and are well written. 

- **`artifacts\`** 
  This is a subfolder that contains all machine-readable files specific to the job. These may include `.rds`, `.pkl`, `.csv`, etc. These files are typically produces by the `code` subfolders and are required for the scripts to complete their task. They should be saved in a way that is most convenitit for the code and AI, since the researcher is unlikley to explore or examine them. Each code starts by loading data or models from the data path or artifacts, and ends by saving something or producing somethings. 

- **`output/`**
  Human-facing outputs, including figures, tables, and manuscript excerpts. Each file is named `NN_descriptive_name.ext`, where `NN` is the same prefix as the `code/` script whose `source()` call writes it.

  `preprocessing/` is the only job-folder with subfolders inside `output/`:

  ```text
  output/
  ├── reports-collected/
  ├── reports-raw/
  └── reports-processed/
  ```

- **`summary.md` **
  A human-facing notebook that summarizes the job folder.
