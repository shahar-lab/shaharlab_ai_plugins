# Changelog — shaharlab-behavioral-data-analysis

## [Unreleased]

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
