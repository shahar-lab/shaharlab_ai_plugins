# Changelog — shaharlab-behavioral-data-analysis

## [Unreleased]

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
