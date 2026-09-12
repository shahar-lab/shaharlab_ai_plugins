# Changelog — shaharlab-behavioral-data-analysis

## [Unreleased]

- **Job Card split.** The Plan Card is the index only (`WAVE`, `JOB`, `FOLDER`), printed in full. Plan then writes one **Job Card** per line (`interview-job-card.md`): `JOB`, `FOLDER`, `ROUTED READS`, `CHECKS`, `SPECIFICATION`, and `WAVE` when the Plan has more than one job. The knowledge-index walk lives in `interview-job-card.md` §2. Clarify reads each Job Card's `CHECKS` and writes answers onto that card's `SPECIFICATION`. Confirm locks the Plan Card and the Job Cards to `.malka/current_job.md`. Dispatch reads that file and completes each Job Card for spawn (`dispatch-job-card.md`: drop `CHECKS`, add `PROJECT STATE` / `RETURN`, prefix `coding-knowledge/`). **Code-Writer Card** is retired; the agent is still **Code Writer**. `dispatch-code-writer-card.md` is `dispatch-job-card.md`.
- **`code/` scripts take a two-digit prefix from `main.R` order.** `project-rules.md` §2 names the form (`NN_descriptive_name.R`) and the renumber-with-`source()` action. Preprocessing `context.md` §3 states that how-tos keep the unnumbered stem and SETUP helpers stay unprefixed.
- **Clarify** replaces Critique. The interview is Plan → Clarify → Confirm. `interview-clarify.md` is the beat file; `interview-critique.md` is gone. Talk is retired. Clarify: context, read the Job Card `CHECKS`, profile the data, form questions, ask, update that Job Card.
- **Confirm** rewritten to the Plan Card shape: context, Structure Legend of the Summary Card, examples, then how Revise returns to Plan or Clarify. Yes locks the Plan Card and the Job Cards to `.malka/current_job.md`.
- **Deploy-checks live on `knowledge-index.md`.** Each craft file is one heading and one box of three bullets — Path, What it covers, Deploy-checks. The When column and the three-column table are gone. Deploy-checks holds nested leftover bullets. Sibling `*_checks.md` and folder-level `pre-deploy-checks.md` are gone. Plan copies matching Paths onto each Job Card's `ROUTED READS` and, when Deploy-checks apply, onto `CHECKS`; Clarify walks the bullets; the Writer reads the how-to.
- **Dispatch returns** are a short tag treatment in `dispatch.md`; emission rules stay in `agents/code-writer.md`. The `BLOCKED` action table stays. WAVEs run serial; jobs in a WAVE run parallel.
- **Code Reviewer files are gone.** `dispatch-reviewer-card.md` and `agents/code-reviewer.md` deleted. Dispatch is Writer-only: a clean return writes `summary.md`, then Handback briefs from output paths, `ASSUMED`, and `ADDED READS`. Restore point before this removal is commit `4eb8ec8`.
- **Runtime `.md` files** open with a context/goal paragraph. The `coding-knowledge/` page format (context first, then fixed sections) is stated in `.claude/CLAUDE.md`; this pass does not rewrite every craft page.
- **Reserved set restored to `project-terms.md`.** Citations that pointed at `project-rules.md` §2 now point at `project-terms.md`.
- **Cards** in `TERMS.md`: Plan Card, Summary Card, Job Card. Plan Card slots in `interview-plan-card.md` and Job Card slots in `interview-job-card.md` / `dispatch-job-card.md` are Structure Legends.
- **UI elements** in `TERMS.md`: `AskUserQuestion` is Claude Code's question dialog. `- [ ]` is the checklist fallback (Clarify leftovers, Summary Card Confirm & Execute / Revise).
- **Structure Legend** is the named form for a heading, a skeleton box, then one bullet per named bit. The writing rule lives in the repo `.claude/CLAUDE.md`.

## [2.0.4] — 2026-09-11

- **Interview beats are Talk, Plan, Critique, Confirm.** Plan counts the jobs and drafts one Code-Writer Card per job. Critique finishes the cards from `pre-deploy-checks.md`. Confirm is still the Summary Card; yes locks the finished Code-Writer Cards to `.malka/current_job.md`. Step 2 does not rebuild them.
- **One file per interview beat.** `interview.md` stays Step 1's index. Beat files are `interview-talk.md`, `interview-plan.md` (renamed from `planning.md`), `interview-critique.md`, `interview-confirm.md` (folds in `user-request-summary.md`). Dispatch stays `dispatch.md`.
- **`pre-deploy-checks.md` replaces `interview-points.md`.** Things Malka must know to finish this card; skip what Talk already settled. Count/split bullets (folder name, fit count, `data/processed/` stop) live in Plan.
- **Code Reviewer is a general after-write check.** Constitution coding rules plus the Code-Writer Card vs the delivered code. No covering-folder craft, no `reviewer-points.md`, no `POINTS` slot. The Reviewer Card carries `CARD` (the dispatched Code-Writer Card) instead of a specification path.
- **README How Malka works stays three steps:** Interview, Dispatch subagents (spawn the locked cards, then the Code Reviewer), Hand back.
- **Dispatch card files are prefixed.** The Code-Writer Card lives in `dispatch-code-writer-card.md`; the Reviewer Card in `dispatch-reviewer-card.md`. `dispatch.md` stays the Step 2 file.
- **Writer Card is Code-Writer Card.** Same object, named after the Code Writer.

## [2.0.3] — 2026-09-11

- **Malka is three linear steps.** Interview (Talk, Count, Critique, Confirm), Dispatch subagents (Cards, then Dispatch), Hand back. Count and the disk file live inside the interview; there is no planning step and no return-trip step. The return trip stays a file the closer opens. A different formula or a new cutoff is **new science**: that is Step 1.
- **Talk, Count, Critique, Confirm.** Critique is criticizing your own draft specification for gaps, not criticizing the researcher's science. It offers no opinion on their formula. `interview-points.md` files stay leftover checks, opened per Counted job, not one domain for the whole request.
- **Confirm writes `.malka/current_job.md`.** The Summary Card is folders plus values; on yes the plan is locked to disk. `planning.md` no longer announces the folders after the gate.
- **`knowledge-index.md` is a lookup.** Trigger → path tables, a compact common-job table, one maintenance line. The point-file table and the seven worked-route chapters are gone. Reviewer `POINTS` is the sibling of each `interview-points.md` Critique opened.
- **Explorer after Count.** `data/collected/` for preprocessing; `data/processed/` for an analysis job not waiting on this run's preprocessing. A mixed clean-then-fit does not stop for missing `processed/`.

- **Data-validation is a preprocessing output type.** A self-contained HTML per tidy table, written
  to `preprocessing/output/data-validation-<name>-<suffix>.html`, lets the researcher verify class
  and domain before analysis. Craft is `01-preprocessing/references/how-to-build-data-validation.md`
  (shared helper, one-line call after typing, dictionary passed but not rendered) plus
  `assets/example-data-validation.html`. Routed with collected→raw on a first pipeline; interview
  and reviewer points ask for intended class/domain per column rather than letting the Writer guess.

- **Matching `reviewer-points.md` files.** Each stage has a short check list. The Reviewer Card
  gains a `POINTS` slot for those paths. Still no how-tos on the Reviewer — `POINTS` is not
  `ROUTED READS`.

- **`SKILL.md` is a spine: goal, the file to read, nothing the file already says.** Each step states its goal and names one follow-file. The approval halt at Step 1 and the step-to-step ordering stay in SKILL.md. The closer names `return-trip.md` and new science.

- **`01-preprocessing/context.md` rewritten to three sections.** §1 goal (only main-folder that
  writes into `data/`); §2 `preprocessing/` is itself one job-folder; §3 the three `data/` stages
  (collected as arrived, raw as tidy real observations with user-verified types, processed as
  exclusions plus calculated columns). Behavioral scope: demographics, cognitive tasks,
  self-reports. `how-to-convert-raw-to-processed.md` now names calculated columns beside the two
  exclusion phases.

- **One run, jobs with `with` / `after`.** A request is one run: a list of jobs. Malka never plans a
  second run. Sequencing lives on the jobs — `with X` goes out with X, `after X` waits until X is
  written and reviewed. Each job gets its own Writer and its own Reviewer (small card, no craft,
  one folder). Independent jobs spawn Writers together; a waiting job starts only after the job it
  reads has been reviewed. The Reviewer Card drops the `RUN` slot. `planning.md`, `dispatch.md`,
  `SKILL.md`, and `TERMS.md` follow.

- **`project-terms.md` holds main-folder, job, job-folder, and the reserved set.** It is a
  constitution standing read. `project-rules.md` is structure only: §1 the five main-folders, §2 the
  job-folder.

- **`project-rules.md` cut to the tree, four contracts, and the reserved set.** Stage labels and
  the `coding-knowledge/` arrows live in the tree; path-block detail stays in the templates and
  `coding-rules.md`; the save-and-reload exception stays in `coding-rules.md` and
  `01-preprocessing/context.md`.

- **Main-folders and job-folders; `domain` is gone.** A lab project has five **main-folders**
  (`data/`, `preprocessing/`, `models/`, `analysis/`, `simulation/`). A **job-folder** is the
  directory one job writes into. `preprocessing/` is itself one; under `analysis/`, `simulation/`,
  and `models/` each job is a named job-folder. `data/` holds stages, not job-folders. The word
  **domain** is deleted: agents open a path under `coding-knowledge/`. `FOLDER` selects the
  `context.md` from the table in `project-rules.md` §0 (`data/` and `preprocessing/` share
  `01-preprocessing/`; `00-constitution/` matches no main-folder). `TERMS.md` gains
  **main-folder**, **job-folder**, and **canonical set**, and drops **domain**. `project-rules.md`
  is rewritten around that tree — stages, flow, naming, shared contracts, reserved set — and no
  longer talks about parts or domains.

- **What `data/` and `preprocessing/` are now sits in `project-rules.md` §0**, which every agent
  already reads — Writer, Reviewer, and Malka — so the three stages and the dividing line between
  them are not private to a preprocessing job. `01-preprocessing/context.md` keeps the folder's own
  tree and cites §0 for the meaning. The Data Explorer, which had no topology read, now opens
  `project-rules.md` before `exploration.md`.

- **Each domain's standing file is `context.md`.** The four folder-type domains under
  `coding-knowledge/` carried a `rules.md`. That name sat beside the constitution's
  `project-rules.md` and `coding-rules.md`, and it read as another rules file rather than the
  folder's own context. Each is now `context.md`: `01-preprocessing/`, `02-analysis/`,
  `03-models/`, and `04-simulations/`. Standing reads, routing, and in-domain citations follow
  the new name. `00-constitution/` is unchanged.

- **`project-rules.md` is topology and authority, not a how-to.** The constitution had grown a
  scaffolding table, the analysis/simulation directory listing, the `main.R` path snippet, the
  `converting_`/`examining_`/`summary_` prefixes, and a save-and-reload contract that is false for
  preprocessing — so Malka was told to skip §1–§4 and Writers paid for rules that belonged in a
  domain `context.md` or in `coding-rules.md`. The file is now three sections read in full: §0 the
  five-part tree, one-way data flow, naming, and the one-folder-per-fit / one-study-per-folder
  counts; §1 the shared contracts (no copied data, artifacts vs output, numbered orchestration,
  path variables, `models/` holds definitions only); §2 the reserved set. The path block stays in
  each domain's `template_main.R`; save-and-reload and polyglot execution stay in
  `coding-rules.md`; each part's tree stays in its `context.md`. Citations that named the old §2.I,
  §2.II, §2.III, §3, §4, and §5 were retargeted in the same edit.

- **`preprocessing/` carries the canonical set.** The folder was documented as `code/`, `output/`,
  and `main.R` only. It has the same top-level set as `analysis/` and `simulation/`: `code/`,
  `artifacts/`, `output/`, `main.R`, and `summary.md`. `01-preprocessing/context.md` states the tree;
  `template_main.R` now defines `artifacts_dir`; Malka writes the notebook from
  `template_summary.md` beside those files. `models/` remains the one folder type without this set.

- **`coding-knowledge/` is now one domain per project part** (breaking: every path under
  `coding-knowledge/` changed). A part's rules and its craft used to sit in two places —
  `01-folder-specific-rules/preprocessing/` held the folder structure and `main.R` template while
  `03-preprocessing/` held the how-to files — so a Writer landing in `preprocessing/` read one
  folder for where its work goes and another for how to do it. Each part now holds both: a
  `rules.md`, the templates beside it, and its craft under `references/` and `assets/`.

  Eight domains become five. `01-preprocessing/`, `02-analysis/`, `03-models/`, and
  `04-simulations/` each govern one top-level project part, and `00-constitution/` keeps the two
  files read on every job. `01-folder-specific-rules/`, `02-scaffolding/`, `03-preprocessing/`,
  `04-visualization/`, `05-bayesian-regression/`, `06-parameter-recovery/`, and
  `07-model-definitions/` are retired, their contents moved with `git mv` so history follows each
  file.

  Bayesian regression, visualization, descriptives, and `smart_clone.md` all live in
  `02-analysis/`, since all four are craft an `analysis/` folder needs. Two of them are routed
  across domains where another part needs them: a `simulation/` job routes into
  `02-analysis/visualization/` for its recovery panels, and into `02-analysis/regression/` when it
  fits brms on generated data. `knowledge-index.md` states each crossing.

  How a domain arranges its craft follows how much it holds. `01-preprocessing/`, `03-models/`, and
  `04-simulations/` keep theirs in a `references/` folder, with worked examples in `assets/`.
  `02-analysis/` holds enough to group by kind instead, so `regression/`, `visualization/`, and
  `descriptives/` sit directly in the domain beside `smart_clone.md` rather than one level deeper.
  `knowledge-index.md` carries every craft file's path, and that path is the authority — a route
  comes from it rather than from the shape.

  The numbering now says one thing rather than two: `00` on every job, `01`–`04` by where the work
  lands. Craft carries no number of its own. Inside a domain, `rules.md` and the templates are the
  standing read and the craft files are routed per card — stated in `knowledge-index.md`, the agent
  files, and `TERMS.md`'s two new rows, **domain** and **standing read**.

