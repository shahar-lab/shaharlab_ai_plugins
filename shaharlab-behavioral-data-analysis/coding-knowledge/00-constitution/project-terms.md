# Project terms

**main-folder**
One of the five directories at the project root: `data/`, `preprocessing/`, `models/`, `analysis/`, `simulation/`.

**job**
One unit of work.

**job-folder**
The directory that job writes into.

## The reserved set

These are claims about the science. The researcher sets each one — they are the numbers that reach a manuscript:

- **formula** and random-effects structure
- **family**
- **priors** — family and parameters
- **sampling** — chains, iterations, warmup
- **exclusion cutoff** — the trial count, RT bound, or `window_exit_max` that removes data
- **plot type** and the researcher-chosen values on that figure
- **threshold** — any number that decides what counts as a case, a group, or an effect
- **recovery criterion** — the correlation, bias, or precision a recovery study is judged by

The interview takes each of these from the user before any code is written. A Writer whose specification is silent on one returns `BLOCKED`.

A value outside this set — how a script is split, what an object is called, the order of panels in a figure — is the Writer's to take, recorded with an `ASSUMED` tag where the specification left it open.
