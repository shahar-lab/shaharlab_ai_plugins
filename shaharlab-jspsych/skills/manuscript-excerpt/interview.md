# manuscript-excerpt — interview

Read by `lab-online-exp-orchestrator` during its INTERVIEW step whenever a request adds
the `manuscript-excerpt` stage. Ask every BLOCKING item before dispatching
`code-architect`.

## BLOCKING

- **Is the experiment finalized?** This skill describes the procedure as implemented —
  if the code is still changing, confirm the researcher wants a write-up of the current
  state (and knows it may need a re-run after further changes) rather than waiting.
- **Which version is "current"?** If the blueprint's changelog shows recent edits,
  confirm which files represent the final procedure to describe — do not silently pick
  the most recent commit without asking when it's ambiguous.
- **Single condition or multiple?** Determines whether the output is one paragraph
  (Example 1 in `SKILL.md`) or a short run of paragraphs across conditions/experiments
  (Example 2). If multiple studies/conditions exist, confirm which ones to include.
- **Tense** — has data collection already run (past tense) or is this a pre-registration
  / write-up before running (future tense, as in `SKILL.md` Example 2)?

## Non-blocking

- Any house style beyond the skill's own examples (journal-specific phrasing, preferred
  terms for conditions) — note it if the researcher volunteers it, don't solicit it.

## Signs the interview isn't done yet

- You don't know whether the code you're about to read is the final version.
- The blueprint describes more than one condition/experiment and it's unclear which the
  researcher wants written up.
