# jspsych-coding-style — interview

Read by `lab-online-exp-orchestrator` during its INTERVIEW step whenever a request adds
the `jspsych-coding-style` stage. These are implementation-level questions the blueprint
interview doesn't already cover — ask every BLOCKING item that isn't already answered by
the approved blueprint/specification before dispatching `code-architect`.

## BLOCKING

- **Scope** — which file(s) is this touching: a new phase script, an edit to an
  existing one, `index.html` itself, `local_dev.js`, `config.js`, `setup.js`, or a
  specific component (instructions, timeline block, Likert scale, window monitoring)?
  If the blueprint already names the phase, confirm rather than re-ask.
- **New vs. existing project** — is this the first `index.html`/`js/` generation for
  this experiment, or an update to a running codebase? (Determines whether the full
  template in `references/general/index-html.md` applies or only a targeted edit.)
- **Missing assets** — does this phase reference stimuli, images, audio, or other files
  the researcher supplies? Confirm they exist in `assets/` before building around them;
  if any are missing, that is a BLOCKING gap, not a placeholder to invent.
- **Pavlovia state** — should `PAVLOVIA_PLUGIN_ACTIVATE` change from its current value?
  Only flip it to `true` on the researcher's explicit approval (see
  `references/general/local-dev-js.md`).
- **Local-dev overrides** — does this change need a `CONFIG_LOCAL_DEV` shortcut (item-pool
  truncation, block shortening) for testing? If so, what's the "off" default?

## Non-blocking (nice to confirm, don't stall on)

- Whether an existing CSS class/helper should be reused instead of a new one.
- Whether a component (Likert, window monitoring) should follow the reference example's
  defaults or the researcher wants a variant — note any variant request explicitly so
  `code-architect` doesn't have to guess from the blueprint alone.

## Signs the interview isn't done yet

- You're about to guess which file a change belongs in instead of asking.
- A referenced asset's existence hasn't been confirmed.
- The researcher's request implies a Pavlovia-mode change without saying so explicitly.
