# shaharlab-behavioral-data-analysis

Behavioral data analysis in R for the Shahar Lab (Tel Aviv University).
Bundles the lab's brms Bayesian-regression workflow, data preprocessing,
plotting standards, project scaffolding, and R code walkthroughs — plus the
Malka/Sharon/Tomer orchestrator–architect–reviewer team.

> Installation is documented once at the [repo root README](../README.md).
> This file lists what the plugin provides.

## Skills

Invoke with `/shaharlab-behavioral-data-analysis:<skill>`, or just describe the
task and Claude routes to the right one.

| Skill | Use it when you… |
|---|---|
| `bayesian-regression` | fit, check, or interpret a Bayesian/brms regression (sampling, priors, diagnostics, reporting). |
| `data-preprocessing` | clean, reshape, exclude, score, or validate behavioral data — builds `data/raw` + `data/processed`, a data-quality PDF, and a manuscript-ready exclusions paragraph. |
| `plotting` | create or revise any lab figure — routes to color, panel-tagging, plot-type, and export standards. |
| `project-scaffolding` | start a new analysis/simulation/model folder under the "one model, one folder" topology (or smart-clone an existing one). |
| `code-walkthrough` | want R code explained statement by statement to learn or verify it. |

## Agents

Available as subagent types once the plugin is loaded:

- **`malka-orchestrator`** — coordinates the analysis workflow: interviews you, briefs the architect, relays approval gates, dispatches the reviewer.
- **`code-architect`** — designs the analysis/code plan, scaffolds the folder, writes the code.
- **`code-reviewer`** — reviews the result against lab standards.

You never need to invoke `code-architect` or `code-reviewer` directly — Malka dispatches them for you.

## How to invoke

The plugin ships no slash commands of its own — skills and agents are the only
entry points.

- **Plain language** — describe the task ("clean my behavioral data," "fit a brms model on choice ~ reward"). Claude routes to Malka based on her `description`. This is the normal path, but it depends on the model recognizing the match.
- **Name the agent** — say "use `malka-orchestrator` for this" when you want the pipeline for certain, especially before anything gets written to disk.
- **Name a skill** — `/shaharlab-behavioral-data-analysis:<skill>` to go straight to one standard (e.g. re-reading the plotting rules) without the orchestrator.

Lab rules (folder topology, R style) are **not** injected automatically into every session — they're read on demand by the architect and reviewer agents from `references/`, only when a lab task is actually in progress. This keeps unrelated sessions free of lab-specific context.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
