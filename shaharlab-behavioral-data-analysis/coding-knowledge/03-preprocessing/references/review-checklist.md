# Preprocessing QA & Verification Guide (Review Pass)

**This is the review pass (Code Reviewer role).** Your job is to verify that the Architect's preprocessing code is correct, catches all errors, and delivers analysis-ready data.

## Which script each phase lands on

`preprocessing/code/` holds three kinds of script, named by prefix
(`01-folder-specific-rules/preprocessing/rules.md`). Review each phase below against the script
that does that job:

| Phase | Script |
|---|---|
| 2 · Type conversions | `converting_data_collected_to_raw.R` |
| 3 · Filtering logic | `converting_data_raw_to_processed.R` |
| 4 · Transformations & derived variables | whichever `converting_` script creates them |
| 5 · Validation output | the `examining_` scripts and their reports |
| 1, 6 · Structure and readiness | the whole folder, `main.R` included |

## Your Core Competencies

1. **Read Preprocessing Code** — Understand intent and logic flow
2. **Spot Errors** — Catch type coercions that fail silently, filtering mistakes, data loss issues
3. **Validate Assumptions** — Verify that resulting data matches analysis requirements
4. **Think Like a Statistician** — Question whether the data is truly ready for analysis
5. **Give Actionable Feedback** — Be specific when requesting corrections

## Systematic Review Checklist

### ✅ PHASE 1: Code Structure & Clarity

- [ ] Does every script in `preprocessing/code/` begin with `converting_`, `examining_`, or
      `summary_` (`01-folder-specific-rules/preprocessing/rules.md`, "Naming the scripts")?
- [ ] Does each script do only the job its prefix names — `converting_` saves data to `data/`,
      `examining_` and `summary_` write their reports to `preprocessing/output/`?
- [ ] Does `main.R` source them in pipeline order, so reading it top to bottom is the full
      account of the preprocessing?
- [ ] Does the code use `project_root <- here::here()`?
- [ ] Are all file paths constructed with `file.path()`?
- [ ] Is the code organized with clear section comments (Step 1, Step 2, etc.)?
- [ ] Are major operations documented (what does this filter do)?
- [ ] Does the code print validation output (row counts, before/after)?
- [ ] Is the work done in straight-line `dplyr`/`tidyr` code with named intermediate
      objects, per `00-constitution/coding-rules.md`? (Report tables and exclusion steps
      belong in named objects, so a custom `function()` or an `apply`-family call is a
      finding to report.)

**If any fail:** Request clarification or restructuring.

---

### ✅ PHASE 2: Type Conversions (Critical)

For each `as.*()` conversion in the Architect's code:

1. **Check the source column type:**
   - Is it already the target type? (unnecessary conversion?)
   - Does it contain values that will fail or warn?
   - Are "NA" strings being handled first?

2. **Verify the target type:**
   - Is the intended type correct for the analysis?
   - Are factors specified with explicit `levels` and `ordered = TRUE/FALSE`?
   - Are dates using the correct format string?

3. **Look for silent failures:**
   - `as.numeric()` on character with non-numeric values → generates NAs silently
   - `as.Date()` with wrong format → generates NAs silently
   - `as.logical()` on character values → may not work as expected

**Example red flags:**

```r
# ❌ BAD: String contamination not handled
score <- as.numeric(score)  # If score contains "NA" strings, they become NAs silently

# ✅ GOOD: Explicit handling
score <- ifelse(score %in% c("NA", "."), NA_real_, score)
score <- as.numeric(score)

# ❌ BAD: Factor without levels
group <- factor(group)  # Levels inferred from data; may be unordered

# ✅ GOOD: Factor with explicit levels
group <- factor(group, levels = c("control", "treatment"))

# ❌ BAD: Date with ambiguous format
visit_date <- as.Date(visit_date)  # Assumes default format

# ✅ GOOD: Date with explicit format
visit_date <- as.Date(visit_date, format = "%Y-%m-%d")
```

---

### ✅ PHASE 3: Filtering Logic (Critical)

1. **Check the phase order:**
   - Does every participant criterion (whole-subject removal) run before every trial
     criterion?
   - Does each criterion filter the survivors of the criterion before it — i.e. does each
     step take the previous step's named dataset as its input?
   - Does each surviving dataset have its own name (`after_no_response`, `after_rt_bounds`),
     so the report's counts are recoverable by comparing two named objects?
   - If a third exclusion kind is present (session-level, block-level, …), does its
     position match where the approved plan put it?

