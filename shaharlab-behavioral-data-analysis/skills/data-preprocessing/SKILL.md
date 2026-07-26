---
name: data-preprocessing
description: Shahar Lab preprocessing workflow in R - builds data/raw and data/processed from data/collected, produces a data-quality PDF and a manuscript-ready exclusions paragraph. Use when the user asks to clean, reshape, exclude, score, or validate behavioral data before analysis.
---

# Skill: Data Preprocessing & Validation

**🛑 MANDATORY WORKFLOW — Two-pass system (build, then review) for pristine data preparation.**

## When to Invoke
Use this skill automatically when the user requests help with:
* Data cleaning and preprocessing
* Trial/subject exclusions and quality checks
* Variable type validation and correction
* **Triggers:** "preprocess", "clean data", "prepare data", "filter data", "exclusions", "data quality", "data validation"

## Folder Structure (fixed)

Matches `${CLAUDE_PLUGIN_ROOT}/skills/project-scaffolding/references/folder_structure.md` (the single source of truth for lab topology):

```
preprocessing/          # data cleaning scripts
├── code/               # unnumbered R scripts (one job per script)
├── output/             # data-quality PDF, manuscript paragraph .md
└── main.R              # orchestrator: sources code/ scripts in order

data/
├── collected/          # data exactly as it arrived — NEVER modified
├── raw/                # collected data restructured to a tidy standard format
└── processed/          # raw data after user-defined exclusions
```

`main.R` is the single entry point: running it rebuilds `data/raw/`, `data/processed/`, and everything in `preprocessing/output/` from `data/collected/`. Start from the template at `assets/template_main.R`.

## Pipeline Steps (in order)

1. **Understand collected data** — explore `data/collected/` (see `workflow/EXPLORATION.md`). It is read-only.
2. **Define raw structure** — agree with the user on how `data/raw/` should be structured (one row per trial, column names, types), then write the script that builds it.
3. **Data-quality PDF** → `preprocessing/output/`. Must include at least:
   * number of aborted / no-response trials per subject
   * an RT summary table with one row per subject
4. **Build processed data** — apply the exclusion rules **the user defines** (e.g., trials with no response or RT < X ms / > Y ms; subjects exceeding user-set thresholds) and write `data/processed/`.

**🛑 Exclusion criteria come from the user, never from you.** Do not pick RT cutoffs, percentage thresholds, or any exclusion rule on your own — ask the user and get explicit values before writing the exclusion code.
5. **Manuscript paragraph** — write a single "Data treatment" paragraph to a `.md` file in `preprocessing/output/`, stating quality criteria, how many subjects were excluded and why, trial-level exclusion percentages, and final trial counts per group (see `workflow/ARCHITECT-INSTRUCTIONS.md` for the style example).

## The Two Passes

* **Build pass (Code Architect):** explores collected data, proposes the raw structure and exclusion plan — **user approves before code is written** — then writes the scripts in `preprocessing/code/` and `main.R` (per `workflow/ARCHITECT-INSTRUCTIONS.md`).
* **Review pass (Code Reviewer):** checks the pipeline line by line for data loss, wrong coercions, and filtering errors; confirms outputs regenerate from `main.R` (per `workflow/REVIEW-INSTRUCTIONS.md`). Issues → revise → re-review until clean.

## Quick Reference

| Task | Read This |
|------|-----------|
| How do I explore collected data? | `workflow/EXPLORATION.md` |
| How do I write preprocessing code? | `workflow/ARCHITECT-INSTRUCTIONS.md` |
| How do I review preprocessing? | `workflow/REVIEW-INSTRUCTIONS.md` |
