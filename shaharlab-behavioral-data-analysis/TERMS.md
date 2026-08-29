# Terms — shaharlab-behavioral-data-analysis

The vocabulary of the Malka workflow, one row per term. This file is for whoever edits the plugin:
it holds one concept to one word across `skills/malka/SKILL.md`, the three agent files under
`agents/`, and everything under `skills/malka/references/`. Malka never reads it at
runtime — each term is defined at the point it is used in the files above, and this table is the
index over those definitions.

**When naming a concept in a runtime file, read this table first and use the word already here.**
The failures it exists to catch are near-synonyms: a "job card" or "execution card" for the Writer
Card, or "an analysis" for a folder that holds one fit.

**Capitalization.** A term whose name is a compound — Summary Card, Writer Card, Code Writer,
Exploration Pass — takes a capital on each word wherever it appears, so a reader sees at once that it
names a specific thing. A term that is a single ordinary word used precisely — job, run, dispatch, fit,
route, plan, folder, specification, gate, interview — stays lowercase and takes its precision from
context. Bare "the card", short for the Writer Card in a passage already about one, stays lowercase too.

**run** and **Exploration Pass** play a similar role — each is a batch of dispatched work — but are two
distinct terms, not one word at two capitalizations: a lowercase **run** is a group of jobs dispatched
together, while the **Exploration Pass** is the Step 1 dispatch over `data/collected/`. Keep them apart
when editing; a stray "pass" found while searching the plugin usually means one of these two and needs
routing to the right term rather than assuming either.

Paths in **Settled in** are relative to the plugin root; `references/` means `skills/malka/references/`.

