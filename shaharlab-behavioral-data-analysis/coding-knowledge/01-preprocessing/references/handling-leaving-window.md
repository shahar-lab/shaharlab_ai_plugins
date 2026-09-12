# Handling leaving the window

In an online study the participant can walk away from the screen at any moment — switch tabs, click
another window, drop out of fullscreen — and the task keeps running. How often that happened is a
data-quality measure the lab counts for every participant, and it is one of the participant-level
criteria the exclusion plan can act on.

This file covers counting the exits and excluding on the count. The lab's experiment code is what
records them: `shaharlab-jspsych`'s `skills/jspsych-coding-style/references/validity_checks/window-monitoring.md`
defines the columns this file reads, so the two describe the same measure from the two ends.

The count informs; the researcher decides. The cutoff is the user's number, given in the interview,
and this file never supplies one.

**When this file is routed.** Add it to the Code-Writer Card when any of these holds: the study ran in a browser (Pavlovia, Prolific, MTurk, or any online sample); `data/collected/` carries a `window_status` / `window_left_ms` column, or rows marked `event_type == "attention_event"`; the user mentions leaving the window, tab switching, losing focus, fullscreen exits, or being away from the screen. Route it on an in-person or non-browser study only if the user asks.

## What the collected data carries

The task stamps two columns on **every trial row**:

| Column | Values | Meaning |
|---|---|---|
| `window_status` | `ok` / `left` | `left` when the participant was away at any point during that trial |
| `window_left_ms` | integer ≥ 0 | milliseconds away during that trial; `0` whenever `window_status` is `ok` |

`window_status` is the column this file counts from. Keep both columns through
`converting_data_collected_to_raw.R` and type them there — `window_status` as a factor with levels
`c("ok", "left")`, `window_left_ms` as numeric.

Studies that also export the event-level audit trail carry extra rows marked
`event_type == "attention_event"`, one per fullscreen exit, tab hide, or window blur. Those rows are
events rather than trials, so `converting_data_collected_to_raw.R` drops them from the trial table
in `data/raw/` unless the plan asks for them as a second table.

## One exit is one sequence, not one trial

A participant who leaves for half a minute comes back to find three trials marked `left`. That is
**one** exit, not three. Count the *starts*: a trial begins a new exit when it is marked `left` and
the trial before it, for the same participant, was `ok`.

| trial | `window_status` | starts a new exit? |
|---|---|---|
| 1 | `ok` | |
| 2 | `left` | ✓ exit 1 |
| 3 | `left` | — same exit |
| 4 | `left` | — same exit |
| 5 | `ok` | |
| 6 | `left` | ✓ exit 2 |

This participant has `trials_left = 4` and `n_window_exits = 2`. Both numbers are worth reporting,
and they answer different questions: `trials_left` is how much data was affected, `n_window_exits` is
how many times the participant's attention went elsewhere. An exclusion criterion on "how many times
did they leave" is a criterion on `n_window_exits`.

## Counting it

```r
window_exits_per_subject <- df |>
  arrange(subject_id, trial_number) |>
  group_by(subject_id) |>
  mutate(
    left_window = window_status == "left",
    exit_starts = left_window & !lag(left_window, default = FALSE)
  ) |>
  summarise(
    n_window_exits = sum(exit_starts),
    trials_left    = sum(left_window),
    time_away_s    = round(sum(window_left_ms) / 1000, 1)
  ) |>
  arrange(desc(n_window_exits))
```

Three things make this correct, and each is a place it silently goes wrong when skipped:

- **`arrange(subject_id, trial_number)`** — "the trial before it" only means anything in trial order.
  Sort first, using whatever column holds trial order in this study.
- **`group_by(subject_id)`** — keeps `lag()` inside one participant, so participant B's first trial
  is compared against `FALSE` rather than against participant A's last trial.
- **`lag(left_window, default = FALSE)`** — treats the first trial as preceded by `ok`, so a
  participant who was already away on trial 1 gets that exit counted.

