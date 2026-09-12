# The Exploration Pass — profiling a `data/` stage

The one-off pass over a `data/` stage that runs **before any pipeline code exists**, inside Malka's
Step 1 and before the approval gate. It produces the profile her interview works from. The examination
that lives *in* the pipeline and reruns with every build is a different thing — that is
`how-to-examine.md`'s `examining_` scripts.

Read this as the Data Explorer. You have a shell and R; run the blocks below over the data at `DATA`
and report what they return.

**Lead with what that interview needs.** `data/collected/` → exclusion distributions first (sections 2–3, then 1, 4–6). `data/processed/` → columns, types, and scored measures first (section 1, then 4; skip 2, 3, and 5 unless the card asked for them).

## What the profile is for

On `collected/`, Malka is about to ask for reserved-set cutoffs — a minimum trial count, RT bounds, a
window-exit limit. **Those distributions come first.** On `processed/`, she is about to ask which
columns a formula or a descriptives table can use. **Those names and types come first.**

## 1 · Load and size

```r
df <- readRDS("<path>")            # or read.csv / read_csv, by what is there
dim(df); names(df); str(df)
```

Report the row and column counts, every column name, and the class of each.

## 2 · The distributions the interview needs

`collected/` only, unless the card says otherwise. Work out which column identifies a participant,
which identifies a trial, and which carries a response time. Then report, for each, the shape a cutoff
would be set against.

```r
trials_per_subject <- table(df$subject)
quantile(trials_per_subject, c(0, .01, .05, .10, .25, .50, 1))
sort(trials_per_subject)[1:15]                     # the tail a cutoff would remove

quantile(df$rt, c(0, .001, .01, .05, .5, .95, .99, .999, 1), na.rm = TRUE)
sum(df$rt < 200, na.rm = TRUE); sum(df$rt > 3000, na.rm = TRUE)
```

Give the quantiles and the low tail. Where the column names differ, use the ones that are there and
say which you took for what.

## 3 · Leaving the window, for a study run online

`collected/` only. Where the data carries `window_status`, `window_left_ms`, or rows marked
`event_type == "attention_event"`, profile the exits — the researcher is about to be asked for
`window_exit_max`.

**One exit is a *sequence* of consecutive `left` trials, not one flagged trial.** Count it that way;
`handling-leaving-window.md` states the measure the pipeline then implements.

```r
exits_per_subject <- tapply(df$window_status, df$subject, function(s) sum(rle(s == "left")$values))
quantile(exits_per_subject, c(0, .5, .75, .9, .95, 1))
table(exits_per_subject)
```

Where none of those columns is present, say so — that is what tells Malka to leave the window-exit
question out rather than ask it blind.

## 4 · Missingness

```r
colSums(is.na(df))
colMeans(is.na(df)) * 100
sum(complete.cases(df))
```

Report the count and the percentage per column, and flag any column whose missingness looks
systematic rather than scattered.

## 5 · What would break a conversion

`collected/` only. The `converting_` script that follows is written against what you report here, so
name anything that would make it fail or fail silently:

- a numeric column stored as text — check for `"NA"`, `"NULL"`, `"N/A"`, `"."`, currency symbols,
  thousands separators
- a factor whose levels vary in case or spacing (`"Male"`, `"male"`, `"M"`)
- a date whose format is ambiguous, and which format it appears to be
- duplicated rows, and duplicated participant identifiers
- values outside a possible range for what the column represents
- researcher test runs still present among real participants, and what marks them

```r
sapply(df, function(x) if (is.character(x)) head(unique(x), 12))
sum(duplicated(df)); sum(duplicated(df$subject))
```

## 6 · The report

Return it as text. On `collected/`, use this order:

```
EXPLORATION PROFILE — <path>, <n> rows x <p> columns, R <version>

DISTRIBUTIONS FOR THE EXCLUSION QUESTIONS
trials per participant   n = <k> participants; quantiles 0/1/5/10/25/50/100 = ...
                         the lowest 15: ...
response time            quantiles ...; <n> below 200 ms, <n> above 3000 ms
window exits             <present / absent>; per participant ...

STRUCTURE
<column>  <class>  <unique or range>  <n missing (%)>
...

WOULD BREAK A CONVERSION
<each issue, the column it is in, and how many rows it affects>

NOT MEASURED
<anything the environment or the data prevented, and why>
```

On `processed/`, lead with `STRUCTURE` (every column, class, unique or range, missingness). Omit
`DISTRIBUTIONS FOR THE EXCLUSION QUESTIONS` and `WOULD BREAK A CONVERSION` unless the card asked for
them.

Every line carries a number where a number exists. The `NOT MEASURED` block is what keeps the profile
honest — a missing package, an absent column, an identifier you could not work out.

## Next

Malka takes this profile into Critique, where the researcher sets each cutoff or names each column against what you reported. The Summary Card and the approval gate close Step 1 from there.
