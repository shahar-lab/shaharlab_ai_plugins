# Writing a `models/` definition

A `models/[model_name]/` folder holds one model in two directions: `[model_name].R` generates behaviour
from parameters, and `[model_name].stan` estimates parameters from behaviour. `03-models/context.md`
states the folder's shape and its file names; this file is about what goes inside the two files.

Nothing here is fitted or evaluated. A definition is loaded by an `analysis/` folder to fit real data
or by a `simulation/` folder to generate and recover, so it is written to be sourced by path from
somewhere else and to hold no paths, no data loading, and no output of its own.

## The pair has to agree

The two files are the same model written twice, and every recovery study and every fit rests on their
agreeing. `04-simulations/references/how-to-build-a-recovery-pipeline.md` states the three
agreements a recovery result depends on — the population form, the parameter scale, and the choice
rule — and this is the file where you make them true. Write the `.R` and the `.stan` together and
check each agreement as you go, since a mismatch here surfaces as a recovery that fails for reasons
nobody can locate.

State each agreement in a comment where the code makes it true, naming the scale a parameter arrives
on and the distribution it is drawn from. That comment is what the next reader checks the pair against.

## `[model_name].R` — the generating direction

One function, named for the model, taking the population size, how much data each agent contributes,
and the parameters:

```r
generate_<model_name> <- function(n_subjects, n_trials, params) {
  # params arrives as a data frame, one row per agent, one column per parameter
  # returns a long data frame: one row per trial, with the columns the .stan data block reads
}
```

- **Take parameters as an argument; draw nothing inside.** The population is the simulation study's to
  draw, and a definition that samples its own parameters cannot be used for recovery.
- **Return the columns the `.stan` file's `data` block reads**, under the names it reads them by. The
  two files are written against one column vocabulary.
- **Name the scale each parameter arrives on** in a comment, and apply any transform inside the
  function. Where the function expects a learning rate on the probability scale, the caller passes a
  probability; where it expects a logit, it applies `plogis()` itself.
- **Leave `set.seed()` out.** Reproducibility is the calling study's decision, per `coding-rules.md`.

## `[model_name].stan` — the fitting direction

The blocks in order, with the varying structure written non-centred:

- `data` — the observed columns and the sizes. Declare bounds where the data has them
  (`int<lower=1> n_subjects`), so a malformed input fails at load rather than during sampling.
- `parameters` — the population location and scale per parameter, plus the standardised
  agent-level terms.
- `transformed parameters` — the agent-level values built from those: `mu + sigma * raw`, put on the
  scale the likelihood needs. **This is where agreement 2 lives** — the transform here matches what the
  `.R` file applies.
- `model` — priors on the population terms, `std_normal()` on the raw agent-level terms, then the
  likelihood. **Agreement 3 lives here**: the likelihood expresses the same probability as the
  generating choice rule.
- `generated quantities` — the log-likelihood per observation where the study will compare models.

**Write the varying effects non-centred.** Declaring `raw` terms with a `std_normal()` prior and
building the agent-level value in `transformed parameters` samples where the directly-parameterised
form divides, which is the usual cause of divergent transitions in a hierarchical model this size.

**Bound a parameter in its declaration where the model bounds it** — `real<lower=0> sigma`, and a
learning rate declared on the unconstrained scale then transformed rather than declared
`real<lower=0, upper=1>` with a prior fighting the boundary.

## Changing one

Editing these two files changes every folder that loads them, and those folders pick the change up on
their next run — no folder holds a copy. A variant that differs in structure, such as a second learning
rate or a different link, is a new folder under `models/` rather than a branch inside an existing file,
per `03-models/context.md`.

Where a fitted result already exists for the old definition, say so at handback: that fit was produced
by code that no longer exists, and rerunning it is the only way to keep the artifact and the definition
in agreement.
