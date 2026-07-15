# Shahar Lab AI Plugins

Version-controlled Claude Code plugins for the Shahar Lab (Tel Aviv University).

## Plugins

| Plugin | What it gives you |
|---|---|
| `shaharlab-behavioral-data-analysis` | Behavioral data analysis in R: brms Bayesian regression, data preprocessing, lab plotting standards, "one model, one folder" project scaffolding, R code walkthroughs, and the Malka / Sharon / Tomer orchestrator–architect–reviewer workflow. Lab rules are injected automatically at session start. |
| `shaharlab-jspsych` | Online experiment development: jsPsych coding style, window/attention monitoring, experiment planning (blueprint workflow with Tzadok / Galit / Miri / Devorah / Dan / Ezra), and manuscript method-section excerpts (Baruch). |

## Usage

Clone this repo once, then start Claude Code **in your own project** with the plugin(s) you need:

```bash
git clone <this-repo-url>

cd path/to/your/project
claude --plugin-dir path/to/shaharlab_ai_plugins/shaharlab-behavioral-data-analysis
```

Load both plugins by passing the flag twice:

```bash
claude --plugin-dir path/to/shaharlab_ai_plugins/shaharlab-behavioral-data-analysis \
       --plugin-dir path/to/shaharlab_ai_plugins/shaharlab-jspsych
```

Skills are namespaced by plugin, e.g. `/shaharlab-behavioral-data-analysis:plotting` or `/shaharlab-jspsych:experiment-plan`. Agents (Malka, Sharon, Tomer, Tzadok, Dan, …) become available as subagent types.

`git pull` to receive updates — plugins are loaded fresh from disk each session.

## Notes

- Tool permissions are **not** shipped by the plugins; manage them in your own project's `.claude/settings.json` (or via `/permissions`).
- The behavioral-data-analysis plugin uses a `SessionStart` hook (Node.js required) to inject the lab's project rules, coding rules, and path-enforcement rules into every session.

## Layout

```
shaharlab-behavioral-data-analysis/
├── .claude-plugin/plugin.json
├── skills/        bayesian-regression, code-walkthrough, data-preprocessing, plotting, project-scaffolding
├── agents/        malka-orchestrator, code-architect, code-reviewer
├── context/       orchestrator, project-rules, coding-rules, path-enforcement, lab-linter
└── hooks/         hooks.json + inject-context.js (SessionStart context injection)

shaharlab-jspsych/
├── .claude-plugin/plugin.json
├── skills/        jspsych-coding-style, jspsych-window-monitoring, experiment-plan, manuscript-excerpt
└── agents/        tzadok, planning-interviewer-galit, planning-architect-miri, planning-reviewer-devorah,
                   jspsych-architect-dan, jspsych-reviewer-ezra, manuscript-editor-baruch
```
