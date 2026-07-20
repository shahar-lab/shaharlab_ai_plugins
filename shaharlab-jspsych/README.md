# shaharlab-jspsych

Online experiment development in jsPsych for the Shahar Lab (Tel Aviv
University). Bundles the lab's jsPsych coding style, window/attention
monitoring, the experiment-planning blueprint workflow, and manuscript
method-section excerpts.

> Installation is documented once at the [repo root README](../README.md).
> This file lists what the plugin provides.

## Skills

Invoke with `/shaharlab-jspsych:<skill>`, or just describe the task and Claude
routes to the right one.

| Skill | Use it when you… |
|---|---|
| `experiment-plan` | create/maintain the experiment plan — `EXPERIMENT_BLUEPRINT.md` (the researcher–AI contract) plus the agent-facing `ai_artifacts/plan/` folder. Run right after the planning interview and whenever the design changes. |
| `jspsych-coding-style` | write, modify, review, or debug JavaScript for a jsPsych experiment (plain-script architecture: no modules, no bundler, no build step). |
| `jspsych-window-monitoring` | build an experiment that records tab switches / window blur / fullscreen exits, or `/jspsych-window-monitoring <path>` to report on exported data. |
| `manuscript-excerpt` | the experiment is finalized and you want a publication-ready method paragraph. |

## Agents

Available as subagent types once the plugin is loaded:

- **`tzadok`** — jsPsych workflow coordinator.
- **Planning team** — `planning-interviewer-galit`, `planning-architect-miri`, `planning-reviewer-devorah`.
- **Build team** — `jspsych-architect-dan`, `jspsych-reviewer-ezra`.
- **`manuscript-editor-baruch`** — drives `manuscript-excerpt`.

## What changed

See [`CHANGELOG.md`](CHANGELOG.md). The current version is in
[`.claude-plugin/plugin.json`](.claude-plugin/plugin.json).
