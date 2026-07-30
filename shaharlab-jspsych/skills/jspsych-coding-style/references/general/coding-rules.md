# General jsPsych coding rules

## Context

These rules apply across every file in the plain-script architecture, regardless of
which reference in this skill governs the specific file being touched. Read this
alongside whichever reference applies to the file at hand — it is not a substitute for
`index-html.md`, `local-dev-js.md`, `config-js.md`, `setup-js.md`, or the `components/`
and `validity_checks/` references, only the rules common to all of them.

## Rules

- **jsPsych 8.** Pin the core to `8.x` and plugins to their matching `2.x` line. Note the
  v8 API: `button_html` is a function `(choice, choiceIndex) => html` — the `%choice%`
  string template no longer exists.
- `initJsPsych()` and `jsPsych.run()` appear only in `index.html`'s inline script, each
  exactly once. Phase files never call them.
- Phase scripts push their own trials onto the shared global `timeline` and never touch
  another phase's nodes; only `index.html` creates `timeline` and runs it.
- Prefer `timeline_variables` when many trials share one structure and differ only in
  data. Ordinary loops are fine when they express real generation logic — pair
  generation, accumulated instruction pages, per-trial closures.
- Timing, labels, fixed wording, and feature flags live in `js/config.js`; test-only
  overrides live in `local_dev.js`. Never duplicate either in phase scripts.
- Give every saved trial an explicit, meaningful `data` object. Keep column names and
  value types stable across the study.
- Participant-facing text comes from the blueprint, validated materials, or explicit
  researcher instructions — never invented, never silently reworded.
- Comment non-obvious behavior and invariants only; do not narrate straightforward syntax.
- If a referenced deployment-critical file (Pavlovia bridge, credentials, pinned vendor
  library) is missing or its path looks wrong, stop and report it — via
  `lab-online-exp-orchestrator` back to the researcher — rather than recreating,
  renaming, or sourcing a replacement on your own judgment.
