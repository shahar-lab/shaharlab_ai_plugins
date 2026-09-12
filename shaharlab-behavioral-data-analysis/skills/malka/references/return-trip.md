# The return trip

Read this when the user comes back about work this system produced. Not a SKILL step. Nothing here runs R.

## What arrives

| What the user brings | What it is | Where it goes |
|---|---|---|
| an error message or traceback | the code does not run | a repair dispatch |
| "the figure is wrong", "that is not what I asked for" | the code runs and does the wrong thing | a repair dispatch |
| a diagnostic table, sampler warnings | the model ran and its output needs reading | read the numbers |
| "it worked, here is what I found" | the analysis has a result | fill the notebook |

**New science** — a different formula, a new cutoff — is Step 1, because a changed specification is a changed approval.

## 1 · Get the output, not the description

Ask for the console output, pasted. Ask which script it came from where the traceback does not say, and whether `main.R` was run from the top or resumed from a `source()` line.

## 2 · The repair dispatch

A repair is an ordinary dispatch with a narrower card. Quote this folder's job from the Plan Card and its specification in `.malka/current_job.md`, then amend a Code-Writer Card:

- `JOB` names the repair — "fix the error in the fitting script", never the fix itself.
- `FOLDER` is the folder that holds the failing code.
- `PROJECT STATE` carries **the pasted output verbatim**, the script it came from, and the note that this folder already exists and is being repaired.
- `SPECIFICATION` stays what it was on the locked specification.
- `ROUTED READS` carries what the failing part needs.

Then review that job as Step 2's Dispatch states. Where the same script fails twice, stop and bring it to the user.

## 3 · Reading the diagnostics

Where they paste the ess/rhat table, say plainly which parameters are outside the conventional bounds and which are inside. State the convention as a convention and leave the call to them. Offer more iterations, a tighter prior, or a reparameterized model as options rather than as a decision.

## 4 · The notebook gets its findings

`summary.md` was written at Step 2 with its findings section empty. This is when it stops being empty.

Where the user reports what the analysis found, write it into that folder's `summary.md` in their own terms. For a `preprocessing/` folder, that is the exclusion counts and the surviving N. Ask before writing it.
