# Clarify

The Plan Card and the Job Cards exist. Each Job Card has a folder and a `SPECIFICATION` that holds only what the prompt already gave. Most reserved values are still missing. Clarify is how those leftovers become answers, written onto that Job Card's `SPECIFICATION`, so Confirm has complete cards to approve.

This beat has a silent opening, then a user turn. Work in the main conversation. The Data Explorer is the only sidebar, and only because it needs a shell to run R.

Work through the steps below in order.

## 1. Silent opening

No user turn. Open `references/knowledge-index.md`. For each Job Card, find every entry whose Path (or leftover-only label from **What it covers**, when Path is an em dash) is listed on that card's `CHECKS`. Walk that entry's Deploy-checks, in the bullet order written there. Diff each leftover against that card's `SPECIFICATION`. Skip what the specification already holds. The remainder is the leftover list.

Then run the Data Explorer, once the Plan Card and Job Cards exist. Its standing read is `${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-preprocessing/references/exploration.md`. The card you pass it carries `DATA` and what you know of the study. Carry the profile into the leftover questions.

- A preprocessing job → `data/collected/`
- An analysis job in WAVE 1, or on a one-job Plan Card, when `data/processed/` is on disk → `data/processed/`
- Simulation and `models/` → skip the Explorer

When this run already includes a preprocessing job, a missing `data/processed/` is the preprocessing job's product — skip it as an Explorer target.

## 2. Stance

Ask about leftover values — cutoffs, family, priors, plot columns. The formula they gave is the formula.

## 3. Four surfaces

Walk the leftover list across these four surfaces. A question can sit on more than one.

1. **The cut** — wrong job count, two fits in one folder, a job that writes outside `FOLDER`, a later WAVE that does not wait for the file it reads.
2. **The checks** — each Job Card's `CHECKS` item against that card's `SPECIFICATION`.
3. **The data** — prompt values against the Explorer profile (a cutoff beside the quantiles).
4. **Cross-job** — job B names a column job A never creates; a clone of a folder that does not exist yet.

## 4. Ask

This is the user turn. Prefer Claude Code's `AskUserQuestion` dialog: one question, labeled options, then a wait. When that tool is missing, write the same questions as `- [ ]` checklist lines, one option per line.

Batch values that turn on one decision. Aim for about five exchanges. Propose a default. One line on what turns on the answer. Every reserved value in `project-terms.md` leaves with a number the researcher gave. Ground cutoff questions in the Explorer profile: name the distribution, then ask for the number.

Write each answer into that Job Card's `SPECIFICATION`. `ROUTED READS` and `CHECKS` stay as they were, unless an answer matches a further knowledge-index entry: then add its Path to that card's `ROUTED READS` and, when Deploy-checks is not an em dash, to that card's `CHECKS`. Dispatch fills `PROJECT STATE` when it completes the Job Card for spawn.

Ask even when the leftover list is short. If nothing is open after the silent opening, say so, then Confirm.

### Example — RT cutoff next to Explorer quantiles

The Explorer profiled `data/collected/` and reported trial RT: median 480 ms, 5th percentile 180 ms, 95th percentile 2100 ms. The knowledge-index entry for raw → processed asked for trial-level exclusion cutoffs. `SPECIFICATION` is silent. One `AskUserQuestion`:

```text
Question: Trial-level RT exclusion for this pipeline?
What turns on it: rows outside the bounds are dropped in phase 2, and those counts go in the manuscript.

- [ ] 200–3000 ms (lab default; 5th percentile here is 180 ms, so 200 ms sits just inside the tail)
- [ ] 180–2100 ms (this sample's 5th–95th percentiles)
- [ ] No trial-level RT exclusion
- [ ] Other (type the bounds)
```

On the answer `200–3000 ms`, append to that Job Card's `SPECIFICATION`:

```text
- Phase 2 (trial): drop RT < 200 ms or RT > 3000 ms
```

## 5. Then Confirm

When the leftover list is empty, go to Confirm.
