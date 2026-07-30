---
name: jspsych-coding-style
description: Enforce ShaharLab's plain-script architecture whenever Claude creates, modifies, reviews, or troubleshoots JavaScript for a jsPsych experiment. Use for phase scripts, screens, trials, loops, instruction or consent screens, configuration variables, shared helpers, stimuli, timelines, index.html, setup, local-dev switches, Likert scales, and window monitoring (recording tab/blur/fullscreen exits or reporting on exported session data).
---

# ShaharLab jsPsych Coding Style

## Context

ShaharLab experiments are jsPsych studies deployed to Pavlovia and recruited through
Prolific. Every experiment follows the same architecture: plain `<script>` includes and
browser globals — no ES modules, no bundler, no build step — so a researcher can read,
run, and tweak any file directly. This skill defines that architecture and the coding
rules that keep it intact. Apply it to every jsPsych `.js` and `index.html` change, and
preserve the architecture unless the researcher explicitly approves a structural migration.

## Project structure

```
index.html            The sole orchestrator: loads everything in dependency order,
                      calls initJsPsych() once, assembles the master timeline,
                      guards Pavlovia behind PAVLOVIA_PLUGIN_ACTIVATE, calls jsPsych.run() once.
local_dev.js          Repo root. PAVLOVIA_PLUGIN_ACTIVATE flag + CONFIG_LOCAL_DEV test overrides —
                      the only file a researcher edits for a local test run.
js/
  config.js           Experiment-wide settings and validated content (CONFIG, item
                      pools, attention checks, completion code). Loads first in js/.
  helpers.js          Only helpers genuinely reused across phases.
  setup.js            Environment/session setup: initJsPsych options, per-run IDs,
                      Pavlovia init/finish nodes, local CSV-save fallback.
  <phase>.js          One file per phase (e.g. instructions.js, likert.js,
                      pairwise.js, feedback.js). Each is a plain top-level script
                      that pushes its trials onto the shared `timeline` array.
css/style.css         Experiment styling, layered on the global white/black base.
lib/                  Pavlovia bridge script — injected by Pavlovia at deploy time,
                      never vendored locally (404s harmlessly in local dev).
data/                 Where Pavlovia writes participant CSVs (keep with .gitkeep).
ai_artifacts/plan/    The experiment blueprint — the authoritative design source.
```

Load order in `index.html`: jsPsych core + CSS → plugins → jQuery → Pavlovia bridge →
global CSS override → `local_dev.js` → `js/config.js` → `js/helpers.js` → `js/setup.js` →
inline ENVIRONMENT SETUP → phase scripts in flow order → inline SAVE AND CLOSE →
`jsPsych.run()`.

## References — read before writing

Each part of the codebase has a dedicated reference with its own procedure, coding rules,
example, and validation checklist. **Before creating, adapting, or updating any of the
following, read its reference first and follow its coding rules exactly:**

| Working on | Read first |
|---|---|
| `index.html` — creation or regeneration, Pavlovia integration, script load order | [references/general/index-html.md](references/general/index-html.md) |
| `local_dev.js` — the `PAVLOVIA_PLUGIN_ACTIVATE` flag and `CONFIG_LOCAL_DEV` test-run overrides | [references/general/local-dev-js.md](references/general/local-dev-js.md) |
| `js/config.js` — settings, timing, prompts, labels, item pools, attention checks, completion codes | [references/general/config-js.md](references/general/config-js.md) |
| `js/setup.js` — session identifiers, data stamping, Pavlovia init/finish nodes, local CSV fallback | [references/general/setup-js.md](references/general/setup-js.md) |
| Instruction, consent, or multi-page informational screens | [references/components/instructions.md](references/components/instructions.md) |
| Phase scripts, trial procedures, repeating timeline blocks | [references/components/timeline-blocks.md](references/components/timeline-blocks.md) |
| Page-by-page Likert scale component | [references/components/likert.md](references/components/likert.md) |
| Window monitoring — recording tab/blur/fullscreen exits, or reporting on exported session data | [references/validity_checks/window-monitoring.md](references/validity_checks/window-monitoring.md) |

A change that spans several parts (e.g. a new phase that adds config keys and a script tag)
requires each matching reference.

## General jsPsych coding rules

The rules common to every file in this architecture — jsPsych 8 API, the `timeline`
ownership invariant, where settings/text live, comment discipline, and the
deployment-critical-file guard — live in
[references/general/coding-rules.md](references/general/coding-rules.md). Read it
alongside whichever reference above governs the specific file you're touching.

## Verification

Before completing any JavaScript change:

- Every phase script loads once from `index.html`, in the intended participant-flow order,
  after the ENVIRONMENT SETUP block and before SAVE AND CLOSE.
- `initJsPsych()` and `jsPsych.run()` each occur exactly once, both in `index.html`.
- `local_dev.js`, `config.js`, and `helpers.js` load before their consumers.
- No shared setting is duplicated; every changed identifier has compatible consumers.
- Syntax-check every changed file; search for stale names, missing script tags, and
  undefined globals.
- Run the local smoke check (`PAVLOVIA_PLUGIN_ACTIVATE = false`) when a runnable local mode exists, and
  pass the validation checklist of every reference you applied.
