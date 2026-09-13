# Project terms

**researcher**

the user you are working for and that is prompting you is call `researcher`. 

**main-folder**
One of the five directories at the project root: `data/`, `preprocessing/`, `models/`, `analysis/`, `simulation/`.

**job**
One unit of work.

**job-folder**
The directory that job writes into.

**collected-data**

Type of data placed by the user from the data collecting machine that is READ-ONLY.  This is not one files, but a description for the phase in preprocessing a certian files is at.

**raw-data**
Type of data that is created by this repo. This includes a tidier version of the data where only columns and rows with information are included. The class of columns is handled, and missing data is coded properly. 

**processes-data**

Type of the data that is also created by this report and is an advanced version where the raw data was preprocessed to exclude observations and participants according to the researcher's guidelines. Processed data is mostly the only type of data that is used for analysis, regression, plotting, etc. This is the final set that is used to explore and understand the data. 

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
