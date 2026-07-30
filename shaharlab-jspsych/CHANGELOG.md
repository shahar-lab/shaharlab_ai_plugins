# Changelog — shaharlab-jspsych

## [Unreleased]
- **architecture:** replaced the seven-agent pipeline (`tzadok`, `planning-interviewer-galit`,
  `planning-architect-miri`, `planning-reviewer-devorah`, `jspsych-architect-dan`,
  `jspsych-reviewer-ezra`, `manuscript-editor-baruch`) with a two-agent model
  (`code-architect`, `code-reviewer`) driven by a new orchestrator skill,
  `lab-online-exp-orchestrator` (renamed from the working name
  `lab-experiment-orchestrator`), mirroring `shaharlab-behavioral-data-analysis`'s
  Malka/Sharon/Tomer pattern. The orchestrator runs in the main thread (interview →
  blueprint → gate → dispatch → report); `code-architect` writes every work product;
  `code-reviewer` reviews it against the stage's own checklist.
- **architecture:** absorbed the standalone `experiment-plan` skill into
  `lab-online-exp-orchestrator` — its interview topics, blueprint/spec mechanics,
  changelog format, and blueprint-sync decision ladder are now embedded directly in the
  orchestrator's `SKILL.md`. `blueprint-format.md`, `example_blueprint.md`, and
  `example_specification.md` moved to the orchestrator's own `reference/` folder; the
  `experiment-plan` skill folder no longer exists.
- Added `interview.md` to `jspsych-coding-style` and `manuscript-excerpt`, listing the
  BLOCKING questions the orchestrator asks before dispatching each stage.
- Extracted the "General jsPsych coding rules" section of `jspsych-coding-style/SKILL.md`
  into a new `references/general/coding-rules.md`, read by both subagents.
- docs: added a plugin `README.md` (skills table, agents list).
- jspsych-coding-style: split `references/` into `references/general/` (config-js,
  index-html, local-dev-js, setup-js) and `references/components/` (instructions,
  timeline-blocks); added a new `references/components/likert.md` for a page-by-page
  Likert scale component (centered layout, large item-text font, aligned buttons,
  disabled/active/hover/press states, post-selection ITI).
- Removed the standalone `jspsych-window-monitoring` skill; its recording and reporting
  content now lives in `jspsych-coding-style`'s new
  `references/validity_checks/window-monitoring.md`, referenced from
  `jspsych-coding-style/SKILL.md`. The `/jspsych-window-monitoring <path>` invocable
  report command no longer exists as a separate skill — reporting is now reference
  material only, applied when the researcher asks for a window-monitoring report.

## [1.0.0] — 2026-07-15
- Initial plugin release: skills (jspsych-coding-style, jspsych-window-monitoring, experiment-plan, manuscript-excerpt), agents (tzadok, planning-interviewer-galit, planning-architect-miri, planning-reviewer-devorah, jspsych-architect-dan, jspsych-reviewer-ezra, manuscript-editor-baruch).
