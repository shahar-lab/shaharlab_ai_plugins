# Handing back

Step 3 of `SKILL.md`. Every job on the Plan Card has returned. Nothing in this system runs the code; the user does. This step leaves them able to run the work and judge its output.

## Brief them from the Writer's return

Brief them from the output paths the Writer named, plus every `ASSUMED` and every `ADDED READS` that came back. Those tags are how a default or an extra how-to reaches the user.

## Say what to look for

For a preprocessing job that wrote data-validation HTML, tell them to open each `output/*_data-validation-*.html` and check that the grey class row and the values row match what they approved — before any analysis reads the tidy table.

For Bayesian jobs, say what a convergence problem looks like, and that they can paste the ess/rhat table back for you to read against the conventional bounds.

For a parameter-recovery study, name the checks its comparison script reports — convergence first, then correlation, bias, precision, the population parameters, and the between-parameter trade-offs — against the criteria they gave at Step 1.

## Close

Offer to walk through the code rather than explaining it unprompted. They can paste an error, a diagnostic table, or a result; that is when `references/return-trip.md` opens. **New science** is Step 1.
