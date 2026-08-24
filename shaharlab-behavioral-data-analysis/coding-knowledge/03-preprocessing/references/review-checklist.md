# Preprocessing Review Checklist

Verify that the preprocessing code is correct, catches its errors, and delivers analysis-ready data.

## Which script each phase lands on

`preprocessing/code/` holds three kinds of script, named by prefix
(`01-folder-specific-rules/preprocessing/rules.md`). Review each phase against the script that does
that job:

| Phase | Script |
|---|---|
| 2 · Type conversions | `converting_data_collected_to_raw.R` |
| 3 · Filtering logic | `converting_data_raw_to_processed.R` |
| 4 · Transformations & derived variables | whichever `converting_` script creates them |
| 5 · Validation output | the `examining_` scripts and their reports |
| 1, 6 · Structure and readiness | the whole folder, `main.R` included |

## Phase 1 — Structure

- Every script in `preprocessing/code/` starts with `converting_`, `examining_`, or `summary_`
  (`01-folder-specific-rules/preprocessing/rules.md`, "Naming the scripts").
- Each script does only the job its prefix names — `converting_` saves data to `data/`, `examining_`
  and `summary_` write their reports to `preprocessing/output/`.
- `main.R` sources them in pipeline order, so reading it top to bottom is the full account of the
  preprocessing.
- Section comments mark each step, and each major operation is documented in one line.
- The code prints validation output — row counts, before/after.
- The work is straight-line `dplyr`/`tidyr` with named intermediate objects, per
  `00-constitution/coding-rules.md`. A custom `function()` or an `apply`-family call in place of a
  named object is a finding.

## Phase 2 — Type conversions

For each `as.*()` conversion, check the source column for values that will fail or convert silently
before checking the target type is right for the analysis:

- `as.numeric()` on a character column containing `"NA"` or similar strings turns them into `NA`
  without warning — the code must handle those strings first.
- `as.Date()` needs an explicit `format`; without one it assumes a default that may not match the data.
- `factor()` needs explicit `levels` (and `ordered =` where the variable is ordered) — without them
  the levels are inferred from whatever values happen to appear.

## Phase 3 — Filtering logic

- Every participant-level criterion runs before every trial-level criterion, and each step filters the
  previous step's named dataset — the chain is recoverable from the object names alone
  (`after_no_response`, `after_rt_bounds`). A third exclusion kind (session-level, block-level, …) sits
  where the approved plan put it.
- Each cutoff is a named variable set once from the approved plan, used identically in the filter and
  in the report's criterion text — never a literal repeated in two places.
- Every criterion matches one row of `participant_exclusions` / `trial_exclusions` in the approved plan,
  and every cutoff was given by the user, not chosen by the Writer.
- `%in%` excludes a category; `!=` chained with `&` does not (`filter(status != "control" & status !=
  "treatment")` removes everything — a finding).
- `complete.cases()` is checked against the columns the analysis actually needs — not too restrictive
  (dropping rows on a column that does not matter) and not too lenient (missing a column that does).
  Report `nrow()` before and after so the removal is visible, not just present.

**For an online study, verify the window-exit count** (`handling-leaving-window.md`):

- The count counts **exits** — trials where `window_status == "left"` and the previous trial was
  `ok` — not every `left` trial. `sum(window_status == "left")` used directly is a finding.
- The data is `arrange()`d by participant and trial order, under `group_by(subject_id)`, before the
  `lag()` — otherwise "the previous trial" is not this participant's previous trial.
- `lag()` carries `default = FALSE`, so a participant already away on trial 1 is counted.
- The filter and `summary_exclusions.md` both read `window_exit_max` from `main.R` — the same variable,
  not two copies of the same number.

## Phase 4 — Transformations & derived variables

For each derived variable: does it match the approved plan, is the formula and breakpoint correct, and
is the result validated rather than assumed?

- `scale()` returns a matrix — extracting a plain vector needs `as.numeric(scale(x))`.
- `cut()` needs explicit `labels`; without them the factor levels are the breakpoints themselves; check
  for off-by-one errors at the boundaries.
- A new variable's `NA` count is reported and matches what upstream missingness would produce — an
  unexplained `NA` is a finding.

## Phase 5 — Validation output

Read the printed output the code produces:

- `nrow()` before and after each filter roughly matches the plan; unexplained loss is a finding.
- `colSums(is.na(data_clean))` matches expectation — zero where the plan expects complete data, a
  reasonable count where missingness is expected.
- `str(data_clean)` shows the intended classes, factor levels, date formats, and numeric ranges.

A result that removes a large share of the data (say, half) while columns still carry missing values
is a red flag on its own — ask what happened between the filter and the report.

## Phase 6 — Final readiness

- Data types suit the planned statistical tests; ranges are possible; sample size after filtering is
  enough for the analysis.
- Every preprocessing decision — why this filter, why this threshold — is traceable to the approved
  plan or an `ASSUMED` tag, not left implicit.
- `data/collected/` is untouched, `data/raw/` and `data/processed/` hold the outputs, and running
  `preprocessing/main.R` alone rebuilds everything from `data/collected/`.
- All deliverables are present, with computed (not hand-typed) numbers:
  - `data/raw/data_raw.RDS`, `data/processed/data_processed.RDS`
  - `examining_data_raw.md` and `examining_data_processed.md` — rows kept/dropped, numeric columns,
    categorical columns, sample overview, per-design-cell, per-participant. Both use the same
    description blocks against their own stage's data, so the two read side by side column-for-column,
    and each names the script that wrote it.
  - `summary_exclusions.md` — participant-exclusion table, then trial-exclusion table, then the final
    count
  - `summary_manuscript_paragraph.md`
- Downstream analysis code can load the processed data without modification.

## Verdict

`PASS` needs every phase above clear and no `REVIEW` tag left in any target file. Tag findings in place,
citing the phase and the specific check, per `agents/code-reviewer.md` §4 — this file is what you cite,
not what you restate.

Style differences that do not violate `coding-rules.md`, efficiency, an alternative approach that also
works, and commented-out code are not findings — flag correctness and rule violations, not preference.
