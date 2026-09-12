# Dispatch subagents

The approved Plan Card and Job Cards are on disk in `.malka/current_job.md`. This step turns each locked Job Card into work: complete it for spawn, then one `code-writer` spawn per card. WAVEs run in order. Jobs listed under the same WAVE run together. You leave this step with files on disk and a return from each Writer.

## 1. Complete the Job Cards

Silently read `dispatch-job-card.md`. Read `.malka/current_job.md`. For each ready job, complete that Job Card: copy `WAVE` / `JOB` / `FOLDER` / `ROUTED READS` / `SPECIFICATION`, drop `CHECKS`, add `PROJECT STATE` and `RETURN`. Prefix each `ROUTED READS` path with `coding-knowledge/`. Later WAVEs fill `PROJECT STATE` from what earlier WAVEs left on disk.

## 2. Deploy

Spawn one `code-writer` with that completed Job Card. Deploy jobs in the same WAVE in parallel. Wait until a WAVE has finished before starting the next: later WAVEs read files earlier WAVEs write.

## 3. Writer returns

The Writer names what it wrote, or names a stop. When a tag is emitted is stated in `agents/code-writer.md`. Treat each tag as follows.

```text
return
├── clean
├── ASSUMED
├── ADDED READS
└── BLOCKED
```

- **clean**

  The Writer named the files it wrote. Write this folder's `summary.md` from the Writer's return and the locked specification, per `folder-summary.md`. A dispatch into `models/` skips `summary.md`. Carry every `ASSUMED` and every `ADDED READS` to Handback. Then the rest of this WAVE, then the next WAVE.

- **`ASSUMED`**

  A default the Writer took. The deliverable stands. Surface each tag at Handback.

- **`ADDED READS`**

  The Writer opened a how-to the card had not listed. The deliverable stands. Add those files to later Job Cards' `ROUTED READS`.

- **`BLOCKED`**

  The Writer stopped. Act from the table below. Re-dispatch only the jobs that blocked. A blocked Writer may already have written: `PROJECT STATE` says the job is resumed.

A clean return often carries `ASSUMED` and `ADDED READS` on the same reply. Treat those as part of the clean return.

## 4. What to do with each `BLOCKED`

| What comes back                                     | What it means                                       | What you do                                                                                                                                              |
| --------------------------------------------------- | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `BLOCKED`, no defensible default                    | the specification is silent                         | get the value from the user, amend that Job Card, re-dispatch that job                                                                                   |
| `BLOCKED`, needs a write outside `FOLDER`           | the job crosses folders                             | revise the Plan Card into several jobs, per `interview-plan-card.md`, then Clarify, then Confirm                                                         |
| `BLOCKED`, `FOLDER` contradicts the work            | the route is wrong                                  | re-route on `project-rules.md` §1's tree, amend that Job Card, re-dispatch that job                                                                      |
| `BLOCKED`, specification contains more than one fit | the Plan Card under-counted the jobs                | re-Plan per `interview-plan-card.md`, then Clarify, then Confirm                                                                                         |
| `BLOCKED`, an input file is missing from disk       | the writing job is not done, or its dispatch failed | put this job in a later WAVE than the job that writes that file, per `interview-plan-card.md`; if that job already ran, treat as a failed dispatch below |
| nothing came back, or neither clean nor `BLOCKED`   | the dispatch failed                                 | re-dispatch the same card once; on a second failure, stop and say what is on disk                                                                        |
