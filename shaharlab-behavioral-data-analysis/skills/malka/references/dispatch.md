# Dispatch — the spawn and the return

Read this with the run in front of you and a Writer Card built for each of its jobs, from
`references/writer-card.md`. This file covers the round trip: spawning the Code Writer, and reading what
comes back.

## 1 · One dispatch

A dispatch is one card, one Writer, one folder. It runs in four beats:

1. **Card** — built from `references/writer-card.md`: this job's `FOLDER`, its routed reads, and the
   approved values.
2. **Spawn** — the Writer starts on that card and nothing else.
3. **Return** — the output paths plus any `ASSUMED` tags, or `BLOCKED` and a question.
4. **Notebook** — for a dispatch that scaffolded or cloned an `analysis/` or `simulation/` folder, the
   `summary.md` you write yourself, per `references/folder-summary.md`.

Beats 1 and 4 are yours, beat 2 is the spawn, and beat 3 is what comes back. A dispatch reads and writes
only inside its own folder, apart from the `data/` stages a `preprocessing/` dispatch owns — and that
isolation is exactly what lets several dispatches share a run.

## 2 · One run, dispatched together

`references/planning.md` groups the jobs into runs: runs go out in order, and the jobs inside one execute
at the same time. For each run:

1. Build every card the run needs — Step 3, once per job.
2. Spawn them **in a single message, one Writer per job**, so they run concurrently rather than queueing.
3. Wait for every Writer in the run to return before opening the next run. A later run reads files an
   earlier one writes, so the products have to be on disk first.
4. Write the `summary.md` for each returning folder that was scaffolded or cloned, per
   `references/folder-summary.md`.
5. Carry every `ASSUMED` tag the run reported forward to Step 5. The user is the only check on the
   Writer's work, and those tags are the record of every decision nobody made explicitly.

A run of one job is the ordinary case, and it behaves exactly as a single dispatch.

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
| `BLOCKED`, an input file is missing from disk | the job was placed in too early a run | move it to a run after the job that writes that input, per `planning.md` |

A `BLOCKED` question arrives phrased about the analysis rather than the code, because the Writer knows
you do not read its file. Take it to the user, get the value in their own words, amend the card, and
re-dispatch.

This is why your conversational role stays open past the interview gate. A gap that surfaces only once
code is being written still belongs to the user, and you are the only channel to them.
