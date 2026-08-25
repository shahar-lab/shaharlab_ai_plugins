# How to write the `summary_` scripts

A `summary_` script reports for the researcher and for the manuscript. Two come out of this file:

| Script | Writes | Says |
|---|---|---|
| `summary_exclusions.R` | `output/summary_exclusions.md` | the exclusion cascade as tables, one row per criterion |
| `summary_manuscript_paragraph.R` | `output/summary_manuscript_paragraph.md` | the same numbers as a "Data treatment" paragraph |

Both run after `converting_data_raw_to_processed.R` and read the named datasets it left in the
environment, so every number they report is the number the pipeline actually produced. The folder
they write into and the three prefixes they are named under are defined in
`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-folder-specific-rules/preprocessing/rules.md`.

## `summary_exclusions.R`

One table per exclusion phase, one row per criterion in the order it ran, giving the criterion in
the user's own words, how many it took out, that count as a percentage of what reached it, and how
many remain. Then the final N.

Each row's counts come from the named datasets in the converting script — `n_omitted` from the
difference between two of them, `n_remaining` from the later one — so a criterion cannot be
reported with a number the filter did not produce. The first row of each table is the phase's
starting point, with no criterion of its own.

```r
#### SUMMARISE EXCLUSIONS ####

participant_exclusions <- tibble(
  criterion = c("Starting point (raw)",
                "Did not complete the session",
                paste0("More than ", max_pct_fast_rt, "% of RTs under ", rt_min_sec, " s")),
  n_omitted = c(NA_integer_,
                length(incomplete_subjects),
                length(fast_rt_subjects)),
  n_remaining = c(n_distinct(df$subject_id),
                  n_distinct(after_incomplete$subject_id),
                  n_distinct(after_fast_rt$subject_id))
) |>
  mutate(pct_omitted = round(100 * n_omitted / lag(n_remaining), 1))

trial_exclusions <- tibble(
  criterion = c("Starting point (after participant exclusions)",
                "No response recorded",
                paste0("RT under ", rt_min_sec, " s or over ", rt_max_sec, " s")),
  n_omitted = c(NA_integer_,
                nrow(after_fast_rt)     - nrow(after_no_response),
                nrow(after_no_response) - nrow(after_rt_bounds)),
  n_remaining = c(nrow(after_fast_rt), nrow(after_no_response), nrow(after_rt_bounds))
) |>
  mutate(pct_omitted = round(100 * n_omitted / lag(n_remaining), 1))

report_lines <- c(
  "# Exclusion summary", "",
  "Built by `preprocessing/code/summary_exclusions.R` from the named datasets in",
  "`converting_data_raw_to_processed.R`. Participant criteria run first, then trial",
  "criteria on the participants that remain. Each row filters the row above it.", "",
  "## Participant exclusions (counts in participants)", "",
  kable(participant_exclusions, format = "pipe"), "",
  "## Trial exclusions (counts in observations)", "",
  kable(trial_exclusions, format = "pipe"), "",
  paste0("**Final: ", format(nrow(df_processed), big.mark = ","),
         " observations across ", n_distinct(df_processed$subject_id),
         " participants.**")
)
writeLines(report_lines, file.path(output_dir, "summary_exclusions.md"))
```

Participant tables count participants and trial tables count observations, so each table's heading
states its unit. Render with `kable(x, format = "pipe")`; `main.R` sets
`options(knitr.kable.NA = "")` once, so the starting row's empty cells come out blank.

The description tables for the surviving sample live in `examining_data_processed.R`'s report, and
the two files are read together.

See `../assets/example-summary-exclusions.md` for a worked example of the rendered output.

## `summary_manuscript_paragraph.R`

A single "Data treatment" paragraph, written to `output/summary_manuscript_paragraph.md`, with
every number computed from the data by the script rather than typed by hand. Assemble it with
`paste0()` over the same objects `summary_exclusions.R` reads, so the paragraph and the tables can
never disagree.

The example below shows the style; each criterion and cutoff in the delivered paragraph is the
user's own value:

> *Data treatment. During data preprocessing, we first examined the quality of the behavioral data.
> Poor quality was defined by having either (a) more than 20% excluded trials due to no response,
> implausibly fast or implausibly slow reaction times (RTs < 0.2 sec or > 4 sec), or (b) selecting
> the same response key in over 90% of trials within a block. Due to this examination, two
> participants from the ADHD group and one from the control group were excluded. Furthermore, due to
> a technical error, the data of one participant in the ADHD group was not submitted and the
> participant was therefore excluded. From the remaining behavioral observations we omitted trials
> with no response (<1% of all trials), and trials with implausibly quick reaction times (< 0.2 sec)
> or exceptionally slow reaction times (> 4 sec; <1% of all trials). This resulted in 8,717 trials
> for the ADHD group (198.11 mean trials per participant) and 8,661 trials for the control group
> (196.84 mean trials per participant).*

## Rules for the code

- Read the named datasets from the environment `main.R` sources into — `df`, `after_*`, the
  excluded-ID vectors, and `df_processed` — which is where every number here comes from.
- Write to `output_dir`; a script that saves data to `data/` is a `converting_` script.
- Quote each criterion using the same `main.R` cutoff variable the filter used, so the reported
  criterion text and the filter agree by construction.
- Compute every count from the datasets themselves, so each number recomputes when the data
  changes.
- Chain operations with the base pipe `|>` and named intermediate objects, calling functions
  directly and adding any missing package's `library()` call to `main.R`'s `#### SETUP ####` block.
- Keep each script to 50–80 lines.
