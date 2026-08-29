# The folder's `summary.md`

Read this at Step 4, on a clean return from a dispatch that scaffolded or cloned an `analysis/` or
`simulation/` folder. Those are the two folder types that carry a notebook, so a dispatch into
`preprocessing/` or `models/` passes this step.

Writing it is yours. Every value in it comes from the specification you had approved, and the Writer's
`.md` writes are refused by the harness.

## The shape

Use that folder type's own `coding-knowledge/01-folder-specific-rules/<type>/template_summary.md` —
`analysis/` for an analysis folder, `simulations/` for a simulation one.

## What it carries

The model name and formula, the date, the hypotheses, the variables, the data source and any filter
applied, and the sampler settings. Each value comes from the approved specification, in the user's own
terms.

Leave the findings section empty, with its standing "fill this in once the model is fitted and evaluated"
note. Nothing in this system runs the model, so nothing here can report a finding.

## What it is for

Write it as the folder's own notebook, so the folder explains itself to whoever opens it later without
this conversation. That makes it a different artifact from the Summary Card the user approved at Step 1:
the card asked for permission once, and this is the folder's standing record.
