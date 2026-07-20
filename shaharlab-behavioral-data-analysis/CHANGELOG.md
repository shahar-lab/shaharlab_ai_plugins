# Changelog — shaharlab-behavioral-data-analysis

## [Unreleased]
- bayesian-regression: added `references/02_diagnostics.md` — mandatory `diagnostic.pdf` script (ESS/Rhat summary table, trankplot, pairs plot as separate pages); wired into SKILL.md, EXPERT-INSTRUCTIONS.md, README.md, and the brms-expert agent; also fixed stale reference paths left over from before the numbered `references/` convention.
- docs: added a plugin `README.md` (skills table, agents list, SessionStart/Node note).
- data-preprocessing: encoded the fixed folder structure (`preprocessing/code|output|main.R`, `data/collected|raw|processed`) and the pipeline deliverables — raw restructuring, data-quality PDF (aborted trials + per-subject RT table), user-defined exclusions to processed, and a manuscript-ready "Data treatment" paragraph (.md) with computed numbers.
- data-preprocessing: removed concrete exclusion values (RT cutoffs, thresholds) in favor of placeholders; added hard rule that exclusion criteria must come from the user, never chosen by the AI (enforced in SKILL.md, template, and review checklist).
- data-preprocessing: added `assets/template_main.R` — preprocessing orchestrator template with the four pipeline steps and fixed path setup.

## [1.0.0] — 2026-07-15
- Initial plugin release: skills (bayesian-regression, code-walkthrough, data-preprocessing, plotting, project-scaffolding), agents (malka-orchestrator, code-architect, code-reviewer), lab rules injected via SessionStart hook.