- **A descriptives domain, so reporting the sample has craft behind it.** `analysis/` folders that
  describe rather than fit had no `how-to-` file, so participant counts, demographics tables, and
  measure distributions were written from scratch each time.
  `02-analysis/descriptives/how-to-report-descriptives.md` states the products, the
  per-participant frame every table reads back from `artifacts/`, and the blocks that build each
  table. `interview.md` gains a **Descriptives** bullet asking which variables get described, which
  grouping the tables break down by, and which measures are worth a distribution figure rather than
  a mean; `knowledge-index.md` gains its row and trigger. Which measures and cutoffs those are stays
  the researcher's to set, per `project-rules.md` §2.

- `coding-rules.md` states two guidelines more emphatically: reach for `pkg::fun()` only to resolve a
  naming conflict between loaded packages (call everything else directly after `library()`), and write
  a custom `function()` only when the user specifically asked for one or the same block would otherwise
  repeat — not as a default way to organize a script.

- **The Exploration Pass now runs.** `interview.md` made it a hard precondition of every
  data-dependent question — "work from the figures it returns" — while nothing could execute it: the
  Code Writer's tools are `Read, Write, Edit, Glob, Grep` with no shell, so none of `exploration.md`'s
  R ran; its return channel admits only paths and `ASSUMED` tags, so a profile had no way back; and no
  part of it produced a figure. Malka was asking researchers for exclusion cutoffs having promised them
  a distribution drawn from their own participants, and getting neither.

  `agents/data-explorer.md` is a new read-only agent with a shell. It resolves an `Rscript`, runs the
  profile over `data/collected/`, and returns it as text — the one dispatch here whose product is its
  return rather than a file. `exploration.md` is rewritten as its craft: 125 lines rather than 258,
  targeted at `data/collected/` rather than a `raw_data.RDS`, addressed to the Data Explorer rather
  than to "the Architect" (a term belonging to the sibling jsPsych plugin), and with the dangling
  reference to a "Preprocessing Plan approval gate" removed — no such gate exists, and `TERMS.md` says
  the Summary Card is the only approval in this system. It leads with the distributions the interview
  turns on, and carries a `NOT MEASURED` block so a profile states its own limits. Worked route E now
  records that the pass routes nothing, which also settles the "one Writer Card with no `FOLDER`"
  problem: it was never a Writer Card.

- **The interview asks until the gap-list is empty.** It was capped at "Not more then 5" questions with
  no second round, against gap-lists that run to a dozen unknowns for a first recovery study and most
  of a dozen for a first pipeline. The cap limited the wrong quantity — questions rather than
  interruptions — so the residue became `ASSUMED` tags the researcher first saw at handback, after the
  code was written. The rule is now to batch related values into one exchange and keep asking, aiming
  at about five exchanges and taking a sixth rather than leaving a reserved value unset.

- **The Summary Card carries the values it approves.** It instructed that no "technical fields" belong
  on the card, and its own Bayesian example read "and your priors" while the Writer Card said
  `normal(0, 1)` on the fixed effects with 4 chains and 2000 iterations. With one gate and nothing
  downstream, the only moment a human could catch a mistranscribed prior was the moment the card
  withheld it. Every value that reaches the code now appears on the card in plain English, and the card
  names any `data/` stage the run will overwrite together with the folders that read it — the one thing
  on it a researcher cannot infer from their own request.

- **Step 6, the return trip.** The workflow ended at handback, so a lab member whose tenth script
  errored started a new request and re-ran the interview and the plan for work that already existed.
  `references/return-trip.md` receives what running the code produced: the pasted console output, a
  repair dispatch against the same approved specification (bounded at two attempts on one script), a
  diagnostic table read against the conventional bounds, and the folder's findings written down. That
  last one gives `summary.md`'s findings section an owner — it had a standing "fill this in once the
  model is fitted" note addressed to nobody, and nothing in the system ever returned to it.

- **`ADDED READS`.** `dispatch.md` defined a recovery for under-routing — "`BLOCKED`, naming a file it
  needs" — that nothing could produce: the Writer was bounded to `ROUTED READS` "and only those" and
  was never given `knowledge-index.md`, so it could not learn that a file it needed existed. The index
  meanwhile claimed the Writer read it "to locate a path its card already named", which cards already
  resolve. The Writer now takes the index as a catalogue when a deliverable has no craft behind it,
  opens what governs it, and reports it as `ADDED READS`; Malka adds those files to the run's later
  cards and surfaces them at handback. The unreachable row is gone.

