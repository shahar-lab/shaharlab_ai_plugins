# Shahar Lab AI Plugins

Version-controlled Claude Code plugins for the Shahar Lab (Tel Aviv University).

## Plugins

| Plugin | What it gives you |
|---|---|
| [`shaharlab-behavioral-data-analysis`](shaharlab-behavioral-data-analysis/) | Behavioral data analysis in R: brms Bayesian regression, data preprocessing, lab plotting standards, "one model, one folder" project scaffolding, R code walkthroughs, and the Malka / Sharon / Tomer orchestrator–architect–reviewer workflow. Lab rules are read on demand by the agents, not injected into every session. |
| [`shaharlab-jspsych`](shaharlab-jspsych/) | Online experiment development: jsPsych coding style, window/attention monitoring, experiment planning (blueprint workflow with Tzadok / Galit / Miri / Devorah / Dan / Ezra), and manuscript method-section excerpts (Baruch). |

Each plugin's own README lists its skills and agents.

## Install (recommended): marketplace

Do this **once**, from inside any Claude Code session. It registers this repo
as a plugin marketplace and installs the plugin(s) you want — no file paths to
type.

```
/plugin marketplace add shahar-lab/shaharlab_ai_plugins
/plugin install shaharlab-behavioral-data-analysis@shaharlab
/plugin install shaharlab-jspsych@shaharlab
```

Then just use the skills — e.g. `/shaharlab-behavioral-data-analysis:malka`
or `/shaharlab-jspsych:experiment-plan`. Agents (Sharon, Tomer, Tzadok, Dan, …)
become available as subagent types, dispatched by the skills rather than
invoked directly.

To **update** later:

```
/plugin marketplace update shaharlab
```

## Install (alternative): clone + `--plugin-dir`

Prefer this if you want the files local (offline, or to edit them). Clone once,
then start Claude Code **in your own project** pointing at the plugin folder(s):

```bash
git clone https://github.com/shahar-lab/shaharlab_ai_plugins.git

cd path/to/your/project
claude --plugin-dir path/to/shaharlab_ai_plugins/shaharlab-behavioral-data-analysis
```

Load both by passing the flag twice:

```bash
claude --plugin-dir path/to/shaharlab_ai_plugins/shaharlab-behavioral-data-analysis \
       --plugin-dir path/to/shaharlab_ai_plugins/shaharlab-jspsych
```

`git pull` to receive updates — plugins are loaded fresh from disk each session.

## Versioning & updates

- Each plugin is versioned **independently** in its
  `.claude-plugin/plugin.json`.
- What changed and when lives in each plugin's `CHANGELOG.md`
  ([data-analysis](shaharlab-behavioral-data-analysis/CHANGELOG.md) ·
  [jspsych](shaharlab-jspsych/CHANGELOG.md)). The `[Unreleased]` section is the
  running log of changes not yet cut into a numbered version.
- Releases are tagged `<plugin-name>-vX.Y.Z`.
- Contributing / release process: see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## Notes

- Tool permissions are **not** shipped by the plugins; manage them in your own
  project's `.claude/settings.json` (or via `/permissions`).
- Neither plugin ships hooks or slash commands — skills and agents are the only
  entry points, so no Node.js is required and unrelated sessions stay free of
  lab-specific context. The behavioral-data-analysis agents read the lab's
  project and coding rules from `references/` on demand, only when a lab task is
  actually in progress.

## Layout

```
.claude-plugin/marketplace.json    lists both plugins (enables /plugin install)

shaharlab-behavioral-data-analysis/
├── .claude-plugin/plugin.json
├── README.md · CHANGELOG.md
├── skills/    malka, bayesian-regression, code-walkthrough, data-preprocessing, plotting, project-scaffolding
├── agents/    code-architect, brms-expert, code-reviewer
└── references/  project-rules, coding-rules (read on demand by the agents)

shaharlab-jspsych/
├── .claude-plugin/plugin.json
├── README.md · CHANGELOG.md
├── skills/    jspsych-coding-style, jspsych-window-monitoring, experiment-plan, manuscript-excerpt
└── agents/    tzadok, planning-interviewer-galit, planning-architect-miri, planning-reviewer-devorah,
               jspsych-architect-dan, jspsych-reviewer-ezra, manuscript-editor-baruch
```

Licensed under [MIT](LICENSE).
