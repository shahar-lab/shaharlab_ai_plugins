# Recovery Notebook: [Model / Study Name]

**Generative model:** `models/[model_name]/`
**Fitted model:** `models/[model_name]/` (or brms formula: `[formula]`)
**Job-folder:** `simulation/[folder_name]/`
**Date Created:** [Insert Date]

## 1. Design (set in `main.R`)

* **n_subjects:** [ ]
* **n_trials:** [ ]
* **n_sessions:** [ ]
* **Population location (`mu_*`):** [parameter = value, …]
* **Population scale (`sigma_*`):** [parameter = value, …]
* **Unit-interval transforms:** [e.g. `alpha = plogis(logit_alpha)`; or none]
* **Sampler:** [Stan / brms / other; chains, warmup, sampling iterations]

## 2. Generating true parameters

* How agent-level values were drawn from the population values above.
* Artifacts: `true_population.rds`, `true_parameters.rds`
* Dot-histogram figures of the drawn parameters.

## 3. Generating data

* Generating definition loaded from `models/[generative_model]/`
* Artifacts: `simulated_data.rds`

## 4. Recovering parameters

* Fitting definition: `[.stan path | brms formula]`
* Artifacts: `[fit].rds`, `draws_pop.rds`, `draws_sbj.rds`, `recovered_parameters.rds`

## 5. Findings / Summary

* (Leave this section blank until the model is fitted and the Word/PDF report has been inspected.)
* Required deliverables in `output/`: the formatted `.docx` (narrative, embedded figures, APA captions) and the standalone multi-page vector PDF (Figures 1–3, one per page).

## 6. Manuscript excerpt — example 1

[Placeholder. After the researcher runs the pipeline, a short publication-ready paragraph describing the recovery *design*: sample size, generative population distributions, and any logistic transform onto the unit interval.]

## 7. Manuscript excerpt — example 2

[Placeholder. After the researcher runs the pipeline, a short publication-ready paragraph reporting the recovery *result*: population-parameter coverage and agent-level Pearson *r* / bias / precision, in manuscript prose.]
