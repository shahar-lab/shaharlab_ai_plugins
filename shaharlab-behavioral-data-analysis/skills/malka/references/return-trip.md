# The return trip — what comes back after the user runs the code

Read this at Step 6, whenever the user comes back about work this system produced: it errored, the
figure is wrong, the model did not converge, or it ran and here is what it said.

Nothing here runs R. The user does, in their own session, and everything the run produces — an error,
a warning, a convergence table, a figure — is visible to them and to nobody else. Step 5 hands the
work over; this step is how it comes back. Without it a lab member with a broken tenth script starts a
new request, and the interview and the plan run again for work that already exists.

## What arrives

Four kinds, and they route differently.

| What the user brings | What it is | Where it goes |
|---|---|---|
| an error message or traceback | the code does not run | a repair dispatch, §2 |
| "the figure is wrong", "that is not what I asked for" | the code runs and does the wrong thing | a repair dispatch, §2 |
| a diagnostic table, sampler warnings | the model ran and its output needs reading | §3 |
| "it worked, here is what I found" | the analysis has a result | §4 |

A fifth case is the user changing their mind about the science — a different formula, a new exclusion
criterion. That is a new job: go to Step 1 and interview it, because a changed specification is a
changed approval.

## 1 · Get the output, not the description

Ask for the console output, pasted. "It says something about an object not found" names a class of
error; the traceback names the line. One paste settles what several questions would circle.

Ask which script it came from where the traceback does not say, and whether `main.R` was run from the
top or resumed from a `source()` line — a script run alone hits the missing-object errors that
`project-rules.md` §2.I's save-and-load contract exists to prevent, and that is a finding about the
code rather than about how they ran it.

## 2 · The repair dispatch

A repair is an ordinary dispatch with a narrower card. Build it from `writer-card.md` as usual, and:

- `JOB` names the repair — "fix the error in the fitting script", never the fix itself.
- `FOLDER` is the folder that holds the failing code.
- `PROJECT STATE` carries **the pasted output verbatim**, the script it came from, and the note that
  this folder already exists and is being repaired rather than built.
- `SPECIFICATION` stays what it was: quote the same section of `.malka/current_job.md` the original
  dispatch carried. The approved analysis has not changed, and a repair that quietly rewrites the
  specification is how a fix becomes a different study.
- `ROUTED READS` carries what the failing part needs, which is usually narrower than the original
  route. A broken figure routes the plot type and the export standard, not the whole build.

Then review the run as §2 of `dispatch.md` states — a repair is a run, and the Reviewer confirms the
repair did not move a value the specification set.

**Where the same script fails twice, stop and bring it to the user.** Two failed repairs on one script
is a sign the error is in something this system cannot see — the data, the environment, an
uninstalled package — and a third dispatch spends their time to learn nothing.

## 3 · Reading the diagnostics

`02_diagnostics.md` has the script report convergence without interpreting it, which is right for a
file that lands in a paper's repository. Reading the numbers when the user brings them back is a
different act, and a mechanical one.

Where they paste the ess/rhat table, say plainly which parameters are outside the conventional bounds
and which are inside. Where every parameter is inside, say that too — a clean diagnostic table is a
result the user is entitled to hear stated.

State the convention as a convention and leave the call to them: whether a model with one parameter at
the edge is fit for their claim is a judgement about their science, and `project-rules.md` §5 keeps
that on their side of the line. Offer the concrete next step — more iterations, a tighter prior, a
reparameterized model — as options rather than as a decision.

## 4 · The notebook gets its findings

`summary.md` is written at Step 4 with its findings section empty, because nothing had run. This is
when it stops being empty.

Where the user reports what the analysis found, write it into that folder's `summary.md` in their own
terms — the estimate, the interval, the direction, whatever they say the result is. Where they report
that the model ran cleanly and no more, record that it ran and when.

Ask before writing it, and write their words rather than your reading of them. The notebook is the
folder's standing record and outlives this conversation; a finding phrased by an agent that never saw
the output is exactly the wrong thing to leave in a folder headed for publication.

## What this step does not become

The user runs the code and reads its output. This step receives what they bring rather than asking
them to run things on its behalf, and it closes when their question is answered — a repair that lands,
a table that is read, a notebook that is filled.
