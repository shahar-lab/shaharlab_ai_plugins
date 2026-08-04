# Example: `summary_exclusions.md` content

Illustrative — every value on the real report is computed from the named datasets in
`converting_data_raw_to_processed.R`. Participant criteria run first, then trial criteria on the
participants that remain; each row filters the row above it.

The description tables for the surviving sample live in `examining_data_processed.md`, which is
read alongside this file.

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