- **The `01` layer states requirements rather than routes.** `analysis/rules.md` ("Route every posterior
  plot through the `04-visualization` knowledge"), `simulations/rules.md` and `preprocessing/rules.md`
  each issued craft routes, contradicting both the Writer's read-only-what-is-routed bound and the
  index's routing monopoly — so a Writer held one instruction to read a file and another forbidding it.
  Each now states what the deliverable needs and points at `ADDED READS` where the card was short.

- **The two rules for passing data between scripts are reconciled.** `coding-rules.md` required every
  script to read its inputs from `artifacts_dir` "rather than relying on an object left in the
  environment by a previous `source()`", while `preprocessing/rules.md` and four `03-preprocessing/`
  files required exactly that inheritance. Both files reached every preprocessing card, so the Writer
  picked one silently. The preprocessing convention is right and is now the stated exception: its
  reported exclusion counts have to be the ones the filter produced rather than a second measurement,
  so that folder runs from `main.R` rather than script by script. `coding-rules.md` names the exception
  and `preprocessing/rules.md` cites it.

- **The `main.R` path block has one home.** It was written out in `project-rules.md` §4,
  `coding-rules.md`, `analysis/rules.md`, `simulations/rules.md`, and both `template_main.R` files —
  five copies of one contract. The two `rules.md` files now inject the template and cite §4.

- **`07-model-definitions` is a new domain.** `models/` was a first-class folder type with an `01`
  rules file, a 7-line `template_model.R`, a 13-line `template_model.stan`, no craft, no routing rows
  and no interview section — the hardest artifact the lab produces, written from an empty skeleton, and
  a prerequisite of every recovery study. The domain covers the generating `.R` and fitting `.stan` as
  one pair, non-centred varying effects, and the three scale-and-choice-rule agreements
  `06-parameter-recovery` already depends on. Numbered `07` so nothing renumbers. `interview.md` gains
  its section and `knowledge-index.md` its rows and Worked route G.

- **The preprocessing R traps are back.** `45d2c1b` deleted both `review-checklist.md` files with the
  Reviewer, and the preprocessing one held craft available nowhere else — `%in%` versus `!=` chained
  with `&` (which removes every row), `scale()` returning a matrix, `cut()` without explicit `labels`,
  `complete.cases()` scoped wrong, and the counts to print so a silent loss is visible. Restored as
  `03-preprocessing/references/conversion-and-filter-traps.md`, stated as actions rather than as review
  findings, routed on any `converting_` script.

- **The `.md`-write claim is removed.** `code-writer.md` stated "the harness in this environment refuses
  a `.md` write from you", and `folder-summary.md` built on it; no such restriction was found — the
  agent is granted `Write`, the plugin ships no hooks, and neither the project nor the user settings
  carries a matching rule. On that premise markdown deliverables were routed back through a return
  channel that admits neither. The Writer now writes the `.md` files its job produces. `summary.md`
  stays Malka's, on the real reason: its values come from the manifest and the approved specification,
  which the Writer does not hold.

- **The state-the-action rule applied to the files that break it.** `coding-rules.md` carried a section
  titled "what you should not do and avoid when writing in R"; `smart_clone.md`, `EXPORT_STANDARD.md`,
  `PANEL_TAGGING_STANDARD.md` and `COLOR_STANDARD.md` each framed an instruction as a prohibition.
  Each is now the action it implies. `COLOR_STANDARD.md`'s "What to Avoid" table also had a two-column
  body under what had become a three-column header; it is a two-column table again.

- **The Code Reviewer returns, as its specification layer alone.** `45d2c1b` removed it because two
  spawns per dispatch across up to three rounds, each re-reading the whole routed craft set, was the
  dominant cost on every job. That accounting was right about the cost and wrong about what to drop
  with it: the removed agent's own file said of its third layer that "layers 1 and 2 find code that
  breaks conventions; only this one finds code that is clean, idiomatic, well-scaffolded, and fits the
  wrong model or filters on the wrong threshold" — and that layer is the one needing no craft library
  at all. The Writer's Stage 3 self-check could not stand in for it, being closed over the same inputs
  the Writer already held, so a value it misread stayed misread through its own review.

  `agents/code-reviewer.md` is new and narrower than its predecessor on every axis. **Read-only**
  (`Read, Glob, Grep`) rather than annotating findings into the code, which the old file itself warned
  made "a reviewer that edits code … a second writer". **One spawn per run** rather than one per
  dispatch per round. **No routed craft reads**: its standing set is the two constitution files plus
  each folder's `rules.md` — the Writer's own set minus the library — and its card carries no
  `ROUTED READS` slot. **No `PASS`/`FAIL` and no revision rounds**: it reports and Malka decides, bounded
  at one review, at most one repair, then the user. Craft compliance stays with the Writer, which read
  the standards, and the agent file says so rather than reporting on files it never opened.

  Three passes: every returned path resolves to a non-empty file; every value the specification sets
  appears in the code as approved; and the standing rules its reads state. It returns a **manifest** of
  the values as the code sets them on every review, plus `MISMATCH`, `UNAPPROVED`, or `MISSING`, or
  `CLEAN`.

  **The agent file states the method and holds no specifics.** A first draft enumerated the value
  kinds Pass 2 walks and restated Pass 3's rules as a checklist — the two-digit prefixes, the path
  block, `source()` through variables, the canonical set — every line of it a copy of
  `project-rules.md` §2.II, §3 and §4, which the Reviewer already reads. It also carried a worked
  manifest and a calibration table in lab values. All of it would have gone stale the first time a
  domain was added or a rule moved, against the plugin's own rule that lab topology stays in
  `project-rules.md` and domain knowledge in `coding-knowledge/`. Pass 2 now walks the specification
  itself, so whatever the specification settles is what gets checked and a new domain needs no edit
  here; Pass 3 checks against whatever its reads say today; and the manifest takes its categories from
  the specification. The file is 117 lines rather than 173.

  `references/reviewer-card.md` is new and holds the card format, parallel to `writer-card.md`;
  `dispatch.md` moves the review and the notebook from the dispatch to the run, where the barrier
  already sat, and gains a failed-dispatch row; `SKILL.md` Step 4 gains the review and Step 5 now
  briefs the user from the manifest; `folder-summary.md` takes each `summary.md`'s values from the
  manifest rather than from the approved specification, so a folder's notebook describes the analysis
  on disk rather than the one that was asked for. `TERMS.md`, `README.md`, and the repo's `CLAUDE.md`
  follow.

- **`knowledge-index.md` stays a Writer-only table, and now says so.** The index dropped its `W` / `R`
  marks when the old Reviewer went. Reusing the name for the narrow role makes restoring them look like
  a correction rather than a regression, so both the index and the repo's `CLAUDE.md` now state that
  the Reviewer takes no routed reads and that a `02`–`06` path on a Reviewer Card, or a who-reads-it
  column here, means the wider role has grown back.

- **The reserved set gets one home, and `BLOCKED` becomes the Writer's default for it.**
  `project-rules.md` gains a **§5** naming the values that are the researcher's to set — an exclusion
  cutoff, a prior, a threshold, a recovery criterion — and separating them from the values an agent may
  take. `SKILL.md`'s `What you never do`, `code-writer.md` §3, and the Reviewer's Pass 2 all cite that
  section rather than restating the list, so a fifth reserved value is added in one place. Malka's
  Step 1 read grows from §0 to §0 and §5, since settling those values is what the interview is for.

  The rule needed enforcing as much as it needed a home: `SKILL.md` had always held Malka to it while
  `code-writer.md` made `ASSUMED` its default and `BLOCKED` "the grudging exception" — and illustrated
  the tag with `ASSUMED[no criterion given]: dropped subjects with fewer than 10 trials`, an exclusion
  cutoff. The rule Malka is held to was voided one layer down, by the agent that writes the number into
  the file. §3 now splits the two cases, with the worked example replaced to match, and the Reviewer's
  `UNAPPROVED` catches one taken anyway.

- **The approved specification and plan are written to `.malka/current_job.md`.** `planning.md` said
  the plan "lives in the conversation and nowhere on disk … a plan re-derived mid-job can quietly come
  back different" — naming the failure and then relying on the model not to have it, across a job that
  can run to eight dispatches and a full interview. Malka now writes both to that file when the gate
  clears, one section per job. Writer Cards quote it rather than composing the values again, and the
  Reviewer Card names it **by path** so the Reviewer reads the approved original — which is what lets a
  value mistyped onto a Writer Card surface as a `MISMATCH` instead of as code nobody questions. The
  dotfolder keeps it outside `project-rules.md` §0's five-part tree, since it holds working state
  rather than a project part.

- **`01_sampling_and_priors.md` read `data_path` as a file.** Lines 28 and 67 called
  `read_csv(data_path)`, while `project-rules.md` §4, both `template_main.R` files, and
  `analysis/rules.md` all define `data_path` as the `data/` stage **directory**. Every brms job routes
  this file, so a Writer following it wrote `read_csv()` against a directory path — code that fails in
  the user's session, in the plugin's most-used craft route, with nothing in the system executing R to
  catch it. Both calls now read `file.path(data_path, "df_trials.csv")`, and the workflow step above
  them states which of the two `data_path` is.

- **Three stale paths from the plot-types flattening.** `EXPORT_STANDARD.md` cited
  `plot-posterior/instructions.md`, which no longer exists; `how-to-read-recovery.md` and
  `knowledge-index.md`'s Worked route F still named `plot-posterior/`, `plot-scatter/` and
  `plot-dot-histogram/` as folders. All repointed to the single-file form.

- **Malka's `description` regains the one-off-script sentence.** "Use her even when the request sounds
  like a small one-off script, because all analysis code in this project goes through Malka so that it
  lands consistent with the lab's coding rules" had been dropped. Since skill routing depends on the
  model matching that description, its absence made the failure mode it guards against — Claude writing
  the script itself, outside the lab's rules — more likely. The description also now names the Reviewer.

- **The planning term `pass` is renamed `run`.** `TERMS.md` settled `pass` as "the set of jobs
  dispatched together" back when the plan gained its three-level shape; it read too close to the
  Reviewer's old `PASS`/`FAIL` verdict for a plugin that has since removed the Reviewer entirely, and
  reads too close to "review pass" in ordinary English. `run` is renamed in `TERMS.md`, `planning.md`
  (including its three worked examples' `pass 1`/`pass 2`/`pass 3` labels, now `run 1`/`run 2`/`run 3`),
  `dispatch.md` (its §2 heading and body), `SKILL.md` (Step 2's and Step 4's titles and bullets, the
  reference table), `writer-card.md`, `knowledge-index.md`, and `interview.md`. Several sentences that
  paired the noun against the ordinary verb "run" — "passes run in order, and the jobs inside one pass
  run together" — are reworded rather than mechanically substituted, since "runs run in order" repeats
  one word for two meanings in one clause; the replacement wording ("runs go out in order, and the jobs
  inside one run are dispatched together") is now used consistently everywhere the point recurs.

  **The Exploration Pass is unchanged and deliberately so** — it names a specific Step 1 dispatch, not a
  group of jobs, and TERMS.md previously explained the two as one word split by capitalization; since
  the words now differ, TERMS.md's capitalization note is rewritten to state that `run` and `Exploration
  Pass` are two distinct terms that happen to play a similar role, so an editor who greps for a stray
  "pass" knows to route it to the right one rather than assume either. `TERMS.md`'s `run` row notes it
  was called `pass` until this rename, matching the convention already used for **Writer Card**'s prior
  name. This CHANGELOG's own historical entries keep saying `pass`, since they describe what was true
  when they were written.

- **Each plot type is now one file, not a subfolder.** `plot-types/plot-posterior/instructions.md` →
  `plot-types/plot-posterior.md` (and its `example.png` → `plot-types/plot-posterior.png`, sibling
  rather than folder-contained); `plot-types/plot-scatter/instructions.md` →
  `plot-types/plot-scatter.md`; `plot-types/plot-dot-histogram/instructions.md` →
  `plot-types/plot-dot-histogram.md`. A single-file plot type never needed a folder, and it no longer
  has one now that none of the three ships an `example.R`. Every `../../standards/...` path inside the
  three files drops one `../`, since each file sits one directory shallower; the "this folder ships no
  `example.R`" wording is restated as "no `example.R` exists for this plot type", since `plot-types/`
  is now shared by all three rather than owned by one. `knowledge-index.md`'s `04` request table, file
  table, and Worked routes C and F are repointed, and `writer-card.md`'s Example 2 card follows.

- **`plot-posterior/` takes the four-part skeleton, and its canvas and x-axis rules change**, both lab
  rulings. **The canvas is now 10 × 4 in**, overriding `EXPORT_STANDARD.md`'s 10 × 8 default, because
  height on a posterior plot is an arbitrary normalized scale that carries no information, and both
  examples had silently inherited 10 × 8 while the file's own prose called for "wide and short" —
  a Writer obeying every line of code still produced a figure violating the rule. `EXPORT_STANDARD.md`'s
  "When Not to Use These Defaults" gains the paired clause: a plot type may state its own canvas, this
  one being the example. **The x-axis is now three named cases** rather than an effect/non-effect split
  with only the effect case specified: an effect posterior keeps its symmetric-about-zero range; a
  bounded parameter (a probability, a learning rate) takes its full bound; anything else takes the draws
  widened 20% at each end. **The credible interval is one interval at `.width = 0.90`**, replacing the
  two blocks that had both claimed to be "always applied" at different widths and linewidths — one
  `stat_pointinterval(.width = 0.95, ...)`, the other `.width = c(0.80, 0.90)` — which a Writer
  following both would have rendered as two median points at different offsets. **The annotation is now
  stated for both cases**: an effect posterior keeps `[median = X.XX, pd = XX.XX%]`; any other posterior
  is `[median = X.XX]`, since pd is the share of the posterior on one side of zero and means nothing
  without that reference. **The multi-distribution case now states median and pd apply per group**,
  closing a gap where Example 2 previously omitted both with nothing saying whether that was
  deliberate.

  The file is now `## Purpose`, `## The rules` (bulleted, each self-contained, with a `*Why:*`
  paragraph under the ones that need one), and `## Examples`. Fixed in the same pass: the deprecated
  numeric-vector `legend.position = c(1, 0.95)` (ggplot2 3.5.0+) is now
  `legend.position = "inside"` / `legend.position.inside = c(1, 0.95)`; the custom
  `xlim_posterior <- function(draws, pad = 0.20)` is inlined as plain arithmetic per
  `coding-rules.md`'s prefer-not-to-write-custom-functions guidance; both examples now export, where
  neither did before; `coord_cartesian(ylim = c(0, 1.3))` is now derived (`stat_slab()` normalizes to
  height 1, plus 0.3 headroom for the annotation) rather than stated with no reasoning behind it.

  **`plot-posterior/example.R` is deleted**, absorbed as Example 1, for the same reasons as
  `plot-scatter/example.R` above — it and the file's inline code had already drifted, and it taught
  rule violations (`set.seed(42)`, `library()` in a sourced script, no reads/writes header) by
  imitation. **A third example is added** — two condition means (non-effect posteriors) and their
  difference (an effect posterior) assembled as a two-panel patchwork figure — because this is the
  figure `example.png` in this folder depicts, and no code in the repo produced it before this pass.
  **`example.png` itself is not yet regenerated**: rendering needs an R session with `ggdist` and
  `patchwork`, which this environment does not have. The file and `knowledge-index.md` both flag it as
  awaiting regeneration from Example 3 rather than claiming the correspondence is already true. Paired
  routing repairs: `knowledge-index.md` drops the `example.R` row and restates the instructions row;
  Worked route C falls from `3 + 6 or 7` to `3 + 5 or 6`; Worked route F falls from `3 + 10` to `3 + 9`;
  `writer-card.md`'s Example 2 card drops the `example.R` line.

- **New domain: `coding-knowledge/06-parameter-recovery/`.** A recovery study now has craft knowledge of
  its own, taken from the lab's `shahar_lab_rl_models/simulation/alpha_beta_param_recovery` pipeline and
  generalized past RL. `how-to-build-a-recovery-pipeline.md` states the three stages the pipeline is built
  in — setting the environment, setting the agent population, generate and recover — with a mapping table that
  reads those stage names for a regression, an IRT/GRM, or a Bradley-Terry model, the three
  generating-versus-fitting agreements that make a recovery result interpretable (same population form,
  same parameter scale, same choice rule), and the artifacts each stage leaves for the comparison.
  `how-to-read-recovery.md` states the six checks in order — convergence, correlation, bias, precision and
  shrinkage, the population parameters, and between-parameter trade-offs — each with the criterion held in
  a named variable the user supplies, plus a table mapping a poor result onto which of the three causes it
  points at. `assets/example_main.R` is the worked skeleton.

  Routed from `knowledge-index.md`'s new `## 06` section (two-row trigger table, three file rows) and
  worked route F, a first recovery study at 3 + 10 reads. `interview.md` gains the per-stage gap-list
  bullet, including asking the user what recovery has to look like to count as successful. `SKILL.md`
  Step 5 names the checks to report at handback, and its "What you never do" list now names the recovery
  criterion beside the exclusion cutoff and the prior. `TERMS.md` gains recovery study, environment,
  agent, true parameters, recovered parameters — the environment row also separating the stage from
  `code-writer.md` §3's "prepare the environment" and from R's own environments.

- **`code/` scripts are numbered by their position in `main.R`.** *(breaking: every folder's script names
  change)* `project-rules.md` §2.II had said the opposite — "No Numbered Scripts" — on the ground that
  numbering breaks when a step is inserted. The rule now states the numbering and the renumbering
  together: a two-digit prefix gives each script its place in `main.R`'s source order, and inserting,
  removing, or reordering a step renumbers the scripts after it and rewrites the matching `source()` lines
  in the same edit. The listing then reads in pipeline order, which is what the lab wanted from the
  recovery folder this release is modeled on.

  Files: `project-rules.md` §0 naming, §2.II, §3; `analysis/rules.md` tree and `code/` row;
  `simulations/rules.md` tree; `preprocessing/rules.md` tree and naming table, where the number goes in
  front of the `converting_`/`examining_`/`summary_` kind-prefix and the report keeps the unnumbered name;
  all three `template_main.R` files.

- **The plan returns passes, and a pass dispatches its jobs at the same time.** *(breaking: the plan's
  return contract changes shape)* Malka had been strictly serial — build a card, spawn one Writer, wait,
  repeat — and nothing said so outright; it followed from `planning.md` returning a flat ordered list, and
  from phrases like "in dependency order, routed one at a time". But serial was only ever justified for
  jobs joined by a **data** dependency. `project-rules.md` §0 states that an `analysis/` folder "writes
  only inside its own folder" and a `simulation/` folder "reads nothing from `data/`", and
  `agents/code-writer.md` §1 bounds every Writer to writing inside its card's `FOLDER`, returning
  `BLOCKED` rather than writing elsewhere. Two jobs in different folders therefore cannot collide on
  writes, and the only possible race is reading a stage another job is still writing.

  So the plan now has three levels — request → pass → job. A **pass** is the set of jobs that run at the
  same time; passes run in order. A job joins the earliest pass where everything it reads is already on
  disk, and exactly two reads create a wait: `data/processed/` or `data/raw/` waits on the
  `preprocessing/` job that writes it, and a `models/` definition waits on the `models/` job that writes
  it. A request of four jobs that used to take four serial rounds — preprocessing, a simulation, a
  descriptive set, a regression — now runs in two passes, because the simulation depends on neither the
  data stages nor the analyses.

  **`1 job = 1 folder = 1 card = 1 Writer` is untouched**, and the reasoning for keeping it is now on the
  record: `FOLDER` is the surface a Writer checks itself against before returning, a blocked job stays
  independently resumable, and one Writer holding several folders is the pathway that produced the
  six-fits-in-one-folder bug this changelog already records. Concurrency changes *when* Writers are
  spawned, never how much any one of them holds.

  **Same-shape jobs get a pilot instead of a fan-out.** Six fits of one formula share every specification
  slot, so sending all six at once means six Writers reading the same craft stack and, on a silent prior,
  six identical `BLOCKED` returns. The first job now takes a pass alone on the full craft route; the rest
  follow in the next pass as clones routed to `smart_clone.md` and the folder's `rules.md`. The craft
  library is read once, the folders come out consistent because they were copied from one that works, and
  a specification gap surfaces while five jobs are still unspent. Jobs of *different* shapes share a pass
  and go out together, since their failure modes have nothing in common.

  Files: `planning.md` rewritten around passes — the three levels, the job-count table (fits split,
  descriptives merge, one `simulation/` study is one job however many fits it runs), the dependency table,
  the pilot rule, the pass-grouped plan format, and three worked examples (one job; four jobs in two
  passes; six fits as pilot-plus-clones). `dispatch.md` gains §1, the four beats of one dispatch (card,
  spawn, return, notebook), and §2, how a pass goes out in a single message and is awaited whole; §3 now
  opens with batched triage — every `BLOCKED` question in a pass goes to the user in one round, and only
  the blocked jobs re-dispatch — and gains a row for an input missing from disk, which means the job sat
  in too early a pass. `SKILL.md`: Step 2 is renamed "Plan the Jobs and Passes" and states the
  granularity of every later step, Step 4 is renamed "Dispatch the Pass" and spawns one Writer per job in
  one message, Step 3 notes it runs once per job, the intro says a card per folder and several Writers at
  once, and the reference table records per-job versus per-pass. `TERMS.md` gains **pass**,
  rewrites **plan**, **job**, and **dispatch**, and extends the capitalization note, since a lowercase
  pass and the **Exploration Pass** are now two different things. `knowledge-index.md` and
  `writer-card.md` drop "one at a time" and "per entry" for "per job".

- **Every `SKILL.md` step now opens by stating its goal.** Steps 2, 3, and 4 had gone straight to their
  bullets, so Malka arrived at each one knowing the mechanics and not what she was there to achieve. Each
  step now leads with one plain sentence: a request specified well enough to build from as it stands
  (Step 1); how many jobs the request breaks into and which folder each writes into (2); everything the
  Writer needs to know about its job and nothing more (3); the code written, and any gap it hit carried
  back to the user (4); the user able to run the work and judge its output unaided (5).

  Steps 1 through 4 are now that sentence plus their bullets, with no orientation prose behind it. The
  prose those steps briefly carried restated what `dispatch.md` already owns — the Writer's empty
  starting context (§ intro), the `ROUTED READS` and `SPECIFICATION` slots and the "a file left off is
  knowledge the subagent works without" trade (§1), the return shape (§2), and blocked questions arriving
  phrased about the analysis (§3) — so it was a second copy of reasoning that lives one read away. Steps
  4b and 5 keep their prose, because neither has a reference file behind it and `SKILL.md` is the only
  home their reasoning has. Step 4b's reason also moved from its last paragraph to its first, and that
  last paragraph keeps only what it alone said — the contrast with the Summary Card.

- **Step 4b is gone, and Malka has five steps.** Writing the folder's `summary.md` had been a lettered
  sub-step of the dispatch, which read as though it were somehow less than a step. It is less than a step:
  it is the fourth beat of one dispatch, which `dispatch.md` §1 already states. Promoting it to its own
  number left the granularity stuttering — Step 3 per job, Step 4 per pass, Step 5 per job again — so it
  is now a bullet under Step 4, where the pass's returns are handled, and Hand Back is Step 5.

  Two nearer alternatives were ruled out on the way. The Writer cannot own the notebook:
  `agents/code-writer.md` states that the harness refuses a `.md` write from it, and every value in the
  notebook comes from the specification Malka holds, so routing it through the Writer would add a
  translation with no source of truth on the far side. Malka cannot write it at Step 3 either, because the
  folder does not exist until the Writer scaffolds it — and a folder holding one stray `summary.md` would
  meet the Writer's "if it does exist, verify it matches the canonical set" branch and fail it.
  Composing the notebook alongside the card is still the natural move, since both draw on the same
  approved values; only the file has to wait.

  `exploration.md`'s own "Step 1–5" headings are a separate numbering space — the sections of the
  exploration script — and stay as they are.

- **The `summary.md` craft moves to `references/folder-summary.md`.** Step 5 was four paragraphs deep in
  `SKILL.md` while every other step had shrunk to a goal and a bullet, and the content it held was craft
  a reference file should own: the shape to follow, what the notebook carries, the empty findings section
  and why nothing here can report a finding, and the contrast with the Summary Card. The name pairs with
  `user-request-summary.md` — one summary for the user, one for the folder. `TERMS.md`'s **`summary.md`** row settles on the new file rather than on a
  `SKILL.md` step, and `SKILL.md`'s reference table gains a row for it, with `template_summary.md` now
  reached through it rather than directly.

- **`dispatch.md` splits: the card gets its own `references/writer-card.md`.** One file had been serving
  two steps — Step 3 read its §1 to build the card, Step 4 read §2–§3 to spawn and to read the return —
  and the seam showed in `SKILL.md`, which had to tell Malka to follow a file "already open from Step 3".
  A file serving two steps also numbers badly: §1 was 127 lines and §2–§3 together were 32. The card now
  lives in `references/writer-card.md` — what the card is, the empty-context fact, the two rules spanning
  every card, the six slots, and both worked examples — and closes by handing off to the spawn.
  `dispatch.md` keeps the round trip in two sections, Dispatching and Troubleshooting, renumbered §1–§2.
  Each step's header now names its own file: "Route and Build the Writer Card" reads `writer-card.md`,
  "Dispatch the Code Writer" reads `dispatch.md`, and neither cites a section. This continues the split
  that moved planning out of the same file into `references/planning.md`, and partly reverses the older
  merge of `guidelines-execution-card.md` and `guidelines-dispatch-subagents.md` — on a boundary that
  follows the steps rather than the concepts.

  Every path that named the old file moved with it: `SKILL.md` (the Step 3 and Step 4 bullets, plus two
  rows in the reference table where there had been one), `planning.md` (settle the plan before opening
  `writer-card.md`), `user-request-summary.md`, `README.md` (five reference files became six), and
  `TERMS.md` — **specification**, **Writer Card**, and **`FOLDER`** now resolve to `writer-card.md`,
  while **dispatch** and **`BLOCKED`** follow `dispatch.md`'s new §1 and §2.

- **`planning.md` no longer says `PASS`.** "Step 4 comes back to it after every `PASS`" was the last
  surviving mention of the Code Reviewer's vocabulary anywhere in the plugin; the Writer returns paths or
  `BLOCKED`, so the line now reads "after every clean return". The same file also stopped naming a
  reference file as the thing that runs once per entry — Steps 3 and 4 do, and `SKILL.md` owns that loop.

- **`SKILL.md` owns the dispatch loop; `dispatch.md` §2 no longer restates it.** Both files had been
  telling Malka where a clean return goes next, and the loop is over `SKILL.md`'s own steps, so `SKILL.md`
  keeps it: a file loaded on every job outranks a routed read for step sequencing. `dispatch.md` §2 now
  carries only what it alone knows — spawn the card, the return shape, forwarding `ASSUMED` tags to
  Step 5, and the `BLOCKED` handoff to §3 — and points at Step 4 for the rest. Step 4's two reads also
  became bullets, matching Steps 1 through 3, and the return to Step 4b now states the condition it
  always had: a dispatch that scaffolded or cloned a folder. A `preprocessing/` dispatch writes no
  `summary.md`, and the line had read as though every dispatch routed through that step.

- **`plot-scatter/` takes the four-part skeleton, and two of its rules change.** Both changes are lab
  rulings, not formatting. **The square panel is now `theme(aspect.ratio = 1)`**, with `coord_equal()`
  reserved for a same-scale pair, where it delivers the square and one shared data unit together. The
  file had mandated `coord_equal()` on every scatter "even when the x and y variables are not on the
  same measurement scale" — but that call fixes one *data unit* on x to one data unit on y, so a mean-RT
  against accuracy plot rendered as a 700-by-1 sliver rather than a square, and the rule was
  self-defeating on exactly the pairs it named. **The equality diagonal is now conditional on a shared
  scale**, where a point above the line means y exceeded x; on differently-scaled variables it compares
  units with no common meaning and usually falls off-panel, so it is left off.

  The file is now `## Purpose`, `## The rules` (13 rows), `## Things to know` (matched pairs from one
  data frame, the square-panel branch, what the diagonal reads as, the Pearson label's corner anchor),
  and `## Examples`. **A second example is added** — two measures on different scales — because the
  file's only runnable code implemented the same-scale branch as though it were universal, so an
  empty-context Writer plotting RT against accuracy had nothing correct to copy. The matched-pairs rule
  is stated as constructing the pair from one data frame rather than as a length check: two vectors of
  unequal length are recycled by R rather than rejected, and the `stopifnot()` it replaces compared two
  columns of one data frame, which are equal in length by construction and could never fail.

  **`plot-scatter/example.R` is deleted**, its figure absorbed as Example 1. It and the file's own
  template were the same plot written twice and had already drifted — `size = 2.5` against `size = 2`, a
  `linewidth = 0.6` on the diagonal in only one, and an export block in only one, so the template alone
  produced a figure that was never saved. It also taught five rule violations by imitation: `library()`
  in what becomes a sourced script, `set.seed(42)`, `output_dir <- tempdir()`, `# ---- Setup ----`
  headers in place of `#### HEADER ####`, and no opening `# reads: … · writes: …` line. Paired routing
  repairs: `knowledge-index.md` drops the `example.R` row, restates the instructions row, and Worked
  route D falls from `3 + 5` to `3 + 4`.

- **Added a `plot-dot-histogram` plot type** under `04-visualization/references/plot-types/`: built on
  **ggdist**'s `geom_dots(layout = "bin")` rather than base ggplot2's `geom_dotplot()`, matching
  `plot-posterior/`'s use of ggdist and getting a more capable Wilkinson dot-stacker. One dot per
  observation. The x-axis takes the variable's theoretical range from the specification when one applies
  (e.g. a Likert item's stated bounds) and falls back to a 10%-padded data range otherwise, with 4–5
  ticks and labels rounded to at most two decimals. Bin width is left to `geom_dots()`'s own auto-select
  (`binwidth = NA`), overridable by an explicit width from the specification. `geom_dots()` stacks in
  normalized panel units rather than at count heights, so the y-axis is rebuilt from the built plot with
  its **breaks in panel units and its labels in counts** — the largest count per `ggplot_build()`'s
  per-dot `bin` id gives the tallest stack, and `max(built$y)` gives that stack's extent. Handing count
  values straight to `breaks` would place every one of them outside the data range and draw none, which
  is how a first cut of this file rendered an axis labelled "Count" with a lone `0` on it. The extent is
  read from the build rather than from ggdist's internal scaling constant, so the mapping survives that
  constant moving. Unlike
  `plot-posterior/` and `plot-scatter/`, this folder ships no `example.R`: the `## Examples` section
  inside `instructions.md` is the one runnable copy, assuming a `df` with column `x` and including the
  export block. `knowledge-index.md`'s `04` request table and file table gain the new rows.

  **The file introduces a four-part skeleton for plot types** — `## Purpose`, `## The rules`,
  `## Things to know`, `## Examples` — against the siblings' run of eight short sections, which made a
  reader scan eight signposts to reach ten facts. Eleven one-line settings (geom, layer order, bin
  width, layers, x range, x ticks, y-axis, colour, theme, labels, export) are table rows; prose is spent
  only on the two rules carrying a branch or a mechanism, and both sit under `Things to know` so that
  part generalizes to whatever remarks another plot type has. `Examples` states its preconditions once
  and numbers the code, so a second case has a home rather than being bolted onto one template.
  `COLOR_STANDARD.md` and `EXPORT_STANDARD.md` are named on the rows that bind them instead of behind a
  `../../standards/` folder pointer, which had also described a "theme standard" that folder does not
  contain. Four defects fixed in the same pass: `dplyr::count()`/`::` against `coding-rules.md`'s
  bare-call rule; `ggplot_build(p)$data[[1]]` silently reading the wrong layer once the Layers row's
  optional density curve is added, now pinned by a "`geom_dots()` first" row; the 10% padding fallback
  stated without its arithmetic, ambiguous between span and endpoint; and a template opening with no
  `#### ... ####` functional header. `plot-scatter/` and `plot-posterior/` keep their current shape —
  reshaping them turns on lab rulings that are not this entry's to make.

- **One name for the card, and a capitalization convention for terms.** The Writer Card was travelling
  under three names — `agents/code-writer.md`'s own frontmatter, `README.md`, and two `03-preprocessing/`
  references all called it the "execution card", while `knowledge-index.md` had "Writer's card" and
  `SKILL.md`'s reference table had "approval card" for the Summary Card. All now say **Writer Card** and
  **Summary Card**. `dispatch.md`, which defines it, retitles §1 "Building the Writer Card" and opens by
  naming the artifact rather than "a card". Alongside it, a convention: a term whose name is a compound —
  Summary Card, Writer Card, Code Writer, Exploration Pass — takes a capital on each word wherever it
  appears, so a reader sees it names a specific thing; a term that is a single ordinary word used
  precisely (job, dispatch, fit, route, plan, folder, gate) stays lowercase, as does bare "the card" in a
  passage already about one. `TERMS.md` states the rule and holds the list, and the repo `CLAUDE.md`
  carries it as a standing instruction.

- **Step 1 leads by placing the interview, and `interview.md` now closes.** `SKILL.md` Step 1 opens on
  the situation Malka is actually in — the user's request is in their own words and most of what the build
  needs is still unstated — then names the interview as what she does about it and its three moves: learn
  the request in light of the project and the data, surface what it implies, and put every open choice
  back to the user. It closes on the interview's aim, a request specified well enough to build from as it
  stands, and the stake: what gets settled here is what gets built. The aim is stated as a property of the
  request itself rather than by naming the later steps that consume it, since Malka reaches those in order
  anyway; the step's three bullets drop to the pointer, the card, and the halt. `TERMS.md` widens **the gate** to the
  whole checkpoint (summary card plus the halt on it) to match how `SKILL.md` now uses the word. `interview.md` gained a closing line handing back to that card and gate: its procedure had
  ended at "ask the questions" while already referring to a summary card it never introduced, so a reader
  following it end to end never reached the approval. The gate itself stays stated only in `SKILL.md`,
  which is loaded on every job, rather than behind a read that has to succeed.

- **Added `TERMS.md` at the plugin root**, beside `README.md` and `CHANGELOG.md`: eighteen rows naming
  each term of the Malka workflow, what it refers to, and which file settles it — summary card vs writer
  card vs `summary.md`, job/dispatch/folder as one 1:1:1 relation, `fit` as the unit that earns an
  `analysis/` folder, `ASSUMED` vs `BLOCKED`. It is a maintainer's index rather than a runtime read:
  nothing loads it on a job, and every term stays defined at the point it is used. The repo `CLAUDE.md`
  gains the paired rule — introducing, renaming, or retiring a term updates `TERMS.md`, and a runtime
  file names a concept with the word already there. `README.md` gains a pointer to it.

- **The folder count is now a number, not a paradigm.** A six-`brm()` specification — one formula over
  six filtered subsets — was planned as one `analysis/` folder and built as one, because all four
  statements of "One Model, One Folder" were descriptive prose with nothing to count and no gate.
  `analysis/rules.md` opens with a table keyed on what the folder *produces*: one folder per fitted
  model object, one folder for a coherent descriptive set (plots, tables, summary statistics), plus the
  trap stated outright — one formula over several filtered subsets is several fits, therefore several
  folders. Its "How the folder is handled" list gains a `BLOCKED` return when the specification handed
  to the Writer holds more than one fit, so the Writer counts independently of Malka's plan.
  `planning.md` gains a required "Count the fits before naming the folders" step ahead of the plan, with
  a fit count of zero for descriptive work so a plot folder stays whole; `interview.md`'s Bayesian bullet
  puts the count and the per-fit folder names on the summary card; `dispatch.md` §3 gains the
  `BLOCKED`-more-than-one-fit row; `project-rules.md` §1 gains the sentence distinguishing a fitting
  folder from a describing one. `simulations/rules.md` states that the per-fit count stops at
  `analysis/` — a recovery study fits the model back once per simulated dataset, and those fits are one
  study in one folder. `planning.md`'s opening also drops a leftover mention of the removed Reviewer.

- **Malka writes `summary.md`, not the Writer.** Every value in it — model name, formula, hypotheses,
  variables, data source and filter, sampler settings — comes from the specification Malka interviewed
  the user to produce, and the Writer only transcribed it; meanwhile the harness refuses `.md` writes
  from a subagent, so the attempt failed on all six dispatches of the job above and Malka rewrote all
  six by hand. `SKILL.md` gains Step 4b, writing the folder's `summary.md` from the approved
  specification on a clean return, shaped by that folder type's own `template_summary.md`; `dispatch.md`
  §2 routes the clean-return path through it. `code-writer.md` leaves the notebook to Malka in Stage 1
  and, in §4, returns any `.md` a job seems to need as a named block instead of writing it.
  `SKILL.md`'s opening paragraph stops pre-summarizing the steps and states the role and what rests on it
  instead — the job turns on Malka understanding the request, which she turns into a writer card carrying
  the `coding-knowledge` reads she routes to it, then dispatches a Writer to execute — before sending the
  reader to the steps. The outline it replaced duplicated the body in different words, and drifted
  from it: the old "four parts" never included handback, so adding Step 4b meant incrementing a count in
  a sentence that had never indexed the steps. Step 2's cross-reference now reads "Steps 3 through 4b",
  and Step 3 names the **writer card** to separate it from the Step 1 summary card the user approves,
  as Step 4b now does for `summary.md`.
  `analysis/rules.md`, `simulations/rules.md`, and `smart_clone.md` state the ownership split where they
  scaffold or clone the folder; `knowledge-index.md` records Malka's own Step 4b read of
  `template_summary.md`, off `ROUTED READS`. `smart_clone.md` step 4 also now takes the new model name
  and formula from the card's `SPECIFICATION` rather than telling the Writer to ask the user, which it
  has no channel to do.

- **Removed the Code Reviewer.** Malka now dispatches only `code-writer`, once per folder, with no
  PASS/FAIL loop and no revision rounds. The Reviewer's independent check was the main cost driver on
  every job — two full agent spawns per dispatch, up to three review rounds each re-reading the whole
  routed set, on jobs of every size regardless of how much actually needed checking. `code-writer.md`
  gains a Stage 3 self-check against the same rules, routed files, and specification the Reviewer used
  to gate on, so a job with real stakes is worth reading before it ships — nothing downstream checks it
  now. Deleted `agents/code-reviewer.md` and both `review-checklist.md` files (`02-scaffolding/`,
  `03-preprocessing/`); rewrote `knowledge-index.md` as a Writer-only routing table (dropped the `W`/`R`
  split), `dispatch.md` (one card, one dispatch, no loop), `planning.md`, `interview.md`, and `SKILL.md`
  to match. This is a workflow and invocation change — cut as a MAJOR version.

- Root `README.md`: added a one-time read-allowlist step, since routed reads of
  `references/` and `coding-knowledge/` land in the plugin directory outside the user's
  project and prompt for approval one file at a time. Documents the rule for both the
  marketplace and `--plugin-dir` installs, and records that Claude Code offers no
  plugin-level permissions field for the plugin to ship this itself.

- `plot-scatter/instructions.md`: tick marks are now 3 to 5 per axis, preferring 4, with a
  tick at each end of the scale and labels as full integers where possible (up to two
  decimals otherwise) — replacing the fixed four-tick rule.

- `02_diagnostics.md`: the summary table, trankplot, and pairs plot now run on the model's
  population-level parameters only. A hierarchical model's group-level `r_<group>[...]` draws (the
  per-individual/per-group varying effects) are dropped first via a `posterior::subset_draws()`
  filter; a non-hierarchical model has no `r_` parameters, so the same filter leaves it unaffected.

## [2.0.2] — 2026-08-04

- Repaired six stale cross-references and content contradictions found by a full
  consistency audit: `knowledge-index.md` cited `dispatch.md §1` for the cross-folder
  rule that now lives in `planning.md`; `README.md` undercounted Malka's references as
  four instead of five (missing `planning.md`); `handling-leaving-window.md`'s pointer
  into `shaharlab-jspsych` was missing the `skills/jspsych-coding-style/` path segment;
  `COLOR_STANDARD.md` pointed at a nonexistent "Single Color" section (now points at
  Okabe-Ito); `review-checklist.md`'s worked example saved output to a nonexistent
  `artifacts/data_clean.RDS` instead of `data/processed/data_processed.RDS`.
- **`simulation/`'s data-flow contradiction, fixed at every place it appeared.**
  `preprocessing/rules.md` still claimed simulations read from `data/processed/` — the
  exact claim `project-rules.md` §0 was corrected on in `[2.0.1]` — and
  `simulations/template_main.R`'s "Data Preparation" step was an unadapted copy of
  `analysis/`'s, reading from `data/processed/` instead of generating data.
  `simulations/rules.md` also called its `main.R` path block "Identical to `analysis/`"
  when it is that block minus `data_path`. All three now agree with
  `simulations/rules.md`'s own rule: a simulation generates its data and reads nothing
  from `data/`.
- **`code-walkthrough`'s Step D numbering, corrected.** `SKILL.md` told the agent to
  print "statement X out of X" (both placeholders the same letter) where
  `describe_statement.md`/`what_is_a_statement.md` define and use `M` as the total; its
  own loop-back sent the agent to "Step D item 7", which is a Step C item, and
  `describe_statement.md` separately looped back to a "Step D item 6" that doesn't
  exist — both now point at item 8, where Step D actually begins. `drilldown.md`'s
  return prompt was lowercase ("ok or drilldown?") where every other file uses the
  capitalized form; now consistent.
- **Malka reads `project-rules.md` §0 at Step 1 — she had been routing and planning without the tree.**
  Step 2 asks her to name the folders a job touches in dependency order, which is a pure topology
  decision, and Step 1 asks her to confirm the target folder; neither had any read behind it. Her four
  references never included the constitution, and the `00`/`01` rows in `knowledge-index.md` are marked
  `W`/`R` — the subagents, on their own standing instruction. This regressed when
  `agents/code-writer.md` stopped deriving the location from §0 ("your card's `FOLDER` names it") on the
  reasoning that §0's request-to-location table is Malka's routing material: the decision moved off the
  agent that held the table onto one that did not. §0 alone is routed to her — the tree, the
  request-to-location table, the one-way data flow that gives the plan its order, and the naming rule.
  §2–§4 stay off her reads deliberately: they are the Reviewer's criteria, and judging code is not her
  job. The read is stated in `interview.md` itself, which is the interview's one home — `SKILL.md` Step 1
  points at it rather than restating it, and its Scaffolding bullet now names the four destinations it
  asks her to choose between. `knowledge-index.md`'s `00` table carries a note that §0 is Malka's read too,
  unmarked because it reaches her on her own instruction rather than on a card, so restructuring §0 sends
  the editor to `SKILL.md` Step 2 as well as to the two agent files.
- **The exploration pass is stated once, in `interview.md`.** `SKILL.md` Step 1 had "for preprocessing
  jobs, dispatch the exploration card before asking any data-dependent question", while
  `interview.md`'s Preprocessing bullet independently said "explore `data/collected/` first". The
  Preprocessing bullet now carries both halves — that it is a dispatch, that it precedes any
  data-dependent question, and that the figures it returns are what to work from — and Step 1 is three
  bullets: read the interview, present the summary card, halt at the gate.
- **`FOLDER` bounds writing, not reading.** `agents/code-writer.md` had said to "read outside it only the
  files `PROJECT STATE` names", which made that slot a permission list and would have forced a `BLOCKED`
  round trip whenever the Writer needed the name of a model it sources or a column in `data/processed/` —
  things it can simply open, holding §0's whole tree and `Glob`/`Grep`. The read-only-what-is-routed rule
  belongs to `ROUTED READS` and the `coding-knowledge/` library, where over-reading costs context without
  adding diligence; the project is not that. Writes stay confined to `FOLDER`, and `PROJECT STATE` is now
  stated as a head start — what Malka already knows matters — rather than the limit. Wording follows in the
  card skeleton, the `FOLDER` and `PROJECT STATE` slot prose, both agent files' slot tables, and the
  Reviewer's card summary. The Reviewer's Layer 1 check was already writes-only and is unchanged.
- `planning.md` takes four headings — one dispatch one folder, the plan, what you return, what you tell the
  user — with the boundary's two directions as a **no smaller / no bigger** pair rather than a paragraph, and
  a worked example of each thing it produces: the internal list and the sentence the user hears. `SKILL.md`
  Step 2 is one line pointing at it, its three paragraphs of detail having belonged in the reference all along.
- **Step 2 states what it returns**, which it had not — the only step in `SKILL.md` without a defined
  return, where Step 1 returns an approved summary card, Step 3 two cards, and Step 4 a verdict. It returns
  the ordered list, held in the conversation rather than written to disk, and held *as written*: Step 4
  comes back to it after every `PASS`, and a plan re-derived mid-job can come back different. Malka tells
  the user the plan when it runs to more than one entry — a statement, not a gate, since Step 1's approval
  is the only one, and worth making because a wrong plan costs a dispatch cycle per entry and the user is
  the one who knows whether `data/processed/` is already current.
- **Planning moves out of `dispatch.md` into its own `references/planning.md`.** It had been that file's §1,
  which meant Step 2 opened the card format in order to reach the planning rule — handing Malka a slot
  skeleton at the one moment she should be deciding what the jobs *are*. Deciding the jobs and instantiating
  one of them are different acts, and the structure was inviting the second before the first had finished.
  `planning.md` carries the one-dispatch-one-folder rule, both directions of that boundary, the chain across
  folders, and the plan's one-line-per-job shape; `dispatch.md` renumbers to four sections — Writer §1,
  Reviewer §2, loop §3, troubleshooting §4 — and opens by stating it runs once per entry in the plan.
  `SKILL.md` Step 2 now reads `planning.md` and says to settle the plan before opening `dispatch.md`; its
  reference table and the repo's `.claude/CLAUDE.md` list the new file; §4's symptom table sends a
  cross-folder write to `planning.md` to revise the plan rather than citing a section that moved.
- **Step 2 is "Specify the Jobs" — one paragraph, and it starts from the approved specification.** It had
  been three bullets about naming folders, which described the mechanism rather than the work. Malka now
  turns the specification into a list of jobs, each written as what it produces plus the one folder it
  writes into, ordered by §0's one-way data flow. The worked two-line list showing that shape sits in
  `dispatch.md` §1, where the rule and the other worked examples live, rather than in the procedure. Step 2
  opens `dispatch.md` at §1 and Step 3 builds from §2–§3 of the file already open, so the read is
  instructed once instead of trailing each step as a citation.
- **Planning the dispatches is its own step, and routing is now per dispatch.** `SKILL.md` Step 2 had
  Malka "select the files this job needs — the stage or stages involved", which is job-level routing;
  one-folder-per-dispatch had already made routing per-dispatch, and `knowledge-index.md` had caught up
  while `SKILL.md` had not. Her steps are now five: interview, **plan the dispatches** (name the folders in
  dependency order — one line for the single-folder job that most jobs are), route and build both cards,
  dispatch and supervise the loop, hand back. Steps 3 and 4 repeat once per entry in the plan — an outer
  loop that had existed only implicitly, mentioned nowhere but inside `dispatch.md`'s loop section.
- `dispatch.md` §1 becomes **Planning the dispatches**, holding the scope rule that Step 2 acts on, and the
  Writer, Reviewer, loop, and troubleshooting sections shift to §2–§5. Every cross-reference moved with
  them: the card skeleton's `ROUTED READS` placeholder cites Step 3, the loop sends a finished job to
  Step 5, `SKILL.md` cites §1 at Step 2 and §2–§3 at Step 3 and §4–§5 at Step 4, `knowledge-index.md` and
  the repo's `.claude/CLAUDE.md` cite Step 3 for routing, and `interview.md`'s preprocessing bullet cites
  Step 3 for what the script kinds route on. `dispatch.md`'s "your conversational role stays open past
  Step 2" now says "past the interview gate", dropping a cross-file step number that carried no weight.
- Step 2 states the one dispatch it does **not** cover: the Step 1 exploration pass runs before the
  approval gate and lands in no folder, per worked route E.

## [2.0.1] — 2026-08-04

- **The two `04-visualization` plot instructions stop opening with routing trivia.** Both said "Reached
  from `visualization`'s routing table in `…/knowledge-index.md`. This is a reference file, not a skill" —
  a craft file telling the Writer how it was routed, which the Writer cannot act on, and naming a
  `visualization` skill that no longer exists. Their one useful claim was misattributed: the routing table
  does not own "the global theme and export rules", `references/standards/` does. Each header is now two
  lines — what the file owns, where the global standards live, and its `example.R`.
- **`dispatch.md`'s guidelines section is dissolved into the slots it governs; the file is four sections.**
  A guideline separated from the slot it governs gets read once and is not consulted while that slot is
  being filled, and four of the five were about something in the Writer's or Reviewer's section. Each moved
  to where it is acted on: *one dispatch, one folder* opens §1 as the scope decision that precedes any card;
  *point, don't paste* is a clause in `ROUTED READS`, the slot that lists the paths; *build both cards
  before dispatching either* opens §2, where the Reviewer's card is derived. The two that govern no single
  slot — leave standing behaviour to the agent files, keep the card to a screen — are stated once in the
  file's opening paragraphs alongside the empty-context claim they follow from. Sections renumber: Writer §1,
  Reviewer §2, loop §3, troubleshooting §4, with `SKILL.md` Step 3 and §4's symptom table following.
- **`dispatch.md` §2 now says when the Reviewer's card can actually be finished.** "Build both cards before
  dispatching either" sat beside a `TARGET` slot defined as "the paths the Writer returned", which Malka
  cannot know until the Writer runs. §2 states it: every slot but `TARGET` is fixed when the pair is built,
  and `TARGET` fills in from the return.
- **`dispatch.md` §1 was "Dispatch guidelines" — seven numbered guidelines, each with its context.** The
  section had held three one-line bullets and a four-paragraph `### One folder per dispatch` subsection,
  which were the same kind of statement at two different weights. All seven now take one shape: guidelines
  1 bounds how much work a dispatch covers, 2–5 bound what goes into the card (build both first; point
  don't paste; leave standing behaviour to the agent files; keep it to a screen). Scope is **one**
  guideline, not three: "cover as much of that folder as the job needs" and "a job that crosses folders is
  a chain of dispatches" are the two directions of "one dispatch, one folder" rather than rules of their
  own, and stating them separately had duplicated the three-round budget in both. Numbering makes them
  citable — §5's troubleshooting table sends a cross-folder write to guideline 1, and "build both cards
  before dispatching either" moves out of the file's opening line into guideline 2. `SKILL.md` Step 2 stops
  restating the scoping rule and points at §1 instead.
- **`dispatch.md`'s worked cards are now numbered examples under a "Cards examples" subtitle.** The three
  `### Worked card — …` headings became `#### Example 1–3 — …` sub-subtitles grouped under a `### Cards
  examples` heading in §2 and §3, and the §3 example titles itself by the example it reviews rather than
  by "the analysis dispatch above". The table of contents cites the example numbers.
- **§0 no longer claims that `simulation/` reads from `data/processed/`.** Its data-flow diagram said
  "`analysis/` · `simulation/` read from here" while
  `01-folder-specific-rules/simulations/rules.md` states that a simulation generates its data from a
  `models/` definition and reads nothing from `data/` — the specific rule is the correct one. The
  diagram now shows the analysis path and the generation path separately, and §2.I's Reading bullet
  scopes the `data/processed/` default to `analysis/`.
- **The agent files cite the constitution instead of restating it.** `agents/code-reviewer.md` opened
  with "Cite rules, never restate them" and then restated five of them in Layer 1 — the path block, the
  read-from-`data/processed/` rule, the library placement, the artifact split, and the no-numbered-
  scripts rule. Layer 1 is now five pointers (`project-rules.md` §2, §3–§4, the folder's `rules.md`,
  `coding-rules.md`, and the card's `FOLDER`), so a change to a rule cannot leave the reviewer checking
  a stale copy. Layer 2 drops its enumeration of `coding-rules.md`, and `agents/code-writer.md` Stage 1
  cites §4's path block and `coding-rules.md`'s `#### SETUP ####` block rather than listing their
  contents. The "Always read first" glosses in both agent files shrink to a few words each, since they
  had been restating `knowledge-index.md`'s **What it governs** column for files the agent opens on the
  next line. The imperative and the paths stay where they are — the agent files load before the card,
  so a read stated there survives a card that forgot it, which is why `ROUTED READS` omits these three.
- **`data_path` is now stated where the other paths are.** `coding-rules.md` already told sourced
  scripts to load data "via the `data_path` variable passed from `main.R`", but no rule required it and
  no template defined it — the variable was named only inside `agents/code-writer.md`. §4 now carries
  it, conditionally: a folder that reads a stored stage defines it, and a simulation generating its own
  data leaves it out, per `01-folder-specific-rules/simulations/rules.md`. `analysis/rules.md` and
  `analysis/template_main.R` gained the line, and the template's data-read example now goes through
  `data_path` instead of rebuilding the path from `project_root`.
- **Both agent files take the same numbered outline as `dispatch.md`**, so knowing one teaches the other:
  §1 your card, §2 what you always read, §3 the work, then protocol. The Writer's §3 gathers the two
  build stages and the specification-gap rules under one **Building** section — they had been top-level
  siblings of the return protocol — and the Reviewer's §3 gathers the three layers. Four of the
  Reviewer's former top-level sections were 2–3 lines each and now sit where they belong: `ASSUMED` tags
  beside the `REVIEW` tag format in §4, "on a later round" and "when you cannot judge" inside §5's
  verdicts. Neither file takes a contents list — at 90 and 76 lines the numbered headings are the
  outline, where `dispatch.md` earns one at 268.
- **The Reviewer's example finding cited a section that does not exist.** Its tag format showed
  `# REVIEW[coding-rules §3.2]`, and `coding-rules.md` has no numbered sections at all — the format
  example taught a citation scheme with nothing behind it. For the hardcoded path it shows, the real
  citation is `project-rules §4`.
- **`dispatch.md` is outlined by what Malka does, not by concept**: five numbered sections — how dispatch
  works, dispatching the Writer, dispatching the Reviewer, running the loop, troubleshooting. The slots
  are defined once, in the Writer's section, and the Reviewer's section carries only the four-move delta,
  so an agent-oriented outline costs no restatement. One paragraph opens the file — what a card is, and what
  the file covers — since Malka reads it end to end and the numbered headings are the outline. The "build both cards before
  dispatching" rule lives here rather than in `SKILL.md` Step 2, which now only points at the
  file; and the three card properties keep their rules while dropping the rationale for a rule that
  §2's `ROUTED READS` states operationally. §1 now opens with the claim its three rules follow from — a
  subagent starts with an empty context, its agent file arrives first and the card second, so a card is a
  context Malka assembles and every rule is about what to leave out. `SKILL.md` Step 3 cites §4 and §5 by
  number rather than pointing at a section title.
  Troubleshooting gains a symptom table mapping each `BLOCKED` return to its cause and its fix; the two
  failure paths were previously trailing subsections.
- **The card is six slots, and `dispatch.md` now carries two worked examples.** `JOB`, `FOLDER`,
  `ROUTED READS`, `PROJECT STATE`, `SPECIFICATION`, `RETURN`, ordered by when the agent uses them, with
  `SPECIFICATION` in the card's tail where attention is highest. Three slots left:
  - `ENVIRONMENT` was a per-dispatch summary of §4's path block, `coding-rules.md`'s `#### SETUP ####`
    block, and each routed file's own assumptions — content both agents already hold in full, restated
    by Malka in the one place paraphrase can lose it. `knowledge-index.md` now states the invariant it
    rested on: a routed file names the variables and packages it assumes.
  - `TARGET` moved to the Reviewer's card alone. It read "the paths the Writer returned", which cannot
    be true of the Writer's own round-1 card, and filling it meant Malka naming files that the folder's
    `rules.md` already governs — a position from which she could contradict them. Where the *user*
    named a script to revise, `PROJECT STATE` carries it.
  - `TASK` became `JOB`: it was constant ("write the code") where the agent file already says so. It
    now names the job in the user's terms and **carries no values**, so it cannot disagree with
    `SPECIFICATION` — the one failure this rename could otherwise have introduced.
- **The two cards differ in exactly `TARGET` and `ROUTED READS`**, plus the verb in `JOB` and the values
  in `RETURN`; `FOLDER`, `PROJECT STATE`, and `SPECIFICATION` are copied unchanged. `dispatch.md` states
  it as a four-move derivation from the Writer's card, so a mis-built pair is visible before dispatch.
  `PROJECT STATE` is no longer trimmed for the Reviewer — Layer 1 checks the data source, which it can
  only do if it was told the stage.
- **The revision block names every file carrying findings.** It read "Your previous attempt is at
  `[path]`", singular, while a single dispatch can write six preprocessing scripts. With `TARGET` off
  the Writer's card this block is the only place it learns which files to reopen.
- **`ROUTED READS` carries decisions, not consequences.** `dispatch.md` states why the two constitution
  files and the folder's `rules.md` stay off it: `FOLDER` determines them, and a read the agent file
  states survives a card that forgot it.
- **One dispatch covers as much of one folder as the job needs** — a fit, its diagnostics, and its plot
  are one dispatch, not three. Stated so that "one folder per dispatch" is read as a ceiling on scope
  rather than an instruction to split within a folder. `skills/malka/SKILL.md` Step 2 names the rule.
- **One folder per Writer dispatch.** The card's `FOLDER TYPES` slot became `FOLDER`: one folder, and
  the Writer writes only inside it, making §1's "One Model, One Folder" the boundary of a dispatch as
  well as of the filesystem. `preprocessing/` counts with the `data/` stages it builds, since the
  `converting_` scripts write them. A job touching two folders is now two dispatches in dependency
  order, each with its own review loop and three-round budget; what crosses between them travels in
  `PROJECT STATE`, named as paths with the columns and objects the Writer should expect.
  `dispatch.md` gains a "One folder per dispatch" section and loses roughly a third of its prose;
  `agents/code-writer.md` blocks on a write outside `FOLDER`, and `agents/code-reviewer.md` checks
  Layer 1 against it. Every `FOLDER TYPES` mention in `knowledge-index.md` — the routing steps and all
  five worked routes — now reads `FOLDER`, and none of the routed reads changed.
- **`TARGET` is the file *or files* a dispatch writes.** It read "one path" while worked route A had a
  single dispatch writing six preprocessing scripts, and the Reviewer's `PASS` condition spoke of "the
  file". Both now say what they meant: `PASS` requires no `REVIEW` tag in any target file.
- `agents/code-writer.md` no longer restates the 50–80 line rule in Stage 2 — `coding-rules.md` carries
  it as read 2 on every job.
- The repo's `.claude/CLAUDE.md` named two Malka references that no longer exist,
  `guidelines-execution-card.md` and `guidelines-dispatch-subagents.md`; both are `dispatch.md`.
- **The constitution now states only what the subagents act on; the decisions moved to Malka.**
  `project-rules.md` §5 (the Visualization Mandate) and `coding-rules.md`'s "Mandatory Plotting Rule"
  both ordered the Writer to read `04-visualization/.../plot-posterior/instructions.md`, which
  `agents/code-writer.md` forbids reading unless the card routed it. Both are removed; the rule
  reaches the agents where it can act — `knowledge-index.md`'s `04` trigger table routes it, and
  `01-folder-specific-rules/analysis/rules.md` states it as a binding read on any analysis job.
- **`project-rules.md` §6 (the Operational Mandate) is removed and its rule restated as an action.**
  "The agent must proactively suggest splitting" addressed nobody — a subagent has no channel to the
  user. The length rule now sits in `coding-rules.md` under "Core R coding guidelines": write each
  script as one step of 50–80 lines, sourced from `main.R`, splitting a longer one into two named
  steps. That is also where `agents/code-reviewer.md` already cited it from.
- **Naming the folder is the interview's job, not the Writer's.** §0's "Ask the user for a name"
  becomes "Take the name from the approved specification", and `interview.md`'s Scaffolding bullet
  now asks for a `snake_case` name whenever the user has not given one.
- **The Writer consumes the routing decision instead of re-deriving it.** Stage 1 step 1 of
  `agents/code-writer.md` read "Determine where the work lives per `project-rules.md` §0" while the
  card's `FOLDER TYPES` slot already stated it — two authorities for one decision, in a context that
  cannot ask which wins. It now builds where the card says, and returns `BLOCKED` when the card's
  type contradicts what the work plainly is (a `.stan` definition on an `analysis` card, against
  §2.III). §0 keeps the tree and the boundaries as invariants; deciding the location is Malka's.
- **Each script now ends by saving its product and starts by loading what it needs.** Two bullets in
  `00-constitution/project-rules.md` §2.I (the Artifacts Rule) state the contract: a sourced script
  writes its data frame or fit to `artifacts_dir` and its figure or table to `output_dir`, and reads
  an earlier step's product back from `artifacts_dir` instead of relying on an object left in the
  environment. `00-constitution/coding-rules.md` carries the R-level form under "Using paths in
  sourced scripts", with a `# reads: … · writes: …` opening line per script. Effect: `main.R` can be
  resumed from any `source()` line in a fresh session. Both files already route to the Writer and the
  Reviewer, so no `knowledge-index.md` change.
- `coding-knowledge/01-folder-specific-rules/data/` → `01-folder-specific-rules/preprocessing/`.
  The subfolder is named for the project part that holds the code, and its `rules.md` is retitled
  "The `preprocessing/` folder and the `data/` stages it builds". Every path naming it is updated:
  `project-rules.md` §0 (tree and scaffolding table), `knowledge-index.md`, both agent files,
  `guidelines-execution-card.md`'s `BINDING READS`, and the repo's own `.claude/CLAUDE.md`.
- **`preprocessing/code/` scripts now carry one of three prefixes**, stated in
  `01-folder-specific-rules/preprocessing/rules.md` under "Naming the scripts": `converting_` moves
  data between stages and saves it, `examining_` inspects one stage and reports what is in it,
  `summary_` reports for the researcher and the manuscript. The three cover the whole of
  preprocessing; work fitting none of them is an analysis. Because it lives in a `rules.md`, the
  rule reaches both agents as a binding read rather than a routed one.
- **The pipeline is re-cut along those three prefixes**, so each script does one job.
  `build_raw.R` → `converting_data_collected_to_raw.R` (restructure, type, drop what was never
  data); `build_processed.R` → `converting_data_raw_to_processed.R` (the two-phase exclusions);
  the description tables move out of both into `examining_data_raw.R` and
  `examining_data_processed.R`; the exclusion cascade moves into `summary_exclusions.R`; and
  `manuscript_paragraph.R` → `summary_manuscript_paragraph.R`. `converting_` scripts now write data
  only, and the reports are written by the `examining_`/`summary_` scripts that carry their names.
- `coding-knowledge/03-preprocessing/references/writing-code.md`: removed, split into one `how-to-`
  file per script kind — `how-to-convert-collected-to-raw.md`, `how-to-convert-raw-to-processed.md`,
  `how-to-examine.md`, `how-to-summarise-exclusions.md`. Each owns the craft for the scripts it
  names and cites the one worked example that shows its output, so Malka routes by which scripts the
  job writes instead of handing over the whole pipeline every time.
- `coding-knowledge/03-preprocessing/`: the three loose `.md` files move back under `references/`,
  matching every other multi-file domain and the repo's own document rule.
- `coding-knowledge/03-preprocessing/assets/template_main.R`: removed. It duplicated
  `01-folder-specific-rules/preprocessing/template_main.R` byte for byte; the surviving copy sits
  with the folder rules, so rules and boilerplate stay one routed read. That template now sources
  all six pipeline scripts in order, loads `knitr`, and states what each step writes.
- `coding-knowledge/03-preprocessing/assets/`: `example-collected-to-raw-report.md` →
  `example-examining-report.md`, `example-raw-to-processed-report.md` →
  `example-summary-exclusions.md`, each re-cut to show one script's output.
- `coding-knowledge/03-preprocessing/references/review-checklist.md`: opens with the script each
  review phase lands on; Phase 1 checks the three prefixes and one-job-per-script; Phase 6's
  deliverables list is the five new output files.
- `coding-knowledge/03-preprocessing/references/exploration.md`: states its boundary against
  `how-to-examine.md` — this is the one-off console pass over `data/collected/` that feeds the
  interview, while `examining_` scripts are the examination that reruns with every build.
- The preprocessing examples drop `::` in favour of bare calls with the library loaded in `main.R`,
  per `00-constitution/coding-rules.md`. `here::here()` stays, as `project-rules.md` §4 mandates it
  verbatim.
- `skills/malka/references/knowledge-index.md`: the `03` section gains a "the job writes → route
  the Writer to" table, so a job that only revises exclusions routes two files rather than the whole
  domain, and a note that `template_main.R` lives with the folder rules.
- `skills/malka/references/interview.md`: the preprocessing gap-list settles which of the three
  script kinds the job writes, since that is what Step 2 routes on.
- `skills/malka/references/user-request-summary.md`: the preprocessing example card saves to
  `data/processed/` rather than a `data/data_filtered/` that no rule defines.
- `coding-knowledge/02-scaffolding/references/review-checklist.md`: the models check cited
  `01-folder-specific-rules/models-folder.md`, which does not exist; it now cites
  `01-folder-specific-rules/models/rules.md`.
- `README.md` (both): the layout and domain tables list `01-folder-specific-rules/`, which was
  missing, and describe `03-preprocessing/` by its three script kinds.
- `coding-knowledge/00-constitution/coding-rules.md`: adds a Core R coding guideline to avoid `::`,
  adding any missing package's `library()` call to `main.R`'s setup header (or the script top, if
  there is no `main.R`) instead.
- Lab topology moves out of the scaffolding domain and is rewritten, split by project part across
  `00-constitution/project-rules.md` §0 and the new `01-folder-specific-rules/`. The old
  `01-scaffolding/references/folder_structure.md` is removed.
- `coding-knowledge/00-constitution/project-rules.md`: gains a `§0 Project Outlook` — the whole
  tree at a glance, which `folder-specific-rules/` subfolder covers each part, the one-way
  `collected → raw → processed` data flow, and `snake_case` naming. This file is now the single
  source of truth for topology.
- `coding-knowledge/01-folder-specific-rules/`: new domain, one subfolder per top-level project
  part — `data/`, `analysis/`, `models/`, `simulations/`. Each holds a `rules.md` stating that
  folder's structure, what every file and subfolder is for, and how it is handled at runtime,
  together with the templates that build it, so rules and boilerplate are one routed read. It sits
  at the top level of `coding-knowledge/` rather than inside `00-constitution/`, so the numeric
  prefix states when a domain is read: `00` on every job, `01` by folder type, `02`+ by craft.
- **Domains renumbered** to make room: `01-scaffolding` → `02-scaffolding`, `02-preprocessing` →
  `03-preprocessing`, `03-visualization` → `04-visualization`, `04-bayesian-regression` →
  `05-bayesian-regression`. Every path naming them is updated across both agents, Malka's
  references, and the knowledge files.
- `coding-knowledge/01-scaffolding/assets/`: removed. `template_main.R` and `template_summary.md`
  now sit in `folder-specific-rules/analysis/` and `folder-specific-rules/simulations/` with the
  `<parent>` segment pre-filled per type; `template_model.R` and `template_model.stan` sit in
  `folder-specific-rules/models/`; `folder-specific-rules/data/template_main.R` is the
  preprocessing orchestrator. `01-scaffolding/` now holds `references/` how-to only
  (`new_folder.md`, `smart_clone.md`, `review-checklist.md`).
- `coding-knowledge/01-scaffolding/references/new_folder.md`: removed. Every section restated what
  the per-folder `rules.md` files and `project-rules.md` §0 now say. Its one unique part — the
  request → location → templates routing table, including the clone row — moves into
  `project-rules.md` §0 as "Scaffolding a new folder". `01-scaffolding/` now holds only what the
  constitution does not cover: `smart_clone.md` and `review-checklist.md`.
- `skills/malka/references/knowledge-index.md`: rewritten as a file-by-file routing table. One row
  per file on disk, with `W`/`R` columns stating which card each path belongs in, so filling
  `ROUTED READS` is reading down a column rather than inferring from prose. The ASCII tree and the
  paragraph-long per-file summaries are gone — each file's subject is now one line, and the file
  itself is the only place its content lives. Adds a four-step "How to route a job" opening, keeps
  the per-request routing tables for visualization, and closes with the maintenance rule that every
  row is a file and every file is a row.
- `skills/malka/references/guidelines-execution-card.md`: `BINDING READS` now includes
  `folder-specific-rules/<type>/rules.md` for every folder type the job touches, so the per-folder
  rules are guaranteed rather than left to routing.
- `agents/code-writer.md`, `agents/code-reviewer.md`: "Always read first" gains the same
  per-folder `rules.md`. The Writer's Stage 1 now reads that file when it determines the folder
  type and injects templates from the matching subfolder; the Reviewer's Layer 1 checks the
  folder against it.
- `coding-knowledge/01-scaffolding/references/review-checklist.md`,
  `coding-knowledge/02-preprocessing/references/writing-code.md`: pointers to
  `folder_structure.md` now resolve to `project-rules.md` §0 or the matching `rules.md`.

## [2.0.0] — 2026-07-30

**Headline (breaking):** Malka is now a skill (`skills/malka/`) that indexes a `coding-knowledge/`
tree and directs two subagents — `code-writer` (writes code) and `code-reviewer` (reviews it).
The four domain skills are gone: `bayesian-regression`, `data-preprocessing`, `plotting`, and
`project-scaffolding` are no longer invocable, and their content lives under
`coding-knowledge/00-constitution|01-scaffolding|02-preprocessing|03-visualization|04-bayesian-regression/`
as read-only `references/` and `assets/`. `skills/` now holds `malka` and `code-walkthrough` only;
`agents/` holds `code-writer.md` and `code-reviewer.md` only (`brms-expert`, `code-architect`, and
`malka-orchestrator` are removed). Every analysis request enters through Malka, who interviews the
user, clears the approval gates, names the exact knowledge files each subagent reads, and supervises
the build/review rounds. Malka's index lives in `SKILL.md` plus five reference files:
`interview.md`, `knowledge-index.md`, `guidelines-execution-card.md`,
`guidelines-dispatch-subagents.md`, and `user-request-summary.md`.

Lab members who invoked `/shaharlab-behavioral-data-analysis:bayesian-regression`, `:data-preprocessing`,
`:plotting`, or `:project-scaffolding` now invoke `/shaharlab-behavioral-data-analysis:malka` (or
just describe the task) instead.

The entries below record how that architecture was reached, newest first. Names in the older
entries reflect the structure at the time they were written — `code-architect` became
`code-writer`, and the `execution-template-*` / `execution-code-*` / `index.md` files became the
`guidelines-*` and `knowledge-index.md` set listed above.

- fix: repaired every dangling file pointer left by the rename, so each path a runtime file names
  now resolves on disk — `skills/malka/SKILL.md`'s reference table pointed at
  `references/interview_guide.md` (the file is `references/interview.md`);
  `guidelines-dispatch-subagents.md` sourced the revision block from a nonexistent
  `references/execution-cards.md` (it lives in `guidelines-execution-card.md`'s "Writer card,
  revision rounds" section); `guidelines-execution-card.md` promised a worked-example file
  `references/examples.md` that was never created (section dropped); and four
  `coding-knowledge/` files (`00-constitution/coding-rules.md`, `00-constitution/project-rules.md`,
  both `03-visualization` plot-type `instructions.md`) still routed via
  `skills/malka/references/index.md`, now `knowledge-index.md`.
- docs: updated both READMEs and the plugin/marketplace descriptions to the shipped architecture —
  agents are `code-writer` + `code-reviewer` (dropping the "Sharon"/"Tomer" character names and the
  removed `brms-expert`), Malka's five reference files are listed by their real names, the layout
  block shows `coding-knowledge/`'s five numbered domains instead of the old `knowledge/` +
  `references/` split, `00-constitution/` is added to the plugin README's domain table, and the
  jsPsych plugin is described as having its own `code-architect` pair rather than sharing one.
- knowledge: major revision of `02-preprocessing`'s reporting system, written entirely in
  straight-line `dplyr`/`tidyr` with named intermediate objects — no custom `function()`s and
  no `apply`-family calls, per `00-constitution/coding-rules.md`. `raw` → `processed` runs as
  two ordered phases: participant criteria first, then trial criteria on the survivors, each
  step assigned its own named dataset (`after_incomplete`, `after_fast_rt`,
  `after_no_response`, `after_rt_bounds`) so the pipeline order reads off the code and each
  count comes from comparing two named datasets; every cutoff is held in a named variable set
  once from the approved plan and reused in both the filter and the report's criterion text.
  Five "Describing the data" blocks adapt to whatever columns a dataset has, via
  `pivot_longer` + `group_by`/`summarise` rather than iteration: numeric columns
  (missing/min/mean/max per column), categorical columns (levels and labels per column),
  sample overview (N, participants, trials per participant, RT mean/SD/range), per-participant
  table sorted worst-first so exclusion candidates surface before any criterion runs, and a
  per-design-cell table. `collected-to-raw-report.md` = rows kept/dropped + all five blocks;
  `raw-to-processed-report.md` = exclusion cascade per phase (criterion in the user's own
  words, omitted, percent of what was there via `dplyr::lag()`, remaining) + final count + the
  same five blocks on the processed data, so the two reports read side by side. Both are plain
  Markdown tables via `knitr::kable(format = "pipe")` + `writeLines()` with
  `options(knitr.kable.NA = "")` set in `main.R`, no plots. Verified the whole set runs clean
  on dplyr 1.2.1 / tidyr 1.3.2 against synthetic trial data. Dropped the
  separate data-quality PDF (folded into the description blocks) and the
  `template_report_helpers.R` asset. Updated `writing-code.md`, `review-checklist.md`,
  `exploration.md`, `template_main.R`, both example assets, `01-scaffolding/references/
  folder_structure.md`, `README.md`, and
  `skills/malka/references/{interview,knowledge-index}.md` to match.
- knowledge: rewrote `skills/malka/references/knowladge-index.md` to match the files actually
  on disk under `coding-knowledge/` — corrected the tree (03-visualization's `standards/` and
  `plot-types/` sit under a `references/` subfolder; 01-scaffolding and 02-preprocessing each
  have a `references/` and `assets/` split), added the two 01-scaffolding template assets and
  the model-folder template pair that were missing from the old tree, and gave every file a
  one-line, content-accurate description. Flagged in the index that
  `04-bayesian-regression/review-checklist.md` referenced there previously does not exist on
  disk — the domain currently has no reviewer checklist file.
- agents: removed character names "Sharon" and "Tomer" from `agents/code-architect.md` and
  `agents/code-reviewer.md` respectively. Both agents now referred to by their role titles
  ("the Code Architect", "the Code Reviewer") throughout their mandate, reference lists, and
  working rules.
- knowledge: deleted `coding-knowledge/03-visualization/references/routing.md` — its
  routing table, procedure, and mandatory rules are merged into
  `skills/malka/references/index.md`'s `03-visualization/` section, which already served
  as Malka's map of that folder. Every pointer to `routing.md` (`agents/code-architect.md`,
  `coding-knowledge/00-constitution/project-rules.md` and `coding-rules.md`, the
  `plot-posterior`/`plot-scatter` `instructions.md` headers) now points at `index.md`
  instead.
- architecture: replaced `execution-template-code-writer.md` and
  `execution-template-code-reviewer.md` with `execution-code-code-writer.md` and
  `execution-code-code-reviewer.md` — same content, structure, and per-domain blocks, plus a
  "Context & Goal" section stating each agent's goal explicitly (Sharon: build correctly on
  the first pass without re-asking; Tomer: verify against rules and approved values without
  touching disk), the reading-list-building instructions (constitution files + domain files
  via `index.md`) folded into the writer brief, and an embedded, runnable execution-code
  example in every domain block — a build snippet in the writer file, a red-flag-vs-correct
  snippet in the reviewer file. Also fixed several stale bare `references/...md` mentions
  left over from the `coding-knowledge/` rename (bayesian-regression's checklist and priors
  files have no `references/` subfolder; scaffolding's and preprocessing's cross-references
  needed the full `coding-knowledge/0N-domain/` prefix). Pointers to the two old filenames
  updated everywhere across the plugin; the old files are deleted.
- knowledge: added `skills/malka/references/index.md` — a file-by-file map of
  `coding-knowledge/` (one line per file across `00-constitution/`, `01-scaffolding/`,
  `02-preprocessing/`, `03-visualization/`, `04-bayesian-regression/`), so Malka can name the
  right `READ:` file without guessing. `SKILL.md` now lists it as Malka's fifth reference
  file, and its Step 2 reading-list bullet (fixed after being left mid-edit) points to it and
  to the `00-constitution/coding-rules.md` + `project-rules.md` pair every build reads.
- architecture: moved `interview_guide.md`, `execution-template-code-writer.md`, and
  `execution-template-code-reviewer.md` into a new `skills/malka/references/` subfolder,
  and added `references/examples.md` — four worked summary-card examples (bayesian
  regression, preprocessing, visualization, scaffolding) in the plain-English format
  Malka's Step 1 confirmation card follows, referenced from `SKILL.md`'s Confirming bullet.
  Pointers updated everywhere across the plugin.
- architecture: split `skills/malka/execution_template.md` into two per-agent dispatch
  briefs — `execution-template-code-writer.md` (shared environment contract, brief
  skeleton, and the four domain blocks with what Sharon carries, reads, and delivers) and
  `execution-template-code-reviewer.md` (shared review contract, review-brief skeleton, a
  matching block per domain naming the checklist plus the approved values Tomer measures
  against, the scaffolding Phase A/Phase B distinction, and the domain → checklist table).
  Each file now points at the other where the handoff happens; the "Dispatching the
  reviewer" section moved out of the build brief entirely. Pointers updated in
  `skills/malka/SKILL.md`, `interview_guide.md`, `agents/code-architect.md`,
  `agents/code-reviewer.md`, `knowledge/preprocessing/references/writing-code.md`,
  `knowledge/visualization/references/routing.md`,
  `knowledge/scaffolding/references/new_folder.md`, and the README.
- architecture (major): merged the four per-domain `interview.md` files into one
  `skills/malka/interview_guide.md` and the four per-domain `execution_template.md` files
  into one `skills/malka/execution_template.md`, each with one section/block per domain in
  dependency order (scaffolding → preprocessing → bayesian-regression → visualization).
  `knowledge/` now holds no interview or dispatch file at all — only `references/` and
  `assets/`. Deduplicated in the merge: the environment contract (`project_root`,
  `code_dir`, `artifacts_dir`, `output_dir`, `data_path`, libraries in `main.R`, artifacts
  vs output) was stated four times across the domain templates and is now stated once;
  the four separate "Gate Check" blocks collapse into one gate table plus per-section
  items; the shared interview conduct rules (lead with a proposal, take every threshold
  from the user, one gate proposal per message) are stated once.
- knowledge: relocated the craft content that the deleted execution templates carried into
  the domains' own `references/`, so each rule keeps exactly one home — new
  `preprocessing/references/writing-code.md` (script layout, pipeline skeleton, coercion
  and filtering patterns, manuscript-paragraph style), new
  `visualization/references/routing.md` (routing table, procedure, mandatory rules, how to
  add a plot type), and `scaffolding/references/new_folder.md` gains the folder-type
  routing table and the Direct Scaffolding steps that Sharon reaches directly in Stage 1.
- knowledge: added `bayesian-regression/references/review-checklist.md`, so all four
  domains now expose a checklist file for Tomer instead of bayesian-regression's checks
  living inside its execution template.
- malka: `SKILL.md` Step 2 now reads `interview_guide.md` and asks sequentially, one
  question per message formatted as a `- [ ]` checklist for the interactive terminal UI,
  waiting for each answer; Steps 3–4 point at `execution_template.md`'s per-domain block
  and its domain → reviewer-checklist table.
- agents: repointed `code-architect`, `code-reviewer`, and `brms-expert` at the merged
  files and the relocated references — Sharon's Stage 1 now cites
  `scaffolding/references/new_folder.md`, her Stage 2 lists each domain's reference entry
  point, and the environment contract reaches both agents through the brief's
  `ENVIRONMENT:` field.
- references: updated the stale `knowledge/visualization/execution_template.md` pointers in
  `project-rules.md` §5 and `coding-rules.md`'s posterior-plotting rule to
  `knowledge/visualization/references/routing.md`; same fix in both plot-type
  `instructions.md` headers and `preprocessing/references/` cross-references.
- positive-prompting: rewrote the merged content as stated actions — preprocessing's
  "✅ DO / ❌ DON'T" pair becomes one rules list, the prior/exclusion prohibitions become
  "priors come from the user, in their own numbers", and the visualization "what this does
  NOT cover" section states what the caller supplies.
- architecture (major, supersedes the entry below): reversed the "each domain is its own
  mini-orchestrator" design after trying it. `bayesian-regression`, `preprocessing`,
  `visualization`, and `scaffolding` are no longer skills at all — moved from `skills/`
  to a new top-level `knowledge/` folder, and each one's `SKILL.md` is deleted (their
  unique content — Assumptions sections, folder-structure tables, routing tables — folded
  into that domain's `execution_template.md`, which is the only file that used to be
  skill-specific and still needs it). `knowledge/<domain>/interview.md` and
  `execution_template.md` keep their names and shape, but they are now read-only
  reference material — plain files with no frontmatter, not discoverable or invocable as
  skills. `malka/SKILL.md` goes back to running the interview and dispatching
  `code-architect`/`code-reviewer` herself (as it did before the mini-orchestrator
  experiment), reading whichever `knowledge/<domain>/` folder(s) the request touches
  instead of delegating to a domain skill. `skills/` now contains only `malka` and
  `code-walkthrough`. Updated every cross-reference across `agents/`, `references/`, the
  moved knowledge files, and both READMEs.
- architecture (major): decentralized the interview and dispatch from `malka` into each
  domain skill. Every domain skill (`bayesian-regression`, `preprocessing`,
  `visualization`, `scaffolding`) is now a self-contained mini-orchestrator with its own
  `interview.md` (the domain-specific questions and approval gate, if any) and its own
  `execution_template.md` (the blueprint it fills out and hands to `code-architect`/
  `code-reviewer` directly). `malka/SKILL.md` is rewritten as a pure router: it identifies
  which domain(s) a request touches and calls those skills, in dependency order for
  multi-domain requests — it no longer runs any domain's interview or dispatches the
  Staff Agents itself. `malka/references/dispatch-brief.md` is deleted; its per-domain
  brief templates now live in each domain's own `execution_template.md`.
- architecture (major): renamed three domain skill folders to match the plugin's actual
  vocabulary and drop redundant prefixes — `data-preprocessing` → `preprocessing`,
  `plotting` → `visualization`, `project-scaffolding` → `scaffolding`. `bayesian-regression`
  and `malka` keep their names. Updated every cross-reference across `agents/`,
  `references/`, the renamed skills' own templates, and both READMEs.
- bayesian-regression: `workflow/VALIDATION.md` → `interview.md`; `workflow/EXPERT-
  INSTRUCTIONS.md` → `execution_template.md`; `workflow/README.md` deleted (its map was
  redundant once the two files above are named for what they are).
- preprocessing: `workflow/ARCHITECT-INSTRUCTIONS.md` → `execution_template.md` (build
  content only — Phase 1/2 exploration and plan-approval moved out); `workflow/
  EXPLORATION.md` → `references/exploration.md` (Step 6's user-facing questions moved to
  the new `interview.md`); `workflow/REVIEW-INSTRUCTIONS.md` → `references/review-
  checklist.md`. New `interview.md` holds raw-structure agreement, exploration-driven
  clarifying questions, the user-owns-exclusion-criteria rule, and the preprocessing-plan
  approval gate — all previously scattered across `SKILL.md`, `EXPLORATION.md`, and
  `ARCHITECT-INSTRUCTIONS.md`.
- visualization: `standards/` and `plot-types/` both moved under `references/` (so the
  skill matches the `interview.md` + `execution_template.md` + `references/` shape used
  lab-wide); internal cross-references between them are unchanged since both moved down
  one level together. New `interview.md` holds the (non-blocking) plot-type/composite/
  palette clarifying pass; `execution_template.md` now holds the routing table,
  procedure, and mandatory rules that used to be all of `SKILL.md`.
- scaffolding: `workflow/REVIEWER.md` → `references/review-checklist.md`. New
  `interview.md` holds the folder-type/new-clone-repair/model-name/data-source questions
  that used to be step 2 of the Gated Workflow; `execution_template.md` holds the Direct
  Scaffolding and Gated Workflow mechanics (Plan/Execute/reviewer-gate steps).
- architecture: the interview now lives in exactly one file. `malka/references/interview.md`
  and the four domain `interview.md` files (`bayesian-regression`, `data-preprocessing`,
  `plotting`, `project-scaffolding`) are deleted, their content folded into
  `malka/SKILL.md`. Those four had a single reader — Malka — no domain `SKILL.md` ever
  referenced its own, and all four still named `lab-analysis-orchestrator`, an
  orchestrator this plugin removed. They also summarized gate files that already existed
  (`workflow/VALIDATION.md`, `workflow/EXPLORATION.md`, the Gated Workflow), making them a
  second copy of content with a home.
- malka: merged the old "identify the domain" and "run the domain's interview" phases into
  a single Step 1, and split each domain's questions into two table columns — **Collect up
  front** (facts, batched into one message across every domain the request touches) and
  **Propose and confirm before dispatch** (proposals that require looking at data or
  drafting a formula first, so they pace themselves one domain at a time). Previously all
  ~14 items sat under one "BLOCKING — none of these may be skipped" heading, which turned
  a four-domain request into a wall of questions. Replaces a table column that read
  `interview.md` in all four rows. Phases renumbered 1–4 → Steps 1–3.
- malka: added a positive completion test for the interview — "done when you can fill every
  applicable field of `references/dispatch-brief.md` with the user's own words and values"
  — replacing the three "signs the interview isn't done yet" lists. Also added the
  dependency order for multi-domain requests (scaffolding → preprocessing → model → plots,
  one stage per review cycle), which was previously unstated.
- malka: fixed typos and corrected the skill's `description` (frontmatter) to name the three
  domains it actually orchestrates — Bayesian regression, visualization and plotting, and
  preprocessing and data housekeeping — replacing a stray "Frequentist regression" that
  matches no domain skill.
- bayesian-regression: `references/01_sampling_and_priors.md` referred to prior approval
  happening "in Phase 1" — the orchestrator's numbering, now Step 1. Reworded to "during
  the interview" so it no longer tracks Malka's section numbers.
- architecture: moved `references/coding-rules.md` to `references/general/coding-rules.md`
  (matching the `general/` convention used elsewhere in the repo); updated all
  cross-references (`code-architect.md`, `code-reviewer.md`, `project-scaffolding/SKILL.md`,
  `project-scaffolding/workflow/REVIEWER.md`).
- architecture: removed the `SessionStart` hook and `hooks/inject-context.js` — lab rules are no longer injected into every session; they're read on demand by `code-architect`/`code-reviewer` from `references/` only when a lab task is in progress.
- architecture: removed `context/orchestrator.md` (a duplicate of `agents/malka-orchestrator.md` with a conflicting third persona) — Malka's role now has a single source of truth.
- architecture: renamed `context/` to `references/`; removed `path-enforcement.md` and `lab-linter.md` as separate files (they were prose, not real hooks, and duplicated `project-rules.md`/`coding-rules.md`) — their non-duplicate content (path-setup pattern, `shQuote()`/external-call rule) was folded into `coding-rules.md`.
- bayesian-regression: added `references/02_diagnostics.md` — mandatory `diagnostic.pdf` script (ESS/Rhat summary table, trankplot, pairs plot as separate pages); wired into SKILL.md, EXPERT-INSTRUCTIONS.md, README.md, and the brms-expert agent; also fixed stale reference paths left over from before the numbered `references/` convention.
- docs: added a plugin `README.md` (skills table, agents list, how-to-invoke section); root `README.md` no longer claims a SessionStart hook, `context/`, or `hooks/` — all removed.
- data-preprocessing: encoded the fixed folder structure (`preprocessing/code|output|main.R`, `data/collected|raw|processed`) and the pipeline deliverables — raw restructuring, data-quality PDF (aborted trials + per-subject RT table), user-defined exclusions to processed, and a manuscript-ready "Data treatment" paragraph (.md) with computed numbers.
- data-preprocessing: removed concrete exclusion values (RT cutoffs, thresholds) in favor of placeholders; added hard rule that exclusion criteria must come from the user, never chosen by the AI (enforced in SKILL.md, template, and review checklist).
- data-preprocessing: added `assets/template_main.R` — preprocessing orchestrator template with the four pipeline steps and fixed path setup.
- architecture: removed `commands/` — the plugin ships no slash commands. This surfaced a deeper problem: `malka-orchestrator` ran as a subagent, but her mandate required interviewing the user and waiting on approval gates, which a subagent cannot do (no channel to the user). Converted Malka from an agent to a skill (`skills/malka/`) so her interview and gate-relaying run in the main thread, where the user actually is; `agents/malka-orchestrator.md` is deleted. Malka is now reached via `/shaharlab-behavioral-data-analysis:malka` or natural-language auto-routing from the skill's `description` — matching how every other skill in this plugin is invoked.
- architecture: the skill/executor/reviewer-checklist mapping previously lived three times (Sharon's routing table, Tomer's checklist table, and implicitly in each skill's `description`) and had already drifted — Sharon's table omitted `project-scaffolding`. It now lives once, in `skills/malka/SKILL.md`'s routing table; `code-architect.md` and `code-reviewer.md` now read which skill/checklist applies from their dispatch brief instead of maintaining their own copy.
- architecture: promoted `skills/bayesian-regression/agents/brms-expert.md` to `agents/brms-expert.md` — subagent-type files outside the plugin's top-level `agents/` folder are not discovered, so this agent was never actually invocable.
- architecture: fixed four mentions of a `/plot-posterior` skill — in `references/project-rules.md` §5, `references/coding-rules.md`, and the `project-scaffolding` templates (`template_main.R`, `template_summary.md`) — no such skill exists; all now point at `plotting`'s own posterior routing.
- architecture: reconciled a folder-structure conflict — `project-scaffolding/references/folder_structure.md` (the declared single source of truth) was missing `preprocessing/output/`, which `data-preprocessing/SKILL.md` already required for the data-quality PDF and manuscript paragraph. Added it to `folder_structure.md`.
- code-walkthrough: added an explicit note that this skill must never run as a subagent — every step is a user-facing STOP/wait gate.
- plotting: restructured to one-fact-one-home. The routing table existed six times (SKILL.md STEP 1, STEP 3, Quick Reference, Example Workflow, and PLOT_TYPES.md's two tables) and now exists once, in `SKILL.md`, with the per-type color/tagging matrix folded into it. `SKILL.md` is rewritten as assumptions → routing → procedure → mandatory rules, where each mandatory rule cites the file that defines it instead of restating its values.
- plotting: deleted `CONFIG.md` and `references/PLOT_TYPES.md` — every rule in them was already defined elsewhere. The one exception, "assembly is patchwork only, never gridExtra or cowplot," moved to `references/PANEL_TAGGING_STANDARD.md`, which now owns both multi-panel assembly and tagging.
- plotting: removed skill frontmatter (`name`, `description`, `user-invocable: true`, `allowed-tools`, `argument-hint`) from `references/plot-posterior/instructions.md` and `references/plot-scatter/instructions.md`. These are reference files inside a skill, not separately invocable skills — the stray `user-invocable: true` is what made a `/plot-posterior` skill look real and seeded the phantom references fixed above. Their duplicated "Mandatory Reading" preambles (a seventh copy of the routing) were replaced with a pointer back to `SKILL.md`.
- plotting: fixed three more phantom-skill references to a non-existent "color skill" inside `plot-posterior/instructions.md`, and made all cross-references to `COLOR_STANDARD.md` from the nested plot-type folders resolvable (`../COLOR_STANDARD.md`).
- plotting: replaced the single `references/` folder with two named by what they hold — `standards/` for rules that apply to every plot (color, export, panel tagging) and `plot-types/` for the per-type recipes (`plot-posterior/`, `plot-scatter/`, each with its own `instructions.md` + runnable `example.R`). Finding a rule no longer requires knowing which kind of file it is. All 21 cross-references across 7 files were updated and every cited path verified to resolve.
- plotting: dropped the "Future Plot Types" roadmap from the deleted `PLOT_TYPES.md` (heatmaps, forest plots, time series, PPCs — none implemented); `SKILL.md` now documents how to add a plot type instead of listing unbuilt ones.

## [1.0.0] — 2026-07-15
- Initial plugin release: skills (bayesian-regression, code-walkthrough, data-preprocessing, plotting, project-scaffolding), agents (malka-orchestrator, code-architect, code-reviewer), lab rules injected via SessionStart hook.