## The cutoff in `main.R`

The criterion is a maximum number of exits a participant may have and still be included. It lives in
`main.R`'s SETUP block beside the other cutoffs, so the filter and the report that quotes it read the
same variable:

```r
# Exclusion cutoffs — one variable per criterion, each holding the value the user
# approved in the interview.
rt_min_sec      <- 0.2   # the user's value
rt_max_sec      <- 4     # the user's value
max_pct_fast_rt <- 15    # the user's value
window_exit_max <- NA_integer_   # the user's value: most window exits a participant may have
```

Leave it `NA_integer_` until the user gives the number. A pipeline that reaches the filter with `NA`
excludes nobody, and that shows up immediately in `summary_exclusions.md` as a criterion that removed
zero participants — the safe direction, and a visible one.

A cutoff the Code-Writer Card is silent on is a decision nobody has made. Return `BLOCKED` with the
question phrased about the study, as `how-to-convert-raw-to-processed.md` sets out:

> BLOCKED: no cutoff was given for how many times a participant may leave the study window.

## Excluding on it

Leaving the window removes a whole participant, so it is a **participant-phase** criterion in
`converting_data_raw_to_processed.R`, filtering the survivors of the criterion before it and naming
its own surviving dataset like every other step:

```r
window_exit_subjects <- window_exits_per_subject |>
  filter(n_window_exits > window_exit_max) |>
  pull(subject_id)

after_window_exits <- after_incomplete |>
  filter(!subject_id %in% window_exit_subjects)
```

Where the plan puts this criterion among the participant criteria is the plan's call — it filters
whatever named dataset precedes it, and hands its own name to the criterion after it.

`summary_exclusions.R` then reports it as one row of the participant table, quoting the cutoff from
the same variable:

```r
criterion   = paste0("Left the study window more than ", window_exit_max, " times"),
n_omitted   = length(window_exit_subjects),
n_remaining = n_distinct(after_window_exits$subject_id)
```

## Where each piece lands

| Script | What it does with the window columns |
|---|---|
| `converting_data_collected_to_raw.R` | keeps and types `window_status` and `window_left_ms`; drops the `attention_event` audit rows from the trial table |
| `examining_data_raw.R` | adds `n_window_exits`, `trials_left`, and `time_away_s` to its per-participant table, so the user sees the distribution *before* choosing a cutoff |
| `converting_data_raw_to_processed.R` | counts the exits, then excludes on `window_exit_max` in the participant phase |
| `summary_exclusions.R` | one participant-table row, quoting `window_exit_max` |
| `summary_manuscript_paragraph.R` | states the criterion and how many participants it removed |

The counting block appears in both `examining_data_raw.R` and
`converting_data_raw_to_processed.R`, exactly as the five description blocks repeat across the two
`examining_` scripts: each script reads end to end on its own, and the number the report shows is the
number the filter used.

Reporting the counts before the cutoff exists is the point of putting them in
`examining_data_raw.md`. The user chooses a number by looking at their own participants, and this
this folder hands them the distribution to look at.

## When the data has no window column

Studies run in the lab before window monitoring, and studies not run in a browser, have no
`window_status` column. Then there is nothing to count: leave this criterion out of the pipeline and
say so in the interview, rather than deriving a stand-in from RT or trial timing. A related measure
computed from something else is a different measure, and the manuscript would name it wrongly.

## Comparing against a window-monitoring report

`shaharlab-jspsych` can produce a standalone window-monitoring report whose `leaving_times` counts
distinct exits from the **audit rows**, grouping events within 1 second of each other into one exit.
`n_window_exits` here counts them from the **per-trial** column instead. The two usually agree and
can legitimately differ: a fullscreen exit that leaves the window visible and focused writes an audit
row while marking no trial `left`, so `leaving_times` can exceed `n_window_exits`. State which
definition the pipeline used wherever the number is reported.
