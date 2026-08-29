# The R traps a preprocessing pipeline invites

Read this alongside the `how-to-` file for the script you are writing. These are the places where R
does something other than what the code appears to say, and where the result is wrong data rather than
an error. Every one of them runs silently: the script completes, the numbers look plausible, and the
mistake reaches the manuscript as a participant count.

## Typing a column

- **Give `as.Date()` an explicit `format`.** Without one it assumes a default that may not match the
  data, and a mismatched format yields `NA` rather than an error.
- **Give `factor()` explicit `levels`**, and `ordered = TRUE` where the variable is ordered. Inferred
  levels come from whatever values happen to appear, so two files of the same study can produce two
  different level orders.
- **Convert the string `"NA"` to a real `NA` before `as.numeric()`.** So too `"NULL"`, `"N/A"`,
  `"None"`, and `"."`. `as.numeric()` turns anything it cannot parse into `NA` with a warning, so a
  column of numbers stored as text arrives silently emptied.
- **Report the `NA` count before and after each coercion.** A coercion that quietly created a hundred
  missing values is visible in that one number and invisible everywhere else.

## Filtering

- **Use `%in%` to exclude a set of categories.** `!=` chained with `&` removes everything:
  `filter(status != "control" & status != "treatment")` keeps only rows that are neither, which on a
  two-level column is none of them. Write `filter(!status %in% c("control", "treatment"))`.
- **Check `complete.cases()` against the columns the analysis needs**, naming them. Run over the whole
  frame it drops rows on columns that do not matter; run over too few it keeps rows the model cannot
  use.
- **Report `nrow()` before and after every filter.** The exclusion cascade is built from those
  differences, and a filter whose effect is never printed is one nobody can check.
- **Hold each cutoff in a named variable set once in `main.R`**, and use that variable in both the
  filter and the report text. A literal repeated in two places is how a pipeline comes to filter at one
  number and report another.

## Deriving a variable

- **Wrap `scale()` in `as.numeric()`.** It returns a matrix with attributes, so the bare result carried
  into a data frame column behaves unlike the numeric vector the rest of the code expects.
- **Give `cut()` explicit `labels`**, and check the boundary cases. Without labels the factor levels
  are the breakpoints themselves, and `right = TRUE` (the default) puts a value exactly on a breakpoint
  in the lower bin — which is an off-by-one on every participant sitting on the line.
- **Report the new variable's `NA` count** and account for it from upstream missingness. An `NA` that
  the inputs do not explain means the formula is wrong.

## Reading your own output

Print enough that the numbers can be checked:

- `nrow()` at each stage, so the cascade adds up
- `colSums(is.na(df))` on the final frame — zero where the data should be complete, and a count you can
  explain where it should not
- `str(df)` at the end, showing the classes, factor levels, date formats, and ranges the next stage
  assumes

A pipeline that removes a large share of the data while columns still carry missing values has usually
filtered on something other than what was intended. Treat that combination as a signal to re-read the
filter chain before saving.
