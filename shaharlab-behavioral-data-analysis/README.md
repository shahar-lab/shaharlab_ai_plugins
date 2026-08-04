# shaharlab-behavioral-data-analysis

Behavioral data analysis in R for the Shahar Lab (Tel Aviv University).
Bundles the lab's brms Bayesian-regression workflow, data preprocessing,
visualization standards, project scaffolding, and R code walkthroughs — plus Malka,
the orchestrator skill that directs a code-writer and a code-reviewer subagent.

> Installation is documented once at the [repo root README](../README.md).
> This file lists what the plugin provides.

## Skills

There are only two real skills in this plugin — `malka` and `code-walkthrough`. Invoke
with `/shaharlab-behavioral-data-analysis:<skill>`, or just describe the task and Claude
routes to the right one.

| Skill | Use it when you… |
|---|---|
| `malka` | have any non-trivial lab analysis task. Interviews you herself (from her own `references/interview.md`), clears any approval gate, then dispatches the code-writer and code-reviewer using `references/dispatch.md`. The reliable entry point. |
| `code-walkthrough` | want R code explained statement by statement to learn or verify it — always runs in the main thread, never as a subagent. |

## Knowledge

Malka's index lives in `skills/malka/SKILL.md` plus five reference files, each answering one
question: `references/interview.md` (what to ask per domain and which gate blocks),
`references/user-request-summary.md` (the plain-English confirmation card),
`references/planning.md` (how many dispatches a job is, and which folder each writes into),
`references/knowledge-index.md` (the file-by-file map of `coding-knowledge/`, which file goes on
whose card, and worked routes for the common jobs), and `references/dispatch.md` (the card slots,
then how the build/review rounds run).

How each subagent *behaves* — the reads it always takes, how it reports, what it returns — lives in
its own agent file rather than in the card, so a card carries only what varies from job to job.

`coding-knowledge/` is not a skills folder — nothing under it has a `SKILL.md`, triggers on its
own, or runs independently. Each subfolder is the reference material for one domain, which
Malka points the subagents at through the card:

| Domain | Malka reads it for… |
|---|---|
| `coding-knowledge/00-constitution/` | the project rules and R coding rules every build reads, whatever the domain |
| `coding-knowledge/01-folder-specific-rules/` | the structure and file naming of the folder type the work lands in — `preprocessing/`, `analysis/`, `models/`, `simulations/` — with the templates that build it |
| `coding-knowledge/05-bayesian-regression/` | fitting/checking a Bayesian/brms regression (sampling, priors, diagnostics, reporting) |
| `coding-knowledge/03-preprocessing/` | cleaning, reshaping, excluding, examining, or reporting behavioral data — one `how-to-` file per script kind (`converting_`, `examining_`, `summary_`), building `data/raw` + `data/processed`, the Markdown examination and exclusion reports, and a manuscript-ready exclusions paragraph |
| `coding-knowledge/04-visualization/` | creating or revising any lab figure — color, panel-tagging, plot-type, and export standards |
| `coding-knowledge/02-scaffolding/` | starting a new analysis/simulation/model folder under the "one model, one folder" topology (or smart-cloning an existing one) |

Most folders have the same shape: `references/` (the standards, checklists, and cheatsheets
the subagents read while they work) and, where a domain needs boilerplate, `assets/`.
`01-folder-specific-rules/` is the exception — one subfolder per folder type, each holding a
`rules.md` and the templates that build that folder.

## Agents

Two subagent types, available once the plugin is loaded — dispatched by `malka`, not
invoked directly:

- **`code-writer`** — prepares the folder/environment, then writes the code for whichever domain Malka names in the execution card.
- **`code-reviewer`** — reviews the result against the checklist Malka names in the card, annotates findings in place, and returns PASS or FAIL.

There is no orchestrator agent — the orchestrator is the `malka` skill itself, so it runs in the main conversation thread where the user actually is (subagents have no one to interview or wait on for approval).

## How to invoke

The plugin ships no slash commands of its own — skills and agents are the only
entry points.

- **`/shaharlab-behavioral-data-analysis:malka`** — the reliable way in for any build task. Explicitly dispatches Malka.
- **Plain language** — describe the task ("clean my behavioral data," "fit a brms model on choice ~ reward"). Claude routes to Malka based on her `description`. This depends on the model recognizing the match, so it isn't guaranteed the way naming the skill is.
- **`code-walkthrough` directly** — `/shaharlab-behavioral-data-analysis:code-walkthrough` to go straight to it without Malka.

Lab rules (folder topology, R style) are **not** injected automatically into every session — the code-writer and code-reviewer read them on demand from `coding-knowledge/00-constitution/`, only when a lab task is actually in progress. This keeps unrelated sessions free of lab-specific context.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
