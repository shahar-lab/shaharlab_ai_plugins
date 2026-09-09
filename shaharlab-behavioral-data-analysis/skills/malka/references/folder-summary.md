# The folder's `summary.md`

Read this at Step 4, once the run is reviewed, for each dispatch that scaffolded or cloned an
`analysis/` or `simulation/` folder. Those are the two folder types that carry a notebook, so a
dispatch into `preprocessing/` or `models/` passes this step.

Writing it is yours, because its values come from the manifest and the approved specification rather
than from the code — the Writer has neither. Every value in it comes from the Code Reviewer's
**manifest**, the values as the delivered code sets them, rather than from the specification you
approved. The two agree on a
`CLEAN` run and the manifest is the one that stays true when they diverge, so a folder's notebook
describes the analysis that is on disk rather than the one that was asked for.

## The shape

Use that folder type's own `template_summary.md` — `coding-knowledge/02-analysis/` for an
`analysis/` folder, `coding-knowledge/04-simulations/` for a `simulation/` one —
`analysis/` for an analysis folder, `simulations/` for a simulation one.

## What it carries

The model name and formula, the date, the hypotheses, the variables, the data source and any filter
applied, and the sampler settings. The formula, filter, and settings come from the manifest; the
hypotheses and the framing come from the specification, since those are the user's words and the code
never carried them.

Leave the findings section empty at Step 4, with its standing "fill this in once the model is fitted and
evaluated" note. Nothing in this system runs the model, so nothing here can report a finding yet.

**It is filled at Step 6.** When the user comes back with what the analysis found, write it into that
section in their own terms, per `references/return-trip.md` §4. Without that step the note is an
instruction addressed to nobody, and the folder's standing record stays a statement of intent for as
long as the folder exists.

## What it is for

Write it as the folder's own notebook, so the folder explains itself to whoever opens it later without
this conversation. That makes it a different artifact from the Summary Card the user approved at Step 1:
the card asked for permission once, and this is the folder's standing record.