| Term | What it refers to | Settled in |
| --- | --- | --- |
| **Malka** | the orchestrator skill; runs in the main conversation and handles every exchange with the user | `skills/malka/SKILL.md` |
| **Code Writer** | the subagent that writes every work product, on its own standing instructions rather than on the card | `agents/code-writer.md` |
| **Data Explorer** | the read-only subagent that profiles `data/collected/` at Step 1 by running R over it, so the interview asks for each cutoff beside its own distribution. The one agent here with a shell, and the one that writes nothing | `agents/data-explorer.md` |
| **Code Reviewer** | the read-only subagent dispatched once per run to read the finished code against the approved specification and the structural rules, and to report the values it actually sets. A wider role of the same name — three layers, routed craft reads, in-place annotation, `PASS`/`FAIL` across up to three rounds — was removed in `45d2c1b`; this one keeps its specification layer alone and routes nothing | `agents/code-reviewer.md` |
| **interview** | Step 1 — the questioning that turns a request into a full specification | `references/interview.md` |
| **Exploration Pass** | the Data Explorer dispatch over `data/collected/` inside Step 1, run before any data-dependent question; the one dispatch that precedes the gate, and the only one whose product is its return rather than a file | `coding-knowledge/03-preprocessing/references/exploration.md` |
| **Summary Card** | the plain-English card presented at the end of Step 1 for the user to approve | `references/user-request-summary.md` |
| **the gate** | the approval checkpoint that closes Step 1 — the Summary Card and the halt on it. It stands between the user's request and everything built from it, and it is the only approval in this system | `skills/malka/SKILL.md` Step 1 |
| **specification** | the approved job in the user's own values; the Writer's only source for every formula, threshold, and setting | `references/writer-card.md` |
| **plan** | the ordered list of runs Step 2 returns, written to `.malka/current_job.md` beside the approved specification so every card quotes one fixed text | `references/planning.md` |
| **run** | the set of jobs dispatched together. Runs are dispatched in order, and the jobs inside one go out together. A job joins the earliest run where everything it reads is already on disk. Called *pass* until this table settled the name — kept distinct from the **Exploration Pass** above | `references/planning.md` |
| **job** | one folder's worth of work, and one line of a run. One job is one card is one dispatch is one folder | `references/planning.md` |
| **dispatch** | one Code Writer spawn, carrying one Writer Card. Three beats — card, spawn, return. The review and the notebook belong to the run | `references/dispatch.md` §1 |
| **Writer Card** | the prompt Malka builds at Step 3 and the Writer executes. Also called the execution card until this table settled the name | `references/writer-card.md` |
| **Reviewer Card** | the prompt Malka builds once per run and the Code Reviewer executes. Carries the run's folders and returned paths, and names the specification by path rather than quoting it. It has no `ROUTED READS` slot | `references/reviewer-card.md` |
| **manifest** | the Code Reviewer's record of the values as the delivered code sets them, returned on every review. Malka writes each `summary.md` from it and briefs the user from it at Step 5 | `agents/code-reviewer.md` §4 |
| **route** | choosing which `coding-knowledge/` files a dispatch reads; they travel in the card's `ROUTED READS` slot | `references/knowledge-index.md` |
| **`FOLDER`** | the one folder a dispatch writes into. It bounds writing; the Writer reads across the project as the work requires | `references/writer-card.md` |
| **fit** | one fitted model object — one `brm()`/`stan()` call, one combination of formula, family, and analyzed subset. The unit that earns its own `analysis/` folder | `coding-knowledge/01-folder-specific-rules/analysis/rules.md` |
| **scaffold / clone** | building a folder's canonical set from its templates / duplicating an existing folder | `coding-knowledge/01-folder-specific-rules/<type>/rules.md`, `coding-knowledge/02-scaffolding/references/smart_clone.md` |
| **`summary.md`** | the folder's own notebook — formula, hypotheses, variables, findings. Malka writes it at Step 4 from the manifest, and fills its findings at Step 6 from what the user reports. A different artifact from the Summary Card | `references/folder-summary.md` |
| **recovery study** | a `simulation/` study that generates data from parameters it chose and fits the model back, built in three stages — the environment, the agent population, generate and recover | `coding-knowledge/06-parameter-recovery/references/how-to-build-a-recovery-pipeline.md` |
| **environment** | a recovery study's first stage, and the structure every agent faces in it — a reward schedule, a design matrix, an item set. Distinct from `code-writer.md` §3's "prepare the environment", which is the folder and packages a job needs, and from R's own environments | `coding-knowledge/06-parameter-recovery/references/how-to-build-a-recovery-pipeline.md` |
| **agent** | the unit a recovery study's parameters belong to — a subject, a person, an item, a player, whatever the model family calls it | `coding-knowledge/06-parameter-recovery/references/how-to-build-a-recovery-pipeline.md` |
| **true parameters** | the values a recovery study drew and generated from, saved as `artifacts/true_parameters.rds` | `coding-knowledge/06-parameter-recovery/references/how-to-build-a-recovery-pipeline.md` |
| **recovered parameters** | the posterior means the fit returned, compared against the true parameters in `artifacts/recovery_table.rds` | `coding-knowledge/06-parameter-recovery/references/how-to-read-recovery.md` |
| **the reserved set** | the values that are the researcher's to set and no agent's to choose. Named once in the constitution and cited from Malka's `What you never do`, the Writer's gap rule, and the Reviewer's Pass 2; `UNAPPROVED` is where the Reviewer catches one taken anyway | `coding-knowledge/00-constitution/project-rules.md` §5 |
| **`ASSUMED`** | a tag the Writer leaves in the code where the specification was silent on something outside the reserved set and a default was defensible; Malka surfaces every one at Step 5 | `agents/code-writer.md` §3 |
| **`BLOCKED`** | the Writer's return where the specification is silent on a reserved value, or where no defensible default exists; Malka takes the question to the user and re-dispatches | `agents/code-writer.md` §3, `references/dispatch.md` §3 |
| **`MISMATCH`** | the Reviewer's finding that the code contradicts the approved specification, or breaks a structural rule. Sends one repair back to the Writer | `agents/code-reviewer.md` §4, `references/reviewer-card.md` |
| **`UNAPPROVED`** | the Reviewer's finding that an `ASSUMED` tag took a value from the reserved set. Goes to the user rather than to the Writer | `agents/code-reviewer.md` §3, `references/reviewer-card.md` |
| **`ADDED READS`** | the Writer's report of a craft file it opened that its card did not route. Not a failure: the deliverable was built with the file, and the line tells Malka her route was short | `agents/code-writer.md` §2, `references/dispatch.md` §3 |
| **the return trip** | Step 6 — what happens when the user comes back after running the code: a repair dispatch, a diagnostic table read against the conventional bounds, or the folder's findings written down | `references/return-trip.md` |
| **`MISSING`** | the Reviewer's finding that a path a dispatch returned holds no file, or an empty one — the run reported a product it did not leave behind | `agents/code-reviewer.md` §3, `references/reviewer-card.md` |
