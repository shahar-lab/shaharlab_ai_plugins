# Execution Cards

Read this at Step 2, after the user has approved the summary card and after routing is decided. Build both cards before dispatching either — that is what keeps the Reviewer checking the same stages the Writer was told to write.

## What a card is

A card is the prompt string you pass when you spawn a subagent. Three properties, all load-bearing:

**Paths, never content.** A card names which files in `coding-knowledge` to read. It does not quote them, summarize them, or paraphrase them. The subagent pulls several thousand tokens of library into its own window; you spend a few hundred on the pointer. Pasting library text into a card defeats the only reason the subagents exist.

**Ephemeral.** Cards are not written to disk. They are working instructions, not artifacts, and the user has no reason to see one.

**Short.** A finished card fits on a screen. If yours is longer, content has leaked in where a path belongs.

Both cards are projections of the approved summary card — one says *write this*, the other says *check for this*. The specification is identical in both; only the task, the routed reads, and the return differ.

## Shared skeleton

```
TASK
One line: what this agent is doing.

BINDING READS
- coding-knowledge/00-constitution/coding-rules.md
- coding-knowledge/00-constitution/project-rules.md

ROUTED READS
- [the Step 2 selection for this agent]

SPECIFICATION
[the approved job, in the user's exact values]

ENVIRONMENT
[the variables, libraries, and folders the domain knowledge assumes]

OUTPUT
[path, or paths]

RETURN
[what comes back, and nothing else]
```

The two binding reads appear on every card, both agents, every round. They are never routed and never omitted.

The `SPECIFICATION` block is copied verbatim into both cards. The Reviewer needs it because the checklists catch convention violations while only the specification catches code that is clean and does the wrong thing.

## Writer card

- **Routed reads** — the instruction files for the selected stages.
- **Task** — write the code.
- **Return** — the output path, plus any `ASSUMED` tags it added, and nothing else. The tags are specification statements rather than code, and you need them for the handback. Do not ask for a summary of the code or an explanation of its choices.

## Writer card, revision rounds

Reuse the round-1 card unchanged and append the revision block. Routing does not change between rounds — the job is the same job, only the task has shifted from writing to fixing.

```
REVISION — ROUND [N]
Your previous attempt is at [path].
The reviewer's findings are tagged inside it as # REVIEW[...] comments.
Resolve each finding and delete its tag as you fix it.
Leave no REVIEW tag behind.
Change nothing the reviewer did not flag.
```

The last line matters. Unflagged rewriting in a revision round can break code that already passed, which turns a converging loop into a wandering one.

## Reviewer card

- **Routed reads** — `review-checklist.md` for the same stages the Writer was routed to.
- **Task** — annotate in place. Add a tagged comment on the offending line; do not rewrite, refactor, or fix anything. A reviewer that edits the file is a second writer, and the loop loses the independent check that justifies having two agents.
- **Tag format** — `# REVIEW[source §ref]: finding`, citing the rule or checklist item that the line violates.
- **Return** — `PASS` or `FAIL`, and nothing else.

`PASS` means two things at once: the Reviewer found no new violations, and no `REVIEW` tag remains in the file from an earlier round. A leftover tag is an automatic `FAIL` — the file carries its own pass condition, so no verdict has to be stored or trusted anywhere else.

## Either agent may return BLOCKED

Both cards allow one further return: `BLOCKED`, when the specification is silent on something the agent needs. Do not omit it from the `RETURN` block — an agent with no way to say the card is incomplete will guess instead. `references/guidelines-dispatch-subagents.md` covers what you do with it.
