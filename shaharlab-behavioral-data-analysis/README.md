# shaharlab-behavioral-data-analysis

Behavioral data analysis in R for the Shahar Lab (Tel Aviv University).
Bundles the lab's brms Bayesian-regression workflow, data preprocessing,
visualization standards, project scaffolding, and R code walkthroughs — plus Malka,
the orchestrator skill that interviews you and directs the subagents that build and check the work.

> Installation is documented once at the [repo root README](../README.md).
> This file lists what the plugin provides.

## Skills

There are only two real skills in this plugin — `malka` and `code-walkthrough`. Invoke
with `/shaharlab-behavioral-data-analysis:<skill>`, or just describe the task and Claude
routes to the right one.

| Skill | Use it when you… |
|---|---|
| `malka` | have any non-trivial lab analysis task. Interviews you herself (from her own `references/interview.md`), clears any approval gate, then builds a card from `references/writer-card.md` and dispatches the code-writer on it. The reliable entry point. |
| `code-walkthrough` | want R code explained statement by statement to learn or verify it — always runs in the main thread, never as a subagent. |

## Knowledge

Malka's index lives in `skills/malka/SKILL.md` plus its reference files, each answering one
question: `references/interview.md` (what to ask per domain and which gate blocks),
`references/user-request-summary.md` (the plain-English confirmation card),
`references/planning.md` (the runs and jobs a request breaks into, and where the approved
specification is kept), `references/knowledge-index.md` (the file-by-file map of
`coding-knowledge/`, which file goes on the card, and worked routes for the common jobs),
`references/writer-card.md` and `references/reviewer-card.md` (the two card formats),
`references/dispatch.md` (the spawn, the return, and what each `BLOCKED` return means),
`references/folder-summary.md` (the folder's own notebook), and `references/return-trip.md`
(what happens when you come back after running the code).

How the subagent *behaves* — the reads it always takes, how it reports, what it returns — lives in
its own agent file rather than in the card, so a card carries only what varies from job to job.

`coding-knowledge/` is not a skills folder — nothing under it has a `SKILL.md`, triggers on its
own, or runs independently. Each subfolder is the reference material for one domain, which
Malka points the subagent at through the card:

| Domain | Malka reads it for… |
|---|---|
| `coding-knowledge/00-constitution/` | the project rules and R coding rules every build reads, whatever the domain |
| `coding-knowledge/01-folder-specific-rules/` | the structure and file naming of the folder type the work lands in — `preprocessing/`, `analysis/`, `models/`, `simulations/` — with the templates that build it |
| `coding-knowledge/05-bayesian-regression/` | fitting/checking a Bayesian/brms regression (sampling, priors, diagnostics, reporting) |
| `coding-knowledge/03-preprocessing/` | cleaning, reshaping, excluding, examining, or reporting behavioral data — one `how-to-` file per script kind (`converting_`, `examining_`, `summary_`), building `data/raw` + `data/processed`, the Markdown examination and exclusion reports, and a manuscript-ready exclusions paragraph |
| `coding-knowledge/04-visualization/` | creating or revising any lab figure — color, panel-tagging, plot-type, and export standards |
| `coding-knowledge/02-scaffolding/` | starting a new analysis/simulation/model folder under the "one model, one folder" topology (or smart-cloning an existing one) |

Most folders have the same shape: `references/` (the standards and cheatsheets the subagent
reads while it works) and, where a domain needs boilerplate, `assets/`.
`01-folder-specific-rules/` is the exception — one subfolder per folder type, each holding a
`rules.md` and the templates that build that folder.

## Agents

Three subagent types, available once the plugin is loaded — dispatched by `malka`, not
invoked directly:

- **`data-explorer`** — profiles `data/collected/` at the start of the interview by running R over it, and returns the distribution behind each exclusion question so you set your cutoffs against your own participants. The only agent here with a shell, and it writes nothing.
- **`code-writer`** — prepares the folder/environment, writes the code for whichever domain Malka names in the Writer Card, then checks its own work against the same rules and the approved specification before returning. One spawn per job.
- **`code-reviewer`** — reads the finished files against the approved specification and reports what the code actually sets, plus any value that contradicts the specification, any product that never reached disk, and any threshold the Writer chose that was the user's to set. Read-only, one spawn per run, and it routes no craft knowledge — the library the Writer reads stays out of its context, which is what keeps it cheap enough to run every time.

There is no orchestrator agent — the orchestrator is the `malka` skill itself, so it runs in the main conversation thread where the user actually is (a subagent has no one to interview or wait on for approval).

The Reviewer checks that the code says what was approved; whether the craft is right stays with the Writer, which read the standards. Nothing here runs the code, so a job with real stakes is still worth reading before it ships.

## How to invoke

The plugin ships no slash commands of its own — skills and agents are the only
entry points.

- **`/shaharlab-behavioral-data-analysis:malka`** — the reliable way in for any build task. Explicitly dispatches Malka.
- **Plain language** — describe the task ("clean my behavioral data," "fit a brms model on choice ~ reward"). Claude routes to Malka based on her `description`. This depends on the model recognizing the match, so it isn't guaranteed the way naming the skill is.
- **`code-walkthrough` directly** — `/shaharlab-behavioral-data-analysis:code-walkthrough` to go straight to it without Malka.

Lab rules (folder topology, R style) are **not** injected automatically into every session — the code-writer reads them on demand from `coding-knowledge/00-constitution/`, only when a lab task is actually in progress. This keeps unrelated sessions free of lab-specific context.

## Terms

See [`TERMS.md`](TERMS.md) for the vocabulary of the Malka workflow — Summary Card, Writer Card,
job, dispatch, fit, `ASSUMED`, `BLOCKED`, and the rest, plus the capitalization convention that
separates a compound term's name from an ordinary word. It is a maintainer's index, read before
naming a concept in a runtime file so one concept keeps one word; nothing reads it at runtime.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
