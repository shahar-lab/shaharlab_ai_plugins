# The `preprocessing/` folder and the `data/` stages it builds

`preprocessing/` holds the code that moves data between stages. `data/` holds the data at the
three stages that code produces. They are described together because neither makes sense alone.

```text
Project_Root/
├── data/
│   ├── collected/    ── 01_converting_data_collected_to_raw.R ─▶  (untouched, exactly as it came off the task)
│   ├── raw/          ── 03_converting_data_raw_to_processed.R ─▶  (collected minus junk columns and non-real rows)
│   └── processed/                                              (raw minus excluded observations)
│
└── preprocessing/
    ├── code/         converting_ · examining_ · summary_ scripts (see "Naming the scripts")
    ├── output/       one Markdown report per examining_ and summary_ script
    └── main.R        sources the scripts in pipeline order
```

## What each data stage means

| Stage | Contains | Shared publicly |
|---|---|---|
| `collected/` | the files exactly as they arrived — read from it, leave it as it is | no |
| `raw/` | `collected` restructured to a tidy standard format with every column properly typed, minus empty/irrelevant columns and non-real rows (researcher test runs) — every real observation still present | yes |
| `processed/` | `raw` after the observation exclusions reported in the manuscript | yes |

The dividing line: `raw/` drops things that were never data. `processed/` drops things that were
data but are excluded by a stated criterion. Every exclusion between `raw/` and `processed/` is a
number that appears in the manuscript.

## Naming the scripts

Every script in `preprocessing/code/` opens with its two-digit position in `main.R`'s order, per
`project-rules.md` §2.II, then one of three kind-prefixes naming the one job that script does:

| Prefix | The script does this | Example | Writes to |
|---|---|---|---|
| `converting_` | moves data from one stage to the next and saves it | `01_converting_data_collected_to_raw.R`, `03_converting_data_raw_to_processed.R` | `data/raw/`, `data/processed/` |
| `examining_` | inspects one data stage and reports what is in it | `02_examining_data_raw.R`, `04_examining_data_processed.R` | `preprocessing/output/` |
| `summary_` | reports for the researcher and for the manuscript | `05_summary_exclusions.R`, `06_summary_manuscript_paragraph.R` | `preprocessing/output/` |

The `01-preprocessing/references/` how-to files name each script by its kind and subject; the number
in front of it comes from where `main.R` sources it.

These three cover the whole of preprocessing. Work that fits none of them is an analysis, so it
belongs in `analysis/[NAME]/` reading from `data/processed/`.

Name the rest of each file after what it acts on, in `snake_case`: the stages a `converting_`
script moves between, the stage an `examining_` script reads, the report a `summary_` script
writes. Each `examining_` and `summary_` script writes one Markdown file to
`preprocessing/output/` carrying its name without the number prefix, so a report and the script that
built it are found from each other.

## How the folder is handled

- `converting_` scripts write to `data/raw/` and `data/processed/`; `data/collected/` is read-only.
- Each stage is rebuilt by rerunning `preprocessing/main.R` — the `data/` folders are outputs, not
  hand-curated stores.
- `analysis/` reads from `data/processed/` by path and copies nothing into its own folders.
  `simulation/` generates its own data instead and reads nothing from `data/`, per
  `04-simulations/rules.md`.
- Every cutoff used in an exclusion is held in a named variable in `main.R`, set from the user's
  approved plan, so the same value drives the filter and the report that quotes it.
- Scripts run in `main.R`'s order and inherit its environment, so a `summary_` script reads the
  named datasets the `converting_` script before it left behind. This is the stated exception to
  `coding-rules.md`'s save-and-reload rule, and it exists so every reported exclusion count is the
  one the filter produced rather than a second measurement of it. Run this folder from `main.R`
  rather than script by script.

## Building it

Create `preprocessing/` once per project: `code/`, `output/`, and a `main.R` adapted from
`template_main.R` beside this file, whose paths point at `preprocessing/code`,
`preprocessing/output`, and the three `data/` stages.

Each kind of script is written from its own `how-to-` file in
`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/01-preprocessing/references/`, one per kind. Where the card
routed no `how-to-` file for a script the job writes, take that file as an `ADDED READ`.
