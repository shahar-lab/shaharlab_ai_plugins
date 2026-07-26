---
name: plotting
description: Shahar Lab plotting standards for R/ggplot2 — routes each plot request to the correct reference (plot types, colors, panel tagging, export). Use whenever creating or revising any figure or plot for the lab.
---

# Skill: Shahar Lab Plotting

This file is the only routing table for plotting: it answers "which plot type is this, and which files do I read?" Each file below owns its rules outright — this file cites them and never restates their values.

The skill has two folders, and the split is the fastest way to find a rule:

- **`standards/`** — rules that apply to **every** plot, whatever its type: color, export, panel tagging.
- **`plot-types/`** — one folder per plot type, holding only that type's own rules plus a runnable example.

**Rule values live in exactly one file.** Runnable code examples may of course show a rule in use (an example has to be complete), but if you need to know what the lab's export width or tag style *is*, there is exactly one file to read for it. Do not copy values between files.

## Assumptions (check before writing any code)

This skill is standalone: it knows plotting code, nothing about projects or folders. It assumes the caller has provided:

- A variable `output_dir` (an existing directory) — all `ggsave()` calls target `file.path(output_dir, ...)`
- Libraries loaded: `ggplot2`, `ggdist`, `patchwork`, `tidyverse`
- Data/draws already in scope — plotting is never the data-generation step

If any assumption is unmet, stop and tell the caller what is missing. Do not create directories, load libraries, or invent paths.

## Routing

| User asks for | Plot type | Color | Panel tags | Read |
|---|---|---|---|---|
| "plot the posterior" / "credible interval" / "effect estimate" / "Bayesian estimate" | posterior (single) | optional — gray80 default | none | `plot-types/plot-posterior/instructions.md` + `example.R` |
| the same, for two or more distributions | posterior (multi) | **required** | none | `plot-types/plot-posterior/instructions.md` + `example.R` |
| "scatter" / "x vs y" / "correlation" / "parameter recovery" / "observed vs predicted" | scatter | **required** | none | `plot-types/plot-scatter/instructions.md` + `example.R` |
| "multiple panels" / "composite" / "combine plots" | multi-panel composite | inherited from panels | **required** | `standards/PANEL_TAGGING_STANDARD.md` |

Everything in `standards/` applies to every row above.

## Procedure

1. **Identify the plot type** from the routing table.
2. **Verify the assumptions** above. Stop if any is unmet.
3. **Read the plot type's `instructions.md`** in `plot-types/` and use its `example.R` as your template.
4. **Read `standards/COLOR_STANDARD.md`** if the plot uses color — it owns the "when is color required" rule and every approved palette.
5. **Read `standards/PANEL_TAGGING_STANDARD.md`** if the figure has 2+ panels — it owns the tagging rule, the tag style, and the assembly library.
6. **Write the code**, then export and verify per `standards/EXPORT_STANDARD.md` — it owns the canvas defaults, the dual-format rule, file naming, and the post-export checklist.

## Mandatory rules (never override)

Each rule below is defined in the file cited; read that file for the actual values.

1. **Dual export** — always PDF + PNG → `standards/EXPORT_STANDARD.md`
2. **Canvas defaults** — width, height, DPI, background → `standards/EXPORT_STANDARD.md`
3. **Panel tagging** — required if 2+ panels, in the mandated style → `standards/PANEL_TAGGING_STANDARD.md`
4. **Assembly library** — patchwork only → `standards/PANEL_TAGGING_STANDARD.md`
5. **Colorblind-safe palettes only** → `standards/COLOR_STANDARD.md`
6. **Theme** — `theme_minimal(base_size = 13)` with no gridlines (`panel.grid = element_blank()`). This skill is the home for the two global theme rules; the per-type instructions apply them and may show them in examples.
7. **`output_dir` is mandatory** — every file saves there, never anywhere else (see Assumptions).
8. **No titles, subtitles, or captions** unless the user explicitly asks for one.

## What this skill does NOT cover

- **Folder structure & paths** — the caller defines `output_dir` (see Assumptions)
- **Library loading** — the caller loads libraries before plot code runs
- **Data preparation** — assume data is ready and in scope
- **Directory creation** — never create `output_dir` yourself; it must already exist

## Adding a new plot type

Create `plot-types/plot-<name>/` containing `instructions.md` (prose rules only, no YAML frontmatter — these are reference files, not skills) and a runnable `example.R`, then add one row to the routing table above. Do not add a second routing table anywhere.

A rule that would apply to *every* plot type does not belong in `plot-types/` — put it in the matching `standards/` file, or add a new one and cite it from the mandatory-rules list.
