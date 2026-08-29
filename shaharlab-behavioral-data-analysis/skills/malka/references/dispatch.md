# Dispatch — the spawn and the return

Read this with the run in front of you and a Writer Card built for each of its jobs, from
`references/writer-card.md`. This file covers the round trip: spawning the Code Writer, reviewing what
the run produced, and reading what comes back.

## 1 · One dispatch

A dispatch is one card, one Writer, one folder. It runs in three beats:

1. **Card** — built from `references/writer-card.md`: this job's `FOLDER`, its routed reads, and the
   approved values.
2. **Spawn** — the Writer starts on that card and nothing else.
3. **Return** — the output paths plus any `ASSUMED` tags, or `BLOCKED` and a question.

Beat 1 is yours, beat 2 is the spawn, and beat 3 is what comes back. A dispatch reads and writes only
inside its own folder, apart from the `data/` stages a `preprocessing/` dispatch owns — and that
isolation is exactly what lets several dispatches share a run.

The review and the notebook belong to the run rather than to one dispatch, since the review reads a
run's whole output at once. §2 places them.

## 2 · One run, dispatched together

`references/planning.md` groups the jobs into runs: runs go out in order, and the jobs inside one execute
at the same time. For each run:

1. Build every card the run needs — Step 3, once per job.
2. Spawn them **in a single message, one Writer per job**, so they run concurrently rather than queueing.
3. Wait for every Writer in the run to return. Settle the run's `BLOCKED` questions first, per §3 —
   take them to the user in one round and re-dispatch the jobs that blocked, so the run is whole
   before it is reviewed.
4. **Review the run.** Build one Reviewer Card from `references/reviewer-card.md` and spawn the Code
   Reviewer once, over every folder the run produced. It opens each returned path, reads the code
   against the approved specification in `.malka/current_job.md`, and returns the manifest plus any
   `MISMATCH`, `UNAPPROVED`, or `MISSING` findings — or `CLEAN`.
5. Act on the findings, per the table in `reviewer-card.md`: one review, at most one repair, then the
   user.
6. Write the `summary.md` for each folder the run scaffolded or cloned, per
   `references/folder-summary.md`, taking its values from the manifest.
7. Carry every `ASSUMED` tag and the manifest forward to Step 5.

A run is finished when its products are on disk and its findings are settled, rather than when its
Writers replied — and the review's first pass is what tells the two apart. A later run reads files an
earlier one writes, so it opens only once this one has closed.

A run of one job is the ordinary case: one Writer, then one Reviewer over the one folder.

`SKILL.md` Step 4 states where a clean run goes next.

## 3 · Troubleshooting

Collect the whole run before acting on any of it. Take every `BLOCKED` question the run raised to the
user in **one round**, amend those cards, and re-dispatch just the jobs that blocked — the jobs that
returned clean stay done. Batching the questions gives the user one interruption to answer rather than one
per job.

| What comes back | What it means | What you do |
|---|---|---|
| `BLOCKED`, naming a file it needs | you under-routed `ROUTED READS` | add the file, re-dispatch that job |
| `BLOCKED`, no defensible default | the specification is silent | get the value from the user, amend the card |
| `BLOCKED`, needs a write outside `FOLDER` | the job crosses folders | revise the plan into several jobs, per `planning.md` |
| `BLOCKED`, `FOLDER` contradicts the work | the route is wrong | re-route on §0's tree and §2.III |
| `BLOCKED`, specification contains more than one fit | the plan under-counted the jobs | re-count per `planning.md`, then give each fit its own job |
| `BLOCKED`, an input file is missing from disk | the job that writes it runs in a later run, or its own dispatch failed | move this job after the writing job, per `planning.md`; where that job already ran, treat it as a failed dispatch below |
| nothing came back, or a return that is neither a clean return nor a `BLOCKED` | the dispatch failed | re-dispatch the same card once; on a second failure, stop the plan and tell the user what is and is not on disk |

The Reviewer's findings have their own table, in `references/reviewer-card.md` — `MISMATCH` sends a
repair back to the Writer, `UNAPPROVED` goes to the user with this round's questions, and `MISSING`
means a dispatch reported a product it did not write.

A `BLOCKED` question arrives phrased about the analysis rather than the code, because the Writer knows
you do not read its file. Take it to the user, get the value in their own words, amend the card, and
re-dispatch.

This is why your conversational role stays open past the interview gate. A gap that surfaces only once
code is being written still belongs to the user, and you are the only channel to them.
