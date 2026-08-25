# Shahar Lab AI Plugins

Version-controlled Claude Code plugins for the Shahar Lab (Tel Aviv University).

## Plugins

| Plugin | What it gives you |
|---|---|
| [`shaharlab-behavioral-data-analysis`](shaharlab-behavioral-data-analysis/) | Behavioral data analysis in R: brms Bayesian regression, data preprocessing, lab visualization standards, "one model, one folder" project scaffolding, R code walkthroughs, and the Malka orchestrator workflow that directs `code-writer` over an indexed `coding-knowledge/` tree. Lab rules are read on demand by the agent, not injected into every session. |
| [`shaharlab-jspsych`](shaharlab-jspsych/) | Online experiment development: the `lab-online-exp-orchestrator` interview/blueprint/dispatch workflow, jsPsych coding style (incl. Likert scales and window/attention monitoring), and manuscript method-section excerpts — built and reviewed by its own `code-architect` / `code-reviewer` pair. |

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
or `/shaharlab-jspsych:lab-online-exp-orchestrator`. Each plugin's agents
(`code-writer` for data analysis, `code-architect` / `code-reviewer` for
jsPsych) become available as subagent types, dispatched by the skills rather
than invoked directly.

To **update** later:

```
/plugin marketplace update shaharlab
```

## Allow the plugins to read their own knowledge (one time)

Malka routes her subagents to one file at a time — her `references/`, the
`coding-knowledge/` tree, each agent's checklist. Those files live in the plugin
cache, outside your project, so Claude Code asks you to approve every single
read. Add this once to `~/.claude/settings.json` and the approvals stop:

```json
{
  "permissions": {
    "allow": [
      "Read(~/.claude/plugins/cache/shaharlab/**)",
      "Glob(~/.claude/plugins/cache/shaharlab/**)",
      "Grep(~/.claude/plugins/cache/shaharlab/**)"
    ]
  }
}
```

This grants read access to these plugins' own files and nothing else. It covers
both plugins and survives every `/plugin marketplace update`.

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

Loaded this way the files sit in your clone rather than the plugin cache, so the
allowlist above points at the clone instead — one rule per tool, with your own
path:

```json
{
  "permissions": {
    "allow": [
      "Read(~/path/to/shaharlab_ai_plugins/**)",
      "Glob(~/path/to/shaharlab_ai_plugins/**)",
      "Grep(~/path/to/shaharlab_ai_plugins/**)"
    ]
  }
}
```

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

- Claude Code has no way for a plugin to ship its own permissions, so the read
  allowlist above is a one-time step you run yourself. Manage any other tool
  permissions in your own project's `.claude/settings.json` (or via
  `/permissions`).
- Neither plugin ships hooks or slash commands — skills and agents are the only
  entry points, so no Node.js is required and unrelated sessions stay free of
  lab-specific context. The behavioral-data-analysis agents read the lab's
  project and coding rules from `coding-knowledge/00-constitution/` on demand,
  only when a lab task is actually in progress.

## Layout

```
.claude-plugin/marketplace.json    lists both plugins (enables /plugin install)

shaharlab-behavioral-data-analysis/
├── .claude-plugin/plugin.json
├── README.md · CHANGELOG.md
├── skills/    malka (the orchestrator), code-walkthrough
├── coding-knowledge/  00-constitution, 01-folder-specific-rules, 02-scaffolding,
│                      03-preprocessing, 04-visualization, 05-bayesian-regression
│                      (not skills — indexed by malka, read by the agents)
└── agents/    code-writer

shaharlab-jspsych/
├── .claude-plugin/plugin.json
├── README.md · CHANGELOG.md
├── skills/    lab-online-exp-orchestrator, jspsych-coding-style, manuscript-excerpt
└── agents/    code-architect, code-reviewer
```

Licensed under [MIT](LICENSE).
