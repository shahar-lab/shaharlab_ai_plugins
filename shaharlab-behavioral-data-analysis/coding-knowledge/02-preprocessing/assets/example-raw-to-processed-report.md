# Example: `raw-to-processed-report.md` content

Illustrative — every value on the real report is computed from the named datasets in
`build_processed.R`. Participant criteria run first, then trial criteria on the
participants that remain; each row filters the row above it.

## Participant exclusions (counts in participants)

| criterion | n_omitted | n_remaining | pct_omitted |
|---|---|---|---|
| Starting point (raw) |  | 40 |  |
| Did not complete the session | 2 | 38 | 5.0 |
| More than 15% of RTs under 0.2 s | 1 | 37 | 2.6 |

## Trial exclusions (counts in observations)

| criterion | n_omitted | n_remaining | pct_omitted |
|---|---|---|---|
| Starting point (after participant exclusions) |  | 8880 |  |
| No response recorded | 44 | 8836 | 0.5 |
| RT under 0.2 s or over 4 s | 120 | 8716 | 1.4 |

**Final: 8,716 observations across 37 participants.**

## Sample overview after exclusion

| metric | value |
|---|---|
| Observations | 8,716 |
| Participants | 37 |
| Trials per participant (min / median / max) | 218 / 236 / 240 |
| RT mean (SD) | 0.851 (0.27) |
| RT range | 0.201 to 3.98 |

## Per condition after exclusion

| condition | n_obs | n_subjects | rt_mean | pct_left |
|---|---|---|---|---|
| control | 4372 | 37 | 0.869 | 50.6 |
| treatment | 4344 | 37 | 0.833 | 49.8 |

## Per participant after exclusion

| subject_id | n_trials | pct_no_resp | pct_fast_rt | rt_mean | rt_min | rt_max |
|---|---|---|---|---|---|---|
| 104 | 214 | 0 | 0 | 0.931 | 0.203 | 3.94 |
| 101 | 238 | 0 | 0 | 0.879 | 0.211 | 3.87 |
| … | | | | | | |
