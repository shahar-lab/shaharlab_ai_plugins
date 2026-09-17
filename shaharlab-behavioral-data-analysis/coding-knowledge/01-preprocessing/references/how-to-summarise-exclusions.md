# How to write the `summary_` scripts

## 1. Context for writing you script:

A `preprocessing_excerpt` is a script that generates a manuscript ready pargarpah that detials the exclusion processes. For this, you should read yourself the `output/processed/exclusion.md` file. Then write a manuscript paragraph that is eactly in the numbers and pipilne that appears in the `exclusion.md` file. You should learn the tone and writing style according to the exmplae below.

## 2. Rules and guidelines

* Read `output/processed/exclusion.md` before writing anything. That file is the source of truth for the pipeline and the counts.

* Use every criterion in the order it appears. Do not add a criterion, drop one, or change the order.

* Every number in the paragraph must be a number from `exclusion.md`. Do not recompute from the data, and do not round to a different value.

* Name each cutoff as the report names it (the researcher's wording).

* Write one dense narrative paragraph that starts with `Data treatment.` No headings, tables, or bullet lists.

* Match the tone of the example in section 3: past tense, first person plural, criteria first, then the Ns that remain.

* Write the paragraph to `output/processed/` as a markdown file. This script does not save data to `data/`.

* If `exclusion.md` is missing a count the paragraph would need, return `BLOCKED`. Do not guess.

* Keep the script to 50–80 lines.

## 3. Example


The example below shows the style; each criterion and cutoff in the delivered paragraph is the
user's own value:

> *Data treatment. During data preprocessing, we first examined the quality of the behavioral data.
> Poor quality was defined by having either (a) more than 20% excluded trials due to no response,
> implausibly fast or implausibly slow reaction times (RTs < 0.2 sec or > 4 sec), or (b) selecting
> the same response key in over 90% of trials within a block. Due to this examination, two
> participants from the ADHD group and one from the control group were excluded. Furthermore, due to
> a technical error, the data of one participant in the ADHD group was not submitted and the
> participant was therefore excluded. From the remaining behavioral observations we omitted trials
> with no response (<1% of all trials), and trials with implausibly quick reaction times (< 0.2 sec)
> or exceptionally slow reaction times (> 4 sec; <1% of all trials). This resulted in 8,717 trials
> for the ADHD group (198.11 mean trials per participant) and 8,661 trials for the control group
> (196.84 mean trials per participant).*


