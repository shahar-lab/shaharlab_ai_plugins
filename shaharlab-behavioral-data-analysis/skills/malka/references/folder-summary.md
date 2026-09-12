# The job-folder's `summary.md`

Read this at Step 2, once this job's Writer has returned clean, for each dispatch that scaffolded or cloned a `preprocessing/`, `analysis/`, or `simulation/` job-folder. A dispatch into `models/` skips this file.

Every value comes from the Writer's return and the locked specification. The hypotheses and framing come from the card, since those are the user's words.

## The shape

Use that main-folder's own `template_summary.md` — `coding-knowledge/01-preprocessing/` for `preprocessing/`, `coding-knowledge/02-analysis/` for an `analysis/` job-folder, `coding-knowledge/04-simulations/` for a `simulation/` one.

## What it carries

For an `analysis/` or `simulation/` job-folder: the model name and formula, the date, the hypotheses, the variables, the data source and any filter applied, and the sampler settings.

For `preprocessing/`: the date, the data source, the exclusion criteria and their cutoffs, and the pipeline.

Leave the findings section empty, with the standing note the template carries. Nothing in this system runs the code, so nothing here can report a finding yet.

**It is filled on the return trip.** When the user comes back with what the analysis found, write it into that section in their own terms, per `references/return-trip.md`.

Write it as the folder's own notebook. That makes it a different artifact from the Summary Card the user approved at Step 1: the card asked for permission once, and this is the folder's standing record.
