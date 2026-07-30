# Blueprint: New Folder (all types)

The single source of truth for lab topology is `folder_structure.md`, plus
`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/00-constitution/project-rules.md` — build from those rather than from
memory of a tree.

## Folder-type routing

Determine what is being scaffolded, then follow the matching section:

| Request | Location | Section | Templates |
|---|---|---|---|
| New analysis | `analysis/[NAME]/` | Analysis / Simulation folder | `assets/template_main.R`, `assets/template_summary.md` |
| New simulation study | `simulation/[NAME]/` | Analysis / Simulation folder (same canonical set, different parent) | same as analysis |
| New model definition | `models/[MODEL_NAME]/` | Model folder | `assets/template_model.R`, `assets/template_model.stan` |
| Preprocessing setup | `preprocessing/` | Preprocessing | `assets/template_main.R` (adapted) |
| Duplicate / clone a folder | same parent as the source | `smart_clone.md` | — |

## Direct Scaffolding (one new canonical folder)

1. **Consult the blueprint** — the matching section below, or `smart_clone.md` for a
   duplication.
2. **Create the topology** for that folder type.
3. **Inject the boilerplate** from `assets/` — `template_main.R` → `main.R`,
   `template_summary.md` → `summary.md`.
4. **Parameterize:**
   - Set the regression formula or model name from the brief in the headers of the new
     `main.R` and `summary.md`.
   - Replace `<parent>` with the real parent (`analysis` or `simulation`) and
     `<folder_name>` with the real folder name, so every `file.path()` construction
     resolves.
   - Set the read path to the confirmed data source (default `data/processed/`).

Path syntax is governed by
`${CLAUDE_PLUGIN_ROOT}/coding-knowledge/00-constitution/coding-rules.md` (path setup section).

Audits, reorganizations, clones, and multi-folder builds run the Gated Workflow in Malka's
`execution-card.md` instead, which reaches these same steps at its Execute
stage.

## Naming

Naming rules apply to every new folder:

* **Naming:** Prompt the user for a name if they didn't provide one. Use `snake_case` (e.g., `model_y_by_x_and_z`).
* **Warning:** No special characters, spaces, or formula notation (`~`, `+`, `|`) in folder names — these break path construction and shell commands.

## Analysis / Simulation folder (identical canonical set)

1. **Location:** `analysis/[NAME]/` for empirical analyses; `simulation/[NAME]/` for simulation studies (e.g. `param_recovery`, `model_sim`).
2. Create the canonical set: `code/`, `artifacts/`, `output/`, `main.R`, `summary.md` (project_rules §3).
3. Inject `assets/template_main.R` as `main.R` and `assets/template_summary.md` as `summary.md`, then parameterize: replace `<parent>` with `analysis` or `simulation`, `<folder_name>` with the actual name, and set headers to the user's model name / formula.

## Model folder

1. **Location:** `models/[MODEL_NAME]/` — one folder per model.
2. Create `[MODEL_NAME].R` (generating code) from `assets/template_model.R` and `[MODEL_NAME].stan` (Stan fitting code) from `assets/template_model.stan`. File names must match the folder name.
3. No `code/`, `artifacts/`, or `output/` here — fitting and evaluation live in `analysis/` or `simulation/` (project_rules §2.III).

## Preprocessing

1. **Location:** top-level `preprocessing/` (there is only one).
2. Create `code/` (unnumbered R scripts) and `main.R` (orchestrator, adapted from `assets/template_main.R`: paths point to `preprocessing/code` and the `data/` stages; it builds `data/raw/` and `data/processed/` from `data/collected/`).