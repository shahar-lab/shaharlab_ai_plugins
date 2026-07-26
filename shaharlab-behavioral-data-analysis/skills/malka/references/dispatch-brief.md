# Malka: Dispatch Brief Templates

Both subagents start cold — they see only their own agent file plus whatever brief you hand them. A thin brief produces a guessing subagent; a complete one produces a correct build on the first pass. Never dispatch without every applicable field below filled in.

## Brief to the executor (`code-architect`, or `brms-expert` via code-architect)

```
Governing skill: <data-preprocessing | bayesian-regression | plotting | project-scaffolding>

User's goal (their own words): <...>

Approved specification (verbatim, nothing paraphrased or invented):
- Formula: <...>                  (bayesian-regression only)
- Priors: <...>                   (bayesian-regression only)
- 3-step plan: <...>              (bayesian-regression only)
- Exclusion criteria: <...>       (data-preprocessing only — user-supplied values, never yours)
- Folder name / clone source: <...> (project-scaffolding only)
- Plot type + any user-specified overrides: <...> (plotting only)

Inputs: <file paths / data location>
Output: <what should be produced, and where>
New or existing: <fresh work | modifying/extending — name what already exists>

Do NOT re-ask the user for anything listed above as approved — it is locked in.
```

## Brief to the reviewer (`code-reviewer`)

```
What was built and where: <files, folders touched>

Governing skill: <same as above>
Reviewer checklist to use: <the exact path from SKILL.md's Phase 2 table —
  e.g. workflow/REVIEW-INSTRUCTIONS.md, workflow/REVIEWER.md,
  workflow/EXPERT-INSTRUCTIONS.md post-generation checklist, or
  plotting's SKILL.md "Mandatory rules" + standards/EXPORT_STANDARD.md>

User's original intent: <...>
Approved specification: <same values passed to the executor, so scope creep against
  what was actually approved is catchable>
```

## Why the checklist path is explicit, not inferred

`code-reviewer` does not maintain its own list of "which skill uses which checklist" — that list lives once, in `malka/SKILL.md`'s Phase 2 table. Naming the exact file in the brief means the reviewer never has to guess, and the mapping never has to be kept in sync across two agent files.