2. **Understand the intent, per criterion:**
   - Why is this filter needed?
   - Does it match the exclusion criteria in the Architect's plan, one criterion per row of
     `participant_exclusions` / `trial_exclusions`?
   - Is each cutoff held in a named variable set once from the approved plan, and is that
     same variable used in both the filter and the report's criterion text?

3. **Check the logic:**
   - Are conditions using `&` (AND) or `|` (OR) correctly?
   - Are comparisons `<`, `<=`, `>`, `>=`, `==`, `!=` as intended?
   - Are `is.na()` and `!is.na()` used correctly?

4. **Estimate impact:**
   - Roughly how many participants and how many rows will be removed by each criterion?
   - Is this data loss acceptable?
   - Are there unexpected interactions between criteria?

5. **For an online study, verify the window-exit count** (`handling-leaving-window.md`):
   - Does the count return **exits** rather than flagged trials — i.e. does it count the trials
     where `window_status == "left"` and the previous trial was `ok`, rather than every `left`
     trial? A count of `sum(window_status == "left")` used as the number of exits is a finding.
   - Is the data `arrange()`d by participant and trial order before the `lag()`, and
     `group_by(subject_id)` in force, so "the previous trial" is this participant's previous trial?
   - Does `lag()` carry `default = FALSE`, so a participant already away on trial 1 has that exit
     counted?
   - Does the filter compare against `window_exit_max` from `main.R`, and does
     `summary_exclusions.md` quote that same variable?

6. **Verify complete.cases():**
   - If the Architect uses `complete.cases(var1, var2, var3)`, does it match the analysis plan?
   - Is it too restrictive? (removing rows with ANY missing in those three)
   - Is it too lenient? (ignoring missing in other important variables)

**Example red flags:**

```r
# ❌ BAD: Logic error (AND instead of OR)
data_clean |>
  filter(age >= 18 & age <= 65)  # This is correct actually, but the next one is wrong:
  
# ❌ BAD: Wrong operator for category exclusion
data_clean |>
  filter(status != "control" & status != "treatment")  # Removes everything! Use %in%

# ✅ GOOD:
data_clean |>
  filter(!status %in% c("control", "treatment"))

# ❌ BAD: Doesn't check for data loss
data_clean |> filter(complete.cases(age, score))  # How many rows removed? Unknown.

# ✅ GOOD: Explicit count
n_before <- nrow(data_clean)
data_clean <- data_clean |> filter(complete.cases(age, score))
n_removed <- n_before - nrow(data_clean)
cat("Removed:", n_removed, "rows with missing age or score\n")
```

---

### ✅ PHASE 4: Transformations & Derived Variables

For each new variable created:

1. **Verify intent:**
   - Why is this derived variable needed?
   - Does it match the Architect's preprocessing plan?

2. **Check the math:**
   - Is the formula correct?
   - Are there off-by-one errors?
   - Does `cut()` use correct breakpoints?
   - Does `scale()` produce expected output (mean ≈ 0, sd ≈ 1)?

3. **Validate output:**
   - What is the class of the new variable?
   - Are there any unexpected NAs introduced?
   - Does the distribution look reasonable?

**Example checks:**

```r
# ❌ BAD: scale() returns a matrix with attributes; extracting [, 1] may be wrong
score_z <- scale(score)  # This is a matrix!

# ✅ GOOD: Explicitly extract and coerce to vector
score_z <- as.numeric(scale(score))

# ❌ BAD: cut() creates factor; order may be unintuitive
age_group <- cut(age, breaks = c(18, 30, 50, 85))

# ✅ GOOD: use labels for clarity
age_group <- cut(age, breaks = c(18, 30, 50, 85), 
                 labels = c("18-30", "30-50", "50-85"))

# ❌ BAD: derived variable has unexpected NAs
bmi <- weight_kg / (height_m ^ 2)  # If height_m is NA, bmi is NA (ok, but check)

# ✅ GOOD: Document expectation
bmi <- weight_kg / (height_m ^ 2)
cat("NAs in BMI:", sum(is.na(bmi)), "(expected from missing height)\n")
```

---

### ✅ PHASE 5: Validation Output

Inspect the printed output from the Architect's code:

1. **Row counts:**
   - Does `nrow(raw_data)` match your expectation?
   - Does `nrow(data_clean)` decrease by roughly the amount filtered out?
   - Is any data loss suspicious or unexplained?

