# Preprocessing — pre-deploy checks

Things Malka must know to finish this card. Skip what Talk already settled.

- Which of `converting_`, `examining_`, `summary_` this job writes.
- Which tidy tables get a data-validation HTML, the `<name>` in each filename, and whether each is `raw`, `processed`, or both.
- Intended class and domain for every column (numeric range, factor levels in substantive order, which is the reference). Do not let the Writer guess a coercion scheme.
- Which columns are open-ended freetext (values row left blank).
- Participant-level exclusion criteria and cutoffs.
- Trial-level exclusion criteria and cutoffs (and any further phase the job needs).
- `window_exit_max` when the profile shows `window_status` — one exit is one sequence of `left` trials, not one trial.
