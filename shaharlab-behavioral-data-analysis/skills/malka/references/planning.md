# Planning — the jobs the request breaks into

Read this at Step 2, once the user has approved the summary card. Settle the whole plan before opening
`dispatch.md`: deciding what the jobs are and instantiating one of them are different acts, and the card
format in front of you invites the second before the first has finished.

## One dispatch, one folder

The Writer writes only inside the folder it is given, which makes `project-rules.md` §1 ("One Model, One
Folder") the boundary of a dispatch too — one canonical set, one `rules.md`, one surface for the Reviewer to
pass. `preprocessing/` counts together with the `data/` stages its `converting_` scripts write.

The boundary binds both ways:

- **No smaller.** A fit, its diagnostics, and its plot are one dispatch, not three.
- **No bigger.** A job that crosses folders is a chain of dispatches in dependency order, each with its own
  review loop and three-round budget. Each leaves a saved product behind (`project-rules.md` §2.I), so the
  next starts from a file on disk rather than from the last agent's context, and what crosses travels in the
  next card's `PROJECT STATE`.

## The plan

One line per job — what it produces, and the folder it writes into. `project-rules.md` §0's
request-to-location table places each folder; its one-way data flow orders the list.

```
1. preprocessing/            revise the exclusions, regenerate the exclusion summary
2. analysis/stay_by_reward/  fit the regression on the processed data, plot its posteriors
```

Each entry's folder becomes that dispatch's `FOLDER`, and `dispatch.md` runs once per entry, in order. The
Step 1 exploration pass is not on the list: it ran before the gate and writes nothing.

## What you return

The ordered list and nothing else. Like a card it is a working instruction rather than an artifact, so it
lives in the conversation and nowhere on disk. Hold it as written — Step 4 comes back to it after every
`PASS`, and a plan re-derived mid-job can quietly come back different.

## What you tell the user

Nothing, for the single-entry plan that most requests are. For two or more, state the order and what each
entry leaves behind — a statement, not a gate: Step 1's approval is the only one, so do not stop for a
reply. Say it because a wrong plan costs a full dispatch cycle per entry, and the user is the one who knows
whether `data/processed/` is already current, or whether the model they want fitted already exists.

> This runs as two passes. First `preprocessing/` — revising the exclusions and regenerating the exclusion
> summary, which rewrites `data/processed/`. Then `analysis/stay_by_reward/` — fitting the regression on that
> processed data and plotting its posteriors. Each pass is written and reviewed before the next starts, so
> you can check the processed data before the model runs.

Name the folders as folders and say what each pass leaves behind. The dispatch count, the cards, and the
review rounds are machinery the user has no call to make.
