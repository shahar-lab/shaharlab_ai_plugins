# How to build a data-validation report

A **data-validation** report is a single self-contained HTML file, one per tidy table, written to
`preprocessing/output/`. Its job is to let a human eyeball, in one screen, whether that table left
the converting script with the **classes and value ranges the specification intended** — before any
analysis touches it.

It is a type/domain sanity check. It is not a statistical summary and not an exclusions report:
those are `how-to-examine.md` and `how-to-summarise-exclusions.md`. Do not fold class-and-domain
into the examining Markdown, and do not describe this file as a data dictionary (see
[The dictionary argument](#the-dictionary-argument) below).

`raw/` is where class and values are set and verified
(`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-preprocessing/context.md`). This report is that
verification. A processed table that adds calculated columns can have one as well.

The folder it writes into and the `converting_` prefix it is named under are defined in that same
`context.md`. `tidyverse` (`purrr`, `stringr`, `tibble`, `dplyr`) and `knitr` are loaded in
`main.R`'s `#### SETUP ####`; `output_dir` is defined there. Call functions directly.

## Filename contract

```
preprocessing/output/data-validation-<name>-<suffix>.html
```

- `<name>` — dataset short name, e.g. `trials`, `phq9`, `demographics`, `feedback`
- `<suffix>` — `raw` (default) or `processed`

The same table can legitimately have both `data-validation-phq9-raw.html` and
`data-validation-phq9-processed.html`. Several tidy tables (task, self-report, demographics) mean
several files. Never write two tables into one HTML.

## Anatomy of the rendered page

The page body, in order:

1. `<h1>Data type validation: <name></h1>`
2. `<h2>Head of data (first 10 rows)</h2>`
3. A horizontally scrollable `<div class="scroll-x">` containing **one table**:
   - **Header row** — the column names (standard `kable(..., format = "html")` `<thead>`).
   - **Meta-row 1 — class row.** One cell per column, giving `class(x)[1]`:
     `factor`, `numeric`, `character`, `ordered` …
   - **Meta-row 2 — possible-values row.** One cell per column:
     - numeric column → `[min to max]`, computed with `na.rm = TRUE` (e.g. `[0 to 27]`)
     - column named in `freetext_cols` → empty cell (open-ended prose has no useful domain)
     - any other character/factor → its distinct non-NA values sorted and comma-joined,
       **unless** there are more than 6, in which case `"<n> distinct values"`
       (e.g. `time1, time2` vs `11 distinct values`)
   - **Then the first 10 data rows** (`head(df, 10)`).

Both meta-rows carry `class="meta-row"` and render as a grey italic band directly under the header,
so class + domain sit visually attached to the column names.

Everything is inlined — CSS in a `<style>` block, no external assets, no JS. The file must open
correctly from disk.

See `../assets/example-data-validation.html` for a worked mockup of the rendered page.

## The helper — write it once

Do not write new HTML-generating code per dataset. The format lives in one file,
`preprocessing/code/converting_data_validation.R`, sourced from `main.R`'s `#### SETUP ####` so
every converting script can call it. It is functions, not a numbered pipeline step, so it carries
no two-digit prefix.

Only edit that file when the specification asks to change the report format for **every** dataset
at once. Adding a report for one table is exactly one line at the end of that table's converting
script.

```r
# reads: nothing · writes: nothing on its own; converting scripts call these after typing

#### DATA-VALIDATION HELPERS ####

html_escape <- function(x) {
  x <- gsub("&", "&amp;", as.character(x), fixed = TRUE)
  x <- gsub("<", "&lt;",  x, fixed = TRUE)
  x <- gsub(">", "&gt;",  x, fixed = TRUE)
  x
}

describe_class_row <- function(df) {
  map_chr(df, ~ class(.x)[1])
}

describe_values_row <- function(df, freetext_cols = character()) {
  map_chr(names(df), function(col) {
    x <- df[[col]]
    if (col %in% freetext_cols) {
      return("")
    }
    if (is.numeric(x)) {
      return(paste0("[", min(x, na.rm = TRUE), " to ", max(x, na.rm = TRUE), "]"))
    }
    vals <- sort(unique(as.character(x[!is.na(x)])))
    if (length(vals) > 6) {
      return(paste(length(vals), "distinct values"))
    }
    paste(vals, collapse = ", ")
  })
}

validation_report_css <- "
body { font-family: system-ui, sans-serif; margin: 1.5rem; color: #222; }
h1 { font-size: 1.4rem; margin-bottom: 0.4rem; }
h2 { font-size: 1.05rem; margin: 1.2rem 0 0.5rem; font-weight: 600; }
.scroll-x { overflow-x: auto; }
table { border-collapse: collapse; font-size: 0.85rem; }
th, td { border: 1px solid #ccc; padding: 0.35rem 0.6rem; white-space: nowrap; }
thead th { background: #f4f4f4; text-align: left; }
tr.meta-row td { background: #ececec; font-style: italic; color: #444; }
"

write_data_validation_report <- function(df,
                                         dictionary,
                                         name,
                                         freetext_cols = character(),
                                         suffix = "raw") {
  class_row  <- html_escape(describe_class_row(df))
  values_row <- html_escape(describe_values_row(df, freetext_cols))

  meta_row <- function(cells) {
    paste0(
      '<tr class="meta-row">',
      paste0("<td>", cells, "</td>", collapse = ""),
      "</tr>"
    )
  }

  table_html <- paste(kable(head(df, 10), format = "html"), collapse = "\n")
  table_html <- str_replace(
    table_html,
    "<tbody>",
    paste0("<tbody>\n", meta_row(class_row), "\n", meta_row(values_row))
  )

  html <- c(
    "<!DOCTYPE html>",
    "<html lang=\"en\">",
    "<head>",
    "<meta charset=\"utf-8\">",
    paste0("<title>Data type validation: ", html_escape(name), "</title>"),
    "<style>",
    validation_report_css,
    "</style>",
    "</head>",
    "<body>",
    paste0("<h1>Data type validation: ", html_escape(name), "</h1>"),
    "<h2>Head of data (first 10 rows)</h2>",
    "<div class=\"scroll-x\">",
    table_html,
    "</div>",
    "</body>",
    "</html>"
  )

  filename <- paste0("data-validation-", name, "-", suffix, ".html")
  writeLines(html, file.path(output_dir, filename))
}
```

`dictionary` is accepted and ignored. Do not drop the argument: every call site passes one, and
rendering it later is a helper change, not a per-dataset one.

If the project already defines `write_data_validation_report()`, reuse it. Do not write a second
generator.

## The converting script — one line after typing

Every converting script that produces a tidy table ends with the call, on the in-memory object it
just typed — not on a re-read from disk, so the report describes the same object that was saved.
The report is a side effect of running the pipeline; there is no separate "render the report" step.

```r
#### TYPE COERCION ####
# every column deliberately cast: as.numeric / factor() / ordered factor with explicit levels

saveRDS(df_raw, file = file.path(raw_dir, "data_raw.RDS"))

#### DESCRIBE: DATA DICTIONARY ####
trials_dictionary <- tribble(
  ~column,      ~class,      ~meaning,
  "subject_id", "character", "Participant identifier.",
  "condition",  "factor",    "Levels: control (reference), treatment.",
  "choice",     "factor",    "Levels: left (reference), right.",
  "rt",         "numeric",   "Response time in seconds.",
  "reward",     "numeric",   "Trial reward."
)

write_data_validation_report(df_raw, trials_dictionary, "trials")
```

A processed report is the same shape after `saveRDS` to `processed_dir`, with `suffix = "processed"`
and a dictionary that includes every calculated column.

Several tidy tables split converting by table (`converting_phq9_raw.R`, `converting_demographics_raw.R`,
…), each ending with its own call. A restructuring long enough to break the 50–80 line budget already
belongs in a second `converting_` script named for what it does; that split is what this output type
rides on.

### Type coercion is the substance of the whole exercise

The report only has value if the coercion block above it is deliberate. Patterns live in
`how-to-convert-collected-to-raw.md` and `conversion-and-filter-traps.md`. What this file adds:

- Numeric columns: `as.numeric(...)`.
- Identity/grouping columns: `factor()` or `as.character()`, as the specification says.
- Wave/time: `factor(time, levels = time_levels)` with explicit levels.
- **Ordered categorical scales must be declared ordered, with explicit levels in substantive
  order.** Never let an ordinal scale fall through as plain character; the class meta-row exists
  precisely to catch that:

```r
factor(
  x,
  levels  = c("Not at all", "Several days", "More than half the days", "Nearly every day"),
  ordered = TRUE
)
```

`class(x)[1]` on that column must read `ordered`. An inferred level order, or `ordered` left off,
is a silent failure this report is meant to make visible.

Do not invent a coercion scheme. Intended class and domain for every column come from the
specification. A converting script whose card is silent on a column's class returns `BLOCKED` with
the question phrased about that column, rather than guessing.

### The dictionary argument

Still build the dictionary tibble (it is the human-readable record of what each column means, and
it documents reference levels), and still pass it, for consistency with every other builder. **Do
not tell the user the report "includes a data dictionary" — it does not.** If the specification
asks for the dictionary to appear in the HTML, that is a deliberate change to
`write_data_validation_report()` affecting all datasets at once, and it needs to be flagged as such
rather than done silently.

Dictionary conventions: one row per column, `~column, ~class, ~meaning`. Collapse repeated families
into one row (`"phq9_1...phq9_9"`). State factor levels and which is the reference
(`"Levels: time1 (reference), time2."`).

### `freetext_cols`

Pass `freetext_cols` for genuinely open-ended prose columns so the values meta-row leaves them
blank instead of printing a distinct-count:

```r
write_data_validation_report(
  df_raw,
  feedback_dictionary,
  "feedback",
  freetext_cols = c("task_understanding_text", "feedback_text_response")
)
```

## Wiring into `main.R`

Source the helper from `#### SETUP ####`, before any converting script runs:

```r
source(file.path(code_dir, "converting_data_validation.R"))
```

Add `source(file.path(code_dir, "<your_script>.R"))` to `#### EXECUTE PIPELINE ####` at the correct
position (after any script producing objects you depend on — a processed PHQ9 step sits after the
raw PHQ9 step because it consumes that table). Put a short numbered comment above the `source()`
line in `main.R`'s style, saying what the step builds and which artifacts it writes, including the
HTML path.

Sourced scripts inherit the environment from `main.R`. They must **not** call `library()` and must
**not** redefine paths — `output_dir`, `raw_dir`, `processed_dir`, `collected_dir`, `project_root`
are all already defined there. If a new package is genuinely needed, add it to `main.R`'s
`#### SETUP ####` block. `knitr` is already in `template_main.R`.

## Rules for the code

- Write the HTML to `output_dir` only. The tidy table still saves to `raw_dir` or `processed_dir`.
- Call `write_data_validation_report()` on the in-memory typed frame, immediately after the save.
- Reuse the helper. A second HTML generator in a dataset script is the wrong split.
- Chain operations with the base pipe `|>`, and call functions directly.
- Keep each dataset's converting script to 50–80 lines. The helper's length is the format, not a
  pipeline step to split.
- Where a choice is not determined by the data or by the specification, mark it
  `# ASSUMED[no criterion given]: ...`

## What comes next

| Script | File |
|---|---|
| `examining_data_raw.R` / `examining_data_processed.R` | `how-to-examine.md` |
| `converting_data_raw_to_processed.R` | `how-to-convert-raw-to-processed.md` |
