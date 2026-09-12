# Handing back

Step 3 of `SKILL.md`. Read this once every job on the Plan Card is written and reviewed. Nothing in this system runs the code; the user does.

## Brief them from the Reviewer's return

Brief them from the Code Reviewer's **manifest** — the values as the code actually sets them against the Code-Writer Card. Quoting the card back would describe the job you asked for rather than the one on disk.

Surface every `ASSUMED` tag the Writer reported. Surface any `ADDED READS` too.

## Say what to look for

For a preprocessing job that wrote data-validation HTML, tell them to open each `output/data-validation-*.html` and check that the grey class row and the values row match what they approved — before any analysis reads the tidy table.

For Bayesian jobs, say what a convergence problem looks like, and that they can paste the ess/rhat table back for you to read against the conventional bounds.

For a parameter-recovery study, name the checks its comparison script reports — convergence first, then correlation, bias, precision, the population parameters, and the between-parameter trade-offs — against the criteria they gave at Step 1.

## Close

Offer to walk through the code rather than explaining it unprompted. They can paste an error, a diagnostic table, or a result; that is when `references/return-trip.md` opens. **New science** is Step 1.
