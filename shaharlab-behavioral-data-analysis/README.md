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
| `malka` | have any non-trivial lab analysis task — interviews you, clears the governing skill's own approval gates, then dispatches the architect and reviewer subagents. The reliable entry point. |
| `bayesian-regression` | fit, check, or interpret a Bayesian/brms regression (sampling, priors, diagnostics, reporting). |
| `data-preprocessing` | clean, reshape, exclude, score, or validate behavioral data — builds `data/raw` + `data/processed`, a data-quality PDF, and a manuscript-ready exclusions paragraph. |
| `plotting` | create or revise any lab figure — routes to color, panel-tagging, plot-type, and export standards. |
| `project-scaffolding` | start a new analysis/simulation/model folder under the "one model, one folder" topology (or smart-clone an existing one). |
| `code-walkthrough` | want R code explained statement by statement to learn or verify it — always runs in the main thread, never as a subagent. |

## Agents

Available as subagent types once the plugin is loaded — dispatched by the `malka` skill, not invoked directly:

- **`code-architect`** ("Sharon") — scaffolds the folder/environment, then writes the code for whichever domain skill Malka names in the brief.
- **`brms-expert`** — writes brms analysis code once Malka has cleared the formula/priors/plan gate; dispatched by `code-architect` during `bayesian-regression` builds.
- **`code-reviewer`** ("Tomer") — reviews the result against the checklist Malka names in the brief.

There is no orchestrator agent — the orchestrator is the `malka` skill itself, so it runs in the main conversation thread where the user actually is (subagents have no one to interview or wait on for approval).

## How to invoke

The plugin ships no slash commands of its own — skills and agents are the only
entry points.

- **`/shaharlab-behavioral-data-analysis:malka`** — the reliable way in for any build task. Explicitly dispatches Malka.
- **Plain language** — describe the task ("clean my behavioral data," "fit a brms model on choice ~ reward"). Claude routes to Malka based on her `description`. This depends on the model recognizing the match, so it isn't guaranteed the way naming the skill is.
- **Name another skill directly** — `/shaharlab-behavioral-data-analysis:<skill>` to go straight to one standard (e.g. re-reading the plotting rules) without the orchestrator.

Lab rules (folder topology, R style) are **not** injected automatically into every session — they're read on demand by the architect and reviewer agents from `references/`, only when a lab task is actually in progress. This keeps unrelated sessions free of lab-specific context.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
