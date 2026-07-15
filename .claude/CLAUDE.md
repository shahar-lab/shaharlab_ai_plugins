# Version Numbering Policy (enforced)

This repo ships two Claude Code plugins (`shaharlab-behavioral-data-analysis`, `shaharlab-jspsych`). Each has its own independent version in its `.claude-plugin/plugin.json`.

## Core rule: edits ≠ versions

Several changes are often needed before we call the result a "version". Therefore:

- **Never bump the `version` field in `plugin.json` as part of an ordinary change.** Work-in-progress commits keep the current version untouched.
- Instead, after ANY change to a plugin's content (skills, agents, context, hooks), add a one-line bullet describing it under the `## [Unreleased]` section of that plugin's `CHANGELOG.md`. This is mandatory — a plugin edit without a changelog line is incomplete.
- A version is cut **only when the user explicitly asks** ("release", "bump the version", "call this a version", "new version").

## When the user asks to cut a version

1. Read the plugin's `CHANGELOG.md` `[Unreleased]` bullets and pick the semver increment:
   - **PATCH** (1.0.x) — fixes, typos, wording/prompt tweaks, clarifications; no change to how lab members invoke things.
   - **MINOR** (1.x.0) — new skill, agent, reference, or capability; backwards-compatible workflow additions.
   - **MAJOR** (x.0.0) — renamed/removed skills or agents, changed skill invocation names, changed folder topology rules, or anything that breaks existing lab habits.
2. Update `version` in that plugin's `.claude-plugin/plugin.json`.
3. In `CHANGELOG.md`, rename `## [Unreleased]` to `## [x.y.z] — YYYY-MM-DD` (today's date) and add a fresh empty `## [Unreleased]` section above it.
4. Commit with message `Release <plugin-name> vx.y.z` and tag it: `git tag <plugin-name>-vx.y.z`.

Only the plugin(s) whose content changed get bumped — the two plugins version independently.

## Guardrails

- If asked to "update the version" without an explicit release intent, ask whether to cut a release or just log the change to `[Unreleased]`.
- Suggest cutting a release when `[Unreleased]` has accumulated many entries or contains a MAJOR-worthy change, but never do it unprompted.
- Version numbers appear in exactly one authoritative place per plugin: `plugin.json`. Do not write version numbers into SKILL.md files, agent files, or the README.
