# Window monitoring — behavioral attention check

## Context

Window monitoring is the lab's behavioral attention check: it detects when a participant
leaves the study window (tab switch, window blur, fullscreen exit) during an online
experiment. It complements the infrequency catch item (`attn_check`, e.g. "I participated
in the Olympic Games of 1974.") — the catch item flags participants who respond without
reading; window monitoring flags participants who were away from the screen. Apply this
reference whenever the blueprint marks **Leaving the window** as used, and when
summarizing exported session data for it. Throughout, the check informs and the
researcher decides: it flags sessions for review, and exclusion is always the
researcher's call.

This reference has two parts:

- **Recording** — what the experiment code logs while the participant runs the study.
- **Reporting** — how to summarize completed sessions per participant from exported data,
  when the researcher asks for a window-monitoring report.

## Procedure

**Recording**

1. Confirm the blueprint marks **Leaving the window** as used; if not, this reference
   does not apply.
2. Define `initWindowMonitoring(jsPsych)` in `js/helpers.js` (Coding rules below) and call
   it once from `setupExperimentEnvironment(jsPsych)` in `js/setup.js` — the same place
   attention logging is wired in ([setup-js.md](../general/setup-js.md)).
3. Give every trial the two stamped columns and every leave event its own audit row
   (Coding rules below).
4. Check the Recording items in Validation.

**Reporting**

1. Locate the data: a researcher-provided path (single CSV or a directory of participant
   CSVs), or ask where the exported Pavlovia CSVs live if no path is given.
2. Parse each CSV into trial rows and audit rows, compute the three measures, and write
   the report file (Coding rules below).
3. Check the Reporting items in Validation.

## Coding rules

### Recording

**Data shape**

Two columns on every trial row — the researcher's at-a-glance signal, a scan down one
column shows exactly which trials were affected:

| Column | Values | Meaning |
|---|---|---|
| `window_status` | `ok` / `left` | `ok` when the window stayed focused and visible for the whole trial; `left` when the participant was away at any point during it. |
| `window_left_ms` | integer ≥ 0 | Total milliseconds away during this trial. `0` whenever `window_status` is `ok`. |

One audit row per leave-type event, carrying the event-level detail behind the per-trial
columns:

| Column | Values |
|---|---|
| `event_type` | `attention_event` — identifies audit rows; filter on this column, and only this column |
| `attention_event` | `exit_fullscreen` / `tab_hidden` / `window_blur` |
| `in_fullscreen` | boolean, state at the moment of the event |
| `page_hidden` | boolean, state at the moment of the event |
| `timestamp` | ISO 8601 string |

An audit row's `phase` echoes whichever trial happened to be running: jsPsych 7.x merges
the concurrent trial's data over `jsPsych.data.write()` calls (`Object.assign({},
data_object, trial.data, ...)`), so the trial's own `phase` overwrites the value passed
in — `event_type`, not `phase`, is what isolates audit rows. In exports predating the
`event_type` fix, flag the file as legacy and treat `phase` as unreliable for isolating
audit rows.

**Listeners**

Attach once, in `index.html`'s inline ENVIRONMENT SETUP block (via
`initWindowMonitoring(jsPsych)`), before the timeline runs:

- **Leave events** — `visibilitychange` (page hidden), `blur` (window loses focus),
  `fullscreenchange` (fullscreen exited). Each firing writes one audit row.
- **Return events** — `visibilitychange` (page visible again), `focus` (window
  refocused). These close the away interval below; they update state and stay out of the
  data.

**Measuring time away**

The participant counts as **away** while the page is hidden or the window is blurred.
Track one **away interval** rather than per-event durations, because a single physical
exit usually fires several events at once (alt-tabbing out of fullscreen fires
`exit_fullscreen`, `tab_hidden`, and `window_blur` together):

1. **Open** the interval at the first event that makes the participant away (record
   `performance.now()`). Further leave events while already away add audit rows and
   leave the interval as is.
2. **Close** the interval at the first return event that makes the page visible and the
   window focused again; add the elapsed time to a running per-trial accumulator.
3. **Stamp each trial**: in a global `on_trial_finish` (see `JSPSYCH_INIT_OPTIONS` in
   [setup-js.md](../general/setup-js.md)), write `window_left_ms` from the accumulator
   and set `window_status` (`left` when the accumulator is positive, `ok` when zero),
   then reset the accumulator.
4. **Interval spanning a trial boundary**: the ending trial receives the away time that
   elapsed during it and is marked `left`; the interval stays open into the following
   trial(s).
5. **Interval still open at session end**: the time elapsed so far goes to the final
   trial.

A fullscreen exit on its own (window still focused and visible) writes an audit row and
leaves the away interval closed — the participant can still see the study. It shows up
in `leaving_times` and the audit trail, while `window_left_ms` stays a pure measure of
time the study was out of sight.

**Where the code lives**

`initWindowMonitoring(jsPsych)` lives in `js/helpers.js` — it is genuinely reused
(called once from setup, referenced by every trial's stamping) and setup.js already
calls sibling helpers like `initAttentionLogging(jsPsych)` from there. It only attaches
listeners and defines the accumulator/stamping logic; it never calls `initJsPsych()` or
`jsPsych.run()`.

### Reporting

**Step 1 — Locate the data**

- With a path argument, use it: either a single CSV (one participant/session) or a
  directory of participant CSVs (a data-collection wave).
- Without a path, ask the researcher where the exported Pavlovia CSVs live — they are
  downloaded per wave and kept outside the repo.
- Read `.csv` files in a directory and skip everything else; when a file lacks this
  experiment's schema, record it as unreadable and continue with the rest.

**Step 2 — Parse per participant**

For each CSV (one CSV = one participant/session):

1. Identify the participant: prefer `prolific_pid` when present and non-empty, then
   `participant_id`, then the filename.
2. Sort rows chronologically by `timestamp`.
3. Split into **trial rows** and **audit rows** (`event_type == "attention_event"`).

**Step 3 — Compute three measures per participant**

| Measure | Source | Definition |
|---|---|---|
| `leaving_times` | audit rows | Number of distinct leaving instances. Group consecutive audit rows within 1 second of each other (`timestamp` gap ≤ 1000 ms) into one instance — one physical exit fires several events at once. Zero audit rows means `leaving_times = 0`. |
| `trials_left` | trial rows | Number of trials with `window_status == "left"`. |
| `total_time_away` | trial rows | Sum of `window_left_ms`, reported in seconds with one decimal. |

- The 1-second grouping window is a lab convention, not something derived from the data.
  When the researcher asks for a different threshold or raw event counts, apply their
  definition and record which definition the report used.
- `leaving_times` can exceed what the other two measures suggest: a fullscreen exit with
  the window still visible counts as an instance while adding zero away time. Read the
  three measures together.
- **Legacy exports** (per-trial columns absent): report `leaving_times` from the audit
  rows and write `not recorded` for `trials_left` and `total_time_away`.

**Step 4 — Write the report**

Write one file inside `window_monitoring_reports/` at the project root, creating the
folder when needed: `window_monitoring_reports/<label>_report.md`, where `<label>` is the
input directory's name, or today's date (YYYY-MM-DD) for a single file.

Report contents, in order:

1. A summary line: participants processed, unreadable/skipped files, participants with
   `leaving_times = 0`, total leaving instances, total time away across all participants.
2. A table with one row per participant — including all-zero participants — sorted by
   `leaving_times` descending:

   | Participant | leaving_times | trials_left | total_time_away_s |
   |---|---|---|---|

3. A closing note, verbatim in spirit:
   > `leaving_times` counts distinct window-exit instances (same-moment multi-event
   > firings within 1 second are one exit). `trials_left` and `total_time_away_s` come
   > from the per-trial `window_status` / `window_left_ms` columns. These are behavioral
   > attention signals for review — cross-reference with the `attn_check` item and use
   > your own judgment; exclusion is the researcher's call.

**Step 5 — Notify the researcher**

Report the output file path plus an inline headline, so the numbers arrive without
opening the file: how many participants had `leaving_times = 0` vs. ≥ 1, the top 1–3
participants by `leaving_times`, and the participant with the most `total_time_away`.

## Example

Structure only — wire-up in `js/helpers.js` and `js/setup.js`, adapt names to the project.

```javascript
// js/helpers.js
function initWindowMonitoring(jsPsych) {
  let awayStart = null;
  let accumulatedMs = 0;

  function writeAuditRow(attention_event) {
    jsPsych.data.write({
      event_type: "attention_event",
      attention_event: attention_event,
      in_fullscreen: !!document.fullscreenElement,
      page_hidden: document.hidden,
      timestamp: new Date().toISOString(),
    });
  }

  function openAwayInterval() {
    if (awayStart === null) awayStart = performance.now();
  }

  function closeAwayInterval() {
    if (awayStart !== null) {
      accumulatedMs += performance.now() - awayStart;
      awayStart = null;
    }
  }

  document.addEventListener("visibilitychange", () => {
    if (document.hidden) {
      writeAuditRow("tab_hidden");
      openAwayInterval();
    } else {
      closeAwayInterval();
    }
  });
  window.addEventListener("blur", () => {
    writeAuditRow("window_blur");
    openAwayInterval();
  });
  window.addEventListener("focus", closeAwayInterval);
  document.addEventListener("fullscreenchange", () => {
    if (!document.fullscreenElement) writeAuditRow("exit_fullscreen");
  });

  // Called from JSPSYCH_INIT_OPTIONS.on_trial_finish (js/setup.js)
  function stampTrial(data) {
    data.window_left_ms = Math.round(accumulatedMs);
    data.window_status = accumulatedMs > 0 ? "left" : "ok";
    accumulatedMs = 0;
  }

  return { stampTrial };
}
```

```javascript
// js/setup.js — called once, right after initJsPsych()
function setupExperimentEnvironment(jsPsych) {
  const { stampTrial } = initWindowMonitoring(jsPsych); // js/helpers.js
  // ... participant/session IDs, addProperties, etc.
  return { participantId, sessionId, stampTrial };
}
```

```javascript
// js/setup.js — JSPSYCH_INIT_OPTIONS, wired before setupExperimentEnvironment runs
const JSPSYCH_INIT_OPTIONS = {
  on_trial_finish: function (data) {
    data.timestamp = new Date().toISOString();
    if (typeof windowMonitoringStampTrial === "function") windowMonitoringStampTrial(data);
  },
};
```

## Validation

**Recording**

- [ ] The blueprint marks **Leaving the window** as used before this reference is
      applied at all.
- [ ] `initWindowMonitoring(jsPsych)` lives in `js/helpers.js` and is called once from
      `setupExperimentEnvironment(jsPsych)` in `js/setup.js`.
- [ ] Every trial row carries `window_status` and `window_left_ms`; every leave event
      writes one `event_type == "attention_event"` audit row.
- [ ] Audit rows are isolated by `event_type`, never by `phase`.
- [ ] The away interval opens on the first leave event and closes on the first
      qualifying return event, spanning trial boundaries correctly.
- [ ] Nothing in `js/helpers.js` calls `initJsPsych()` or `jsPsych.run()`.

**Reporting**

- [ ] Unreadable/non-CSV files are recorded and skipped, not silently dropped.
- [ ] `leaving_times`, `trials_left`, and `total_time_away` use the definitions above,
      including the 1-second grouping window (or the researcher's stated override).
- [ ] Legacy exports without per-trial columns report `trials_left`/`total_time_away` as
      `not recorded` rather than `0`.
- [ ] The report file lands at `window_monitoring_reports/<label>_report.md`, includes
      the summary line, the full per-participant table, and the closing note verbatim in
      spirit.
- [ ] The researcher is notified with the file path and an inline headline, not just a
      pointer to the file.
