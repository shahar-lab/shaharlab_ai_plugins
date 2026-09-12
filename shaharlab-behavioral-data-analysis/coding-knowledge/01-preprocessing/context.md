# Mandatory context for the preprocessing main-folder

## 1. Goal

`preprocessing/` is one of the five main-folders. It is the only main-folder that handles preprocessing and housekeeping of the empirical data. It handles `data/` in a controlled, documented way, and it writes human-facing reports so the researcher can see how the data is structured and how it was handled. 

## 2. The data folder

`data/` holds the empirical dataset at three subfolders.  

```text
data/
├── collected/
├── raw/
└── processed/
```

- **`collected/`**
  
  As arrived; read-only. Read from it. Never write to it, rename it, or tidy it in place. Shape is whatever the study produced: one file per subject; one file covering several sessions; separate files for demographics, task behavior, self-reports; and other splits like those. Do not assume a single table. This plugin is for behavioral analysis, so the usual data contents are demographics, cognitive-task data, and self-reports.

- **`raw/`**
  
  The tidy version. Keep every real observation; drop only what was never data (not instruction screens, practice or housekeeping trials, or other non-data). Class and values of each column are set here and verified by the user, via the data-validation HTML in `preprocessing/output/`.

- **`processed/`**
  
  `raw/` after two things only: exclusion of participants and of observations, and addition of calculated columns.

## 3. Structure

`preprocessing/` is itself one job-folder. It does not contain named job-folders and takes no other tree. The five parts are the generic job-folder in `project-rules.md` §2.

Scripts in `code/` take the two-digit prefix of their `source()` order in `main.R` (`01_converting_data_collected_to_raw.R`). How-tos and reports keep the unnumbered stem (`converting_data_collected_to_raw.R`, `examining_data_raw.md`). A SETUP helper such as `converting_data_validation.R` keeps that stem with no prefix — it is functions, not a pipeline step.
