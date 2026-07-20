# Contributing

This repo ships two independently-versioned Claude Code plugins:
`shaharlab-behavioral-data-analysis` and `shaharlab-jspsych`. If you edit a
plugin's contents, follow the rules below so `main` stays clean and students
can always tell what changed.

## Golden rule: edits ≠ versions

Several changes usually land before we call the result a "version."

- **Never bump the `version` field in a plugin's `.claude-plugin/plugin.json`
  as part of an ordinary change.** Work-in-progress commits keep the current
  version untouched.
- After **any** change to a plugin's content (skills, agents, context, hooks),
  add a one-line bullet under the `## [Unreleased]` section of that plugin's
  `CHANGELOG.md`. A plugin edit without a changelog line is incomplete.
- A version is cut **only when a maintainer explicitly decides to release.**

## Cutting a release (maintainers)

1. Read the plugin's `CHANGELOG.md` `[Unreleased]` bullets and pick the semver bump:
   - **PATCH** (1.0.x) — fixes, typos, wording/prompt tweaks; no change to how
     lab members invoke things.
   - **MINOR** (1.x.0) — new skill, agent, reference, or capability;
     backwards-compatible additions.
   - **MAJOR** (x.0.0) — renamed/removed skills or agents, changed invocation
     names, or anything that breaks existing lab habits.
2. Update `version` in that plugin's `.claude-plugin/plugin.json`.
3. In `CHANGELOG.md`, rename `## [Unreleased]` to `## [x.y.z] — YYYY-MM-DD`
   (today's date) and add a fresh empty `## [Unreleased]` section above it.
4. Commit `Release <plugin-name> vx.y.z` and tag it:
   `git tag <plugin-name>-vx.y.z`.

Only the plugin(s) whose content changed get bumped — the two plugins version
independently. Version numbers live in exactly one authoritative place per
plugin: its `plugin.json`. Do not write version numbers into `SKILL.md` files,
agent files, or READMEs.

## Workflow

- Treat `main` as the branch students consume (`git pull`). Land changes via a
  short-lived branch + PR rather than pushing WIP straight to `main`, so `main`
  is always in a pullable state.
- If you bump the marketplace manifest (`.claude-plugin/marketplace.json`),
  keep its `metadata.version` in step with meaningful repo-level changes; it is
  independent of the individual plugin versions.
