# Instructions for R coding

These are instructions and guidelines for writing R scripts in this repository.

## R programming context

Always write clear, readable R code.

Code should be easy to understand, easy to edit, and consistent with the existing style of this repository.

## Core R coding guidelines

Follow these guidelines when writing R code:

* Use clear, descriptive object names.
* Follow the style and structure of the existing R code in this repository before introducing new patterns.
* Keep scripts focused on the task they are meant to perform.
* Write each script as one step of 50–80 lines, sourced from `main.R`; split a longer script into two named steps.
* Use only the minimum number of headers needed to make the code easy to navigate.
* Comment only when the code is not readable from the object names and structure.
* Let clear code speak for itself.
* Align `<-` and `=` within related blocks when this improves readability.
* Use the base R pipe `|>` rather than `%>%`, unless the existing code uses `%>%` or a package requires it.
* Call functions directly, and add any missing package's `library()` call to `main.R`'s `#### SETUP ####` header (or the top of the script, if there is no `main.R`), so `::` stays out of the body.
* Reach for `pkg::fun()` only where it is required to resolve a naming conflict between two loaded packages; call every other function directly after loading its package with `library()`.

## Reach for these only where the task calls for them

Comment where the code needs it and leave the rest to the object names.

* Use `set.seed()` where the user asked for reproducible random output.
* Use `tryCatch()` where there is a clear reason to recover from an expected error.
* Use `stop()` where the user asked for strict validation, or where the error prevents an incorrect result.
* Reach for `apply`, `vapply` and their like where a vectorised expression or an explicit loop genuinely will not serve.

## Preferred R style

These are preferred guidelines, but use judgment when the task or existing code calls for a different approach.

* Prefer `tidyverse` and `dplyr` when they fit the task.
* Prefer simple, explicit code over clever or compact code.
* Prefer readable intermediate objects over long nested expressions.
* Write the steps out in sequence, inline, using existing functions from the loaded packages; write a custom `function()` only where the user specifically asked for one, or where the same block would otherwise repeat.

## Writing conventions

* prefer to use `df` for the main data.frame when ever possible
* in our lab we use the variabels "reward", "reward_oneback", "choice", "stay_ch" very often. Use when appropriate. 

## Preferred R libraries

Prefer these libraries when they fit the task:

```r
library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)
library(purrr)
library(stringr)
library(tibble)
library(cmdstanr)
library(posterior)
library(ggdist)
library(bayesplot)
```

## how to use headers in R

Use this format for main headers:

```r
#### HEADER ####
```

Use only `#` for smaller subtitles:

```r
# Smaller subtitle
```

## how to start your script

**Main script (main.R):**

- Put `rm(list = ls())` at the start
- Use a `#### SETUP ####` header where you:
  - Load all required libraries (including `library(here)`)
  - Define `project_root <- here::here()` to anchor all paths to the root `project.Rproj` file
  - Define all folder paths using `file.path()` (e.g., `artifacts_dir <- file.path(project_root, "analysis", "my_analysis", "artifacts")`)
  - Source required functions
- Then use `#### EXECUTE PIPELINE ####` to source the scripts in `code/`

**Sourced scripts (code/*.R):**

- Leave `rm(list = ls())` to `main.R`
- Leave every `library()` call to `main.R`
- Start directly with a functional header (e.g., `#### CREATE EXAMPLE DATA ####`, `#### LOAD MODEL ####`)
- Inherit paths and libraries from the parent environment when sourced from main.R

## Using paths in sourced scripts (see project-rules.md §4 for the full path-setup contract)

In sourced scripts under `code/`:

* Load data via the `data_path` variable passed from `main.R`.
* Save derived objects to `artifacts_dir` (e.g. `file.path(artifacts_dir, "fit.rds")`).
* Save plots/tables to `output_dir` with the writing script's `NN` prefix (e.g. `file.path(output_dir, "04_plot.png")`), per `project-rules.md` §2.

Each script ends with the save of what it produced, and reads any earlier step's product back
from `artifacts_dir` at its top (e.g. `df <- readRDS(file.path(artifacts_dir, "df_trials.rds"))`)
rather than relying on an object left in the environment by a previous `source()`. This keeps every
script runnable on its own in a fresh session — see project-rules.md §2.I.

**`preprocessing/` is the stated exception.** Its `summary_` and `examining_` scripts read the named
datasets the `converting_` script before them left in the environment — `df_collected`, the
`after_*` frames, the excluded-ID vector — because every exclusion count they report has to be the
one the pipeline actually produced, and a count recomputed from a saved file is a second measurement
that can disagree with the first. That folder's scripts are therefore run in `main.R`'s order rather
than individually; `project-rules.md` states the folder structure, `01-preprocessing/template-main.md` defines its paths, and the
`01-preprocessing/references/` how-to files name the datasets each script leaves behind. Open each script with a
one-line note of its two ends, so reading `main.R` shows where the pipeline can be resumed:

```r
# reads: data/processed/df_trials.rds · writes: artifacts/df_stay.rds
```

## Calling external tools (Python, shell)

When a script calls out via `system2()` or similar:

* Escape any path that may contain spaces with `shQuote()`.
* Pass absolute paths to the external process, e.g. `system2("python", args = c(script_path, shQuote(data_path), shQuote(output_dir)))`.