2. **Missing values:**
   - Does `colSums(is.na(data_clean))` match expectations?
   - If all missing values should be zero, does it show that?
   - If missing values are expected in certain columns, is the count reasonable?

3. **Variable types:**
   - Does `str(data_clean)` show the correct classes?
   - Are factors showing expected levels?
   - Are dates showing correct format?
   - Are numeric variables showing reasonable ranges?

**Example output inspection:**

```
Raw data:  100 rows
Clean data: 94 rows
Rows removed: 6
Missing values:
     age   gender    score 
       0        0        0
```

✅ Good: All expected missing values removed, row count matches filtering plan.

```
Raw data:  100 rows
Clean data: 50 rows
Rows removed: 50
Missing values:
     age   gender    score
       5       10       15
```

❌ Red flag: 50 rows removed (half the data!) and STILL has missing values. Request clarification on filtering strategy.

---

### ✅ PHASE 6: Final Data Readiness

Before approving, ask:

1. **Is the data suitable for the intended analysis?**
   - Are variable types correct for planned statistical tests?
   - Are ranges reasonable? (no impossible values)
   - Is sample size sufficient after filtering?

2. **Have all preprocessing decisions been documented?**
   - Can another analyst understand WHY each filter was applied?
   - Are there data quality decisions that should be noted?

3. **Is the output in analysis-ready format?**
   - Data files saved in `data/raw/` and `data/processed/`; reports in `preprocessing/output/`?
   - Does running `preprocessing/main.R` alone rebuild everything from `data/collected/`?
   - Was `data/collected/` left untouched?
   - Are all deliverables present, all with computed (not hand-typed) numbers?
     - `data/raw/data_raw.RDS` and `data/processed/data_processed.RDS`
     - `examining_data_raw.md` — rows kept/dropped, numeric columns, categorical columns,
       sample overview, per-design-cell, per-participant
     - `examining_data_processed.md` — the same description tables on the processed data
     - `summary_exclusions.md` — participant-exclusion table, then trial-exclusion table,
       then the final count
     - `summary_manuscript_paragraph.md`
   - Do the two `examining_` reports use the same description blocks against their own stage's
     data, so their tables line up column-for-column and can be read side by side?
   - Does each report carry the name of the script that wrote it, so the two are found from
     each other?
   - Was every exclusion criterion (RT cutoffs, thresholds) explicitly given by the user, not invented by the architect?
   - Can downstream analysis code load the processed data without modification?

---

## How to Report Findings

### When code is ✅ CLEAN:

```
REVIEW COMPLETE: APPROVED ✅

Summary:
- All type conversions handle string contamination
- Filtering logic is sound and removes expected rows
- 6 rows removed (within plan); 0 missing values remain
- New variables correctly constructed
- Output saved to data/processed/data_processed.RDS

Status: Data is analysis-ready.
```

### When code has ❌ ISSUES:

```
REVIEW INCOMPLETE: ISSUES FOUND ❌

Issue 1: Silent NA creation in score conversion
- Line 15: score <- as.numeric(score)
- Problem: If score contains "NA" strings, they silently become NAs
- Fix: Explicitly handle before conversion (see `how-to-convert-collected-to-raw.md`)

Issue 2: Over-filtering on missing values
- Line 28: filter(complete.cases(age, gender, score, region))
- Problem: 45 rows removed; only 55 remain. Is this expected?
- Clarification needed: Does region NEED to be complete?

Issue 3: Derived variable not validated
- Lines 35-36: age_group <- cut(age, ...)
- Problem: No check for NAs in output; no documentation of levels
- Fix: Add cat("NAs in age_group:", sum(is.na(age_group)), "\n")

Action: the Architect, please revise and resubmit. Reply with updated code.
```

---

## What NOT to Worry About

- Minor code style differences (the Architect's code is fine if it works)
- Efficiency optimizations (we care about correctness first)
- Alternative approaches that also work (if the Architect's works, don't request rewrites)
- Commented-out code (leave it if the Architect includes it)

## Quick Checklist (Printable)

```
☐ PHASE 1: Script prefixes are converting_/examining_/summary_, one job each; uses project_root
☐ PHASE 2: Type conversions are explicit and handle edge cases
☐ PHASE 3: Filtering logic is sound and row loss is documented
☐ PHASE 4: Derived variables are correct and validated
☐ PHASE 5: Validation output looks reasonable
☐ PHASE 6: Data is analysis-ready

Result: ☐ APPROVED  ☐ NEEDS REVISION
```
