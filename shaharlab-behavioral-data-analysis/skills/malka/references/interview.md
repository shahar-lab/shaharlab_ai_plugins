# Context
Act as a project manager: pin down what the exact requested analysis is, its goal, what it needs, surface anything ambiguous or missing, and resolve it with the user before any code is written. The interview exists to catch what got dropped or worded ambiguously.

# Internlizing the user's request
This step is not to be conveyed to the user, but to help you understand the request and plan the next steps.
-  Summrize to yourself internally the user request in detials. This is not to be conveyed to the user, but to help you understand the request and plan the next steps.
  
-  Make for yourself a "gap-list" of what's missing, what's ambiguous, nothing else. Use the following to direct the gap-list.
   -  **Goal** Make sure you know what the request is trying to achive. 
   -  **Scaffolding.** Confirm the target folder and whether it is new, a clone, or a repair. Ask for a `snake_case` name whenever the user has not given one — the subagents build from the approved specification and have no channel to ask. 
   -  **Preprocessing.** Explore `data/collected/` first, following `coding-knowledge/03-preprocessing/references/exploration.md` — most gaps here are invisible until the data has been seen. Exclusion criteria are the ones that matter: they are decisions rather than facts, and they need the user's explicit numbers. Separate them into the two phases the pipeline runs in order — participant-level criteria (whole-subject removal, e.g. left the session early, subject-level RT thresholds) and trial/observation-level criteria (e.g. no response, RT cutoffs) — plus any further phase the job needs (session-level, block-level). Settle which of the three script kinds the job writes — `converting_`, `examining_`, `summary_` — since that is what Step 3 routes on: a first pipeline writes all three, while a revision often touches only the exclusions and the summary that quotes them. For a study run online, ask for the window-exit cutoff (`window_exit_max`) as one of the participant-level criteria whenever the data carries a `window_status` column — see `coding-knowledge/03-preprocessing/references/handling-leaving-window.md`. Say that one exit means one sequence of consecutive trials away, not one trial, since that is what the number they give will be compared against, and offer the distribution the exploration pass found so they choose against their own participants.
   -  **Bayesian regression.** The random-effect structure and the priors are what typically go unstated. Propose a formula and explain what it models rather than asking the user to produce one, and offer a weakly informative default with a sentence on what it assumes.
   -  **Visualization.** Settle the plot type and whether the output is a single figure or a composite; everything else follows lab defaults.

- You can run a quick exploration across the repo to understand what we alrady have, whats the current status and inform your summary and gap list
# Handeling the communication with the user
- Make a consice list of major questions. Not more then 5.
- Ask the user sequentially: format each question as a Markdown checklist (using `- [ ]`) to trigger the interactive terminal UI, and wait for the answer before asking the next. Say in one line what turns on the answer and propose a specific default, since reacting is easier than specifying. 
