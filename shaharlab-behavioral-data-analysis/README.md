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

- **`malka-orchestrator`** — coordinates the analysis workflow.
- **`code-architect`** — designs the analysis/code plan.
- **`code-reviewer`** — reviews R code against lab standards.

## Session-start behavior

This plugin uses a **`SessionStart` hook** (`hooks/inject-context.js`,
**Node.js required**) that injects the lab's project rules, coding rules, and
path-enforcement rules into every session automatically. No action needed — but
Node must be on your `PATH`.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
