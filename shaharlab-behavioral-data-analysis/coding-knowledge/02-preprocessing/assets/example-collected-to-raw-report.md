# Example: `collected-to-raw-report.md` content

Illustrative — every value on the real report is computed from `df` and `collected`.

## Rows

| metric | value |
|---|---|
| Rows kept | 9600 |
| Rows dropped as housekeeping | 14 |
| Participants | 40 |

## Numeric columns

| column | n_missing | min | mean | max |
|---|---|---|---|---|
| accuracy | 0 | 0 | 0.71 | 1 |
| block | 0 | 1 | 2.5 | 4 |
| reward | 0 | 0 | 0.52 | 1 |
| rt | 46 | 0.128 | 0.842 | 6.51 |
| trial_number | 0 | 1 | 120.5 | 240 |

## Categorical columns

| column | n_missing | n_levels | labels |
|---|---|---|---|
| choice | 46 | 2 | left, right |
| condition | 0 | 2 | control, treatment |
| session_status | 0 | 2 | complete, incomplete |
| subject_id | 0 | 40 | 101, 102, 103, 104, 105, 106 |

## Sample overview

| metric | value |
|---|---|
| Observations | 9,600 |
| Participants | 40 |
| Trials per participant (min / median / max) | 220 / 240 / 240 |
| RT mean (SD) | 0.842 (0.31) |
| RT range | 0.128 to 6.51 |

## Per condition

| condition | n_obs | n_subjects | rt_mean | pct_left |
|---|---|---|---|---|
| control | 4800 | 40 | 0.861 | 50.9 |
| treatment | 4800 | 40 | 0.823 | 49.7 |

## Per participant

| subject_id | n_trials | pct_no_resp | pct_fast_rt | rt_mean | rt_min | rt_max |
|---|---|---|---|---|---|---|
| 117 | 240 | 8.3 | 21.4 | 0.402 | 0.128 | 2.11 |
| 104 | 220 | 3.6 | 1.8 | 0.918 | 0.191 | 4.86 |
| 101 | 240 | 0.4 | 0.8 | 0.874 | 0.204 | 3.87 |
| … | | | | | | |
