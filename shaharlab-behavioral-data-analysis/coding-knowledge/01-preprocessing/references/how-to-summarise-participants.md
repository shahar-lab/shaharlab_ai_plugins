# How to write the participants excerpt

## 1. Context for writing you script:

A `preprocessing_excerpt` is a script that generates a manuscript-ready paragraph describing the participants in the analysed sample. Read the processed data, and any demographics file under `data/raw/` or `data/processed/`. Write a paragraph whose Ns and descriptives match those files exactly. Learn the tone and writing style from the example below.

## 2. Rules and guidelines

* This paragraph is the final sample only — the participants who survived exclusions. Exclusion counts and criteria belong in the exclusions excerpt (`how-to-summarise-exclusions.md`).

* Read `data/processed/` (and the demographics table if it is a separate file). Compute every number from those tables. Do not type an N by hand.

* Report overall N and N per group or condition the Job Card names.

* Report only the demographic variables the researcher asked for (age, sex, …). If the Job Card is silent on which descriptives to include, return `BLOCKED`.

* Write one dense narrative paragraph that starts with `Participants.` No headings, tables, or bullet lists.

* Match the tone of the example in section 3: past tense, Ns first, then descriptives.

* Write the paragraph to `output/processed/` as a markdown file. This script does not save data to `data/`.

* Use `tidyverse`. Chain with `|>`. Add any missing `library()` to `main.R`'s `#### SETUP ####` block.

* Keep the script to 50–80 lines.

## 3. Example

The example below shows the style; each N and descriptive in the delivered paragraph is computed from the data:

> *Participants. Forty adults were recruited to the study. After exclusions, the analysed sample comprised 18 participants in the ADHD group (12 female; mean age = 24.3 years, SD = 4.1) and 19 in the control group (11 female; mean age = 23.8 years, SD = 3.7).*
