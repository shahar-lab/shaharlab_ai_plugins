# shaharlab-jspsych

Online experiment development in jsPsych for the Shahar Lab (Tel Aviv
University). Bundles the lab's experiment orchestrator (planning interview,
blueprint contract, and dispatch), the jsPsych coding style (including
Likert scales and window/attention monitoring), and manuscript
method-section excerpts.

> Installation is documented once at the [repo root README](../README.md).
> This file lists what the plugin provides.

## Skills

Invoke with `/shaharlab-jspsych:<skill>`, or just describe the task and Claude
routes to the right one. Start any non-trivial request at
`lab-online-exp-orchestrator` — it interviews you, maintains the experiment
blueprint, and dispatches the other two skills to `code-architect`.

| Skill | Subcomponents | Use it when you… |
|---|---|---|
| `lab-online-exp-orchestrator` | `reference/blueprint-format.md`, `reference/example_blueprint.md`, `reference/example_specification.md` | want to plan a new experiment, update its design, or aren't sure which skill applies — this is the entry point. Interviews you, owns `ai_artifacts/plan/EXPERIMENT_BLUEPRINT.md` + `artifacts/` (the researcher–AI contract), gates approval, and dispatches `code-architect`/`code-reviewer`. |
| `jspsych-coding-style` | `references/general/` (index-html, local-dev-js, config-js, setup-js, coding-rules), `references/components/` (instructions, timeline-blocks, likert), `references/validity_checks/` (window-monitoring), `interview.md` | write, modify, review, or debug JavaScript for a jsPsych experiment (plain-script architecture: no modules, no bundler, no build step) — including Likert scales and window/attention monitoring (recording tab switches / window blur / fullscreen exits, or reporting on exported session data). |
| `manuscript-excerpt` | `interview.md` | the experiment is finalized and you want a publication-ready method paragraph. |

## Agents

Available as subagent types once the plugin is loaded — exactly two, shared
across every stage the orchestrator dispatches:

- **`code-architect`** — writes every work product: the blueprint/spec/changelog, the
  experiment codebase, and the manuscript excerpt.
- **`code-reviewer`** — reviews `code-architect`'s output against the stage's own
  checklist. Read-only.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
