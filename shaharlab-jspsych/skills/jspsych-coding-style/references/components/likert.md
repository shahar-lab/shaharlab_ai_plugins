# Likert component — page-by-page rating scale

## Context

The Likert component presents one item at a time, centered on the screen, with the item
text in large font and a row of aligned response buttons below it. Buttons start
disabled (grayed out) until a configured deadline, then become active with a visible
color, a hover state, and a press state. After a response the item disappears and a blank
inter-trial interval (ITI) plays before the next item. Apply this reference when
creating or modifying any page-by-page Likert phase.

## Procedure

1. Read the blueprint for the item pool, scale labels/anchors, the enable deadline, and
   the ITI duration. Take every value from `CONFIG` — never hard-code them in the phase
   script.
2. Build one `jsPsychHtmlButtonResponse` trial per item via `timeline_variables`, using
   `button_html` for the aligned scale buttons and `enable_button_after` for the disabled
   deadline (Coding rules below).
3. Push a blank ITI trial after each item so the item fully disappears before the next
   one appears.
4. Style disabled / active / hover / press states in `css/style.css` — never inline.
5. Check every item in Validation.

## Coding rules

**Layout**
- Wrap the trial's `stimulus` in a centered container (flex column, `min-height: 100vh`,
  `justify-content: center; align-items: center`) so the item sits in the middle of the
  screen regardless of question length.
- The item/question text uses a large font size class (e.g. `likert-item-text`) —
  distinct from and larger than the scale button labels.
- The scale is a flex row (`likert-scale`) with buttons of equal fixed width
  (`likert-btn`), so labels of different lengths still align into one straight row.

**Disabled → active timing**
- Use the plugin's `enable_button_after` (ms) to hold every button disabled until the
  configured deadline; do not hand-roll a `setTimeout` for this — the plugin already
  disables/re-enables the DOM buttons and keeps `response_ends_trial` correct.
- The deadline value comes from `CONFIG` (e.g. `CONFIG.LIKERT_ENABLE_DELAY_MS`), never a
  literal in the phase script.
- Style native `:disabled` as grayed out (muted background/text, `cursor: not-allowed`)
  and the enabled state with the experiment's visible accent color — the disabled →
  active transition must be visually obvious, not just a change in clickability.

**Hover and press states**
- `:hover:not(:disabled)` gives a distinct hover treatment (e.g. darker/lighter fill).
- `:active:not(:disabled)` gives a distinct press treatment (e.g. scale-down or inset
  shadow) so the participant gets immediate feedback on the click itself, before the
  trial ends.
- Disabled buttons must not show hover or press styling — scope both selectors with
  `:not(:disabled)`.

**Selection → ITI**
- On response, the plugin's default behavior ends the trial and clears `stimulus` — no
  extra code is needed to make the item "disappear."
- Push a separate blank-screen ITI trial (`choices: "NO_KEYS"`,
  `trial_duration: CONFIG.ITI_MS`) immediately after each Likert trial in the
  `timeline_variables` block, matching the ITI pattern in
  [timeline-blocks.md](timeline-blocks.md).

**Data**
- Record `item_number`/`item_id`, the selected scale value, and RT under stable column
  names; the RT jsPsych reports already excludes the disabled period since the response
  listener only attaches once buttons are enabled.

## Example

Structure only — item text, scale labels, deadline, and ITI duration come from the
blueprint and `CONFIG`.

```javascript
/* =====================================================================
   1. LIKERT SCALE TRIAL
   ===================================================================== */
const likert_trial = {
  type: jsPsychHtmlButtonResponse,
  stimulus: () => `
    <div class="likert-container">
      <p class="likert-item-text">${jsPsych.timelineVariable("item")}</p>
    </div>`,
  choices: CONFIG.LIKERT_SCALE_LABELS,
  button_html: (choice) => `<button class="jspsych-btn likert-btn">${choice}</button>`,
  enable_button_after: CONFIG.LIKERT_ENABLE_DELAY_MS,
  data: {
    phase: "likert",
    item_number: jsPsych.timelineVariable("item_number"),
  },
};

/* =====================================================================
   2. INTER-TRIAL INTERVAL
   ===================================================================== */
const likert_iti = {
  type: jsPsychHtmlKeyboardResponse,
  stimulus: CONFIG.BLANK_SCREEN_HTML,
  choices: "NO_KEYS",
  trial_duration: CONFIG.ITI_MS,
  data: { phase: "iti" },
};

/* =====================================================================
   3. LIKERT BLOCK -- pushed onto the shared timeline
   ===================================================================== */
timeline.push({
  timeline: [likert_trial, likert_iti],
  timeline_variables: LIKERT_ITEMS,
  randomize_order: CONFIG.RANDOMIZE_LIKERT_ORDER,
});
```

```css
/* css/style.css */
.likert-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  text-align: center;
}

.likert-item-text {
  font-size: 2rem;
  max-width: 40rem;
  margin-bottom: 2rem;
}

.likert-scale {
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 1rem;
}

.likert-btn {
  width: 6rem;
  padding: 0.75rem 0;
}

/* Disabled until CONFIG.LIKERT_ENABLE_DELAY_MS elapses */
.likert-btn:disabled {
  background-color: #d3d3d3;
  color: #888;
  cursor: not-allowed;
}

/* Active: visible accent color */
.likert-btn:not(:disabled) {
  background-color: #4a90d9;
  color: white;
}

.likert-btn:hover:not(:disabled) {
  background-color: #3a75b0;
}

.likert-btn:active:not(:disabled) {
  background-color: #2c5c8a;
  transform: scale(0.96);
}
```

## Validation

- [ ] The item appears centered mid-screen with the question text visibly larger than
      the scale labels.
- [ ] Every scale button shares the same fixed width and lines up in one row regardless
      of label length.
- [ ] Buttons render disabled/grayed out and become active in the visible accent color
      only after `CONFIG.LIKERT_ENABLE_DELAY_MS` (via `enable_button_after`, not a
      hand-rolled timer).
- [ ] Hover and press styling apply only to enabled buttons (`:not(:disabled)`); disabled
      buttons show neither.
- [ ] The item disappears immediately on response, followed by a blank ITI of
      `CONFIG.ITI_MS` before the next item.
- [ ] Deadline, ITI duration, and scale labels come from `CONFIG`/the blueprint — none are
      hard-coded in the phase script.
- [ ] Data columns (`item_number`, response, RT) use stable names consistent with the
      rest of the study.
