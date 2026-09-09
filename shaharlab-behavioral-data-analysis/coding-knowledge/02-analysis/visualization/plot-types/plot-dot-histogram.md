# Dot Histogram Plot Instructions

## Purpose

Use a dot histogram to show the distribution of one continuous variable as individual observations
rather than as summary bars or a smoothed density. Build it with **ggdist**'s `geom_dots()`, where each
dot is one observation stacked within its bin — the lab's standard package for distributional plots.
The stacking is what shows the scatter directly.

## The rules

- **Geom** — `geom_dots(layout = "bin")`, Wilkinson stacking with rows and columns aligned. Add it
  first, so `ggplot_build(p)$data[[1]]` is the dots layer.

- **Bin width** — `binwidth = NA`, which auto-fits the tallest stack. Pass an explicit width when the
  specification states one.

- **Layers** — the dots alone. Add a density or fitted curve when the user asks for one.

- **X-axis range** — the variable's theoretical range when one applies; otherwise `range(df$x)` widened
  10% at each end. Apply it with `coord_cartesian(xlim = full_range, clip = "off")`.

  *Why:* a dot histogram answers where the data sits within what was *possible*, not only where it
  happens to fall — ratings clustered at 4 and 5 mean one thing on a 1–7 scale and another on a 1–100
  one. A theoretical range is any bound the variable's definition carries: a scale's endpoints, a
  proportion's `[0, 1]`, a reaction time's floor at 0. With none, widen the observed span so the
  outermost dots sit inside the panel rather than on its edge:

  ```r
  r          <- range(df$x)
  full_range <- c(r[1] - 0.10 * diff(r), r[2] + 0.10 * diff(r))
  ```

- **X-axis ticks** — 4 or 5, one at each end. Whole integers where the range allows, otherwise two
  decimals.

- **Y-axis** — `name = "Count"`, with breaks in panel units and labels in counts, both read from the
  built plot.

  *Why:* `geom_dots()` stacks in normalized panel units rather than at count heights, so an axis handed
  count values as breaks places every one of them outside the data range and draws none.
  `ggplot_build()` returns one row per dot carrying a `bin` id, so the largest count per `bin` is the
  tallest stack, and `max(built$y)` is the centre of that stack's topmost dot. Reading the extent from
  the build rather than assuming ggdist's internal scaling constant keeps the mapping right if that
  constant moves. The top label therefore sits half a dot below the crown, and default axis expansion
  keeps the crown in the panel.

- **Colour** — `fill = "gray50"`, `colour = "gray30"`. A grouping variable makes colour mandatory →
  `../standards/COLOR_STANDARD.md`.

- **Theme** — `theme_minimal(base_size = 13)`, `panel.grid.minor` removed.

- **Labels** — `labs(x = ...)`. Add a title, subtitle, or caption when the user asks for one.

- **Export** — PDF and PNG to `output_dir` → `../standards/EXPORT_STANDARD.md`.

## Examples

Each example assumes `df`, a data frame with a numeric column `x`, already loaded from `artifacts_dir`
or `data_path` per the folder's `rules.md`, and `output_dir` defined by `main.R`. `ggplot2`, `ggdist`,
and `dplyr` are loaded in `main.R`'s `#### SETUP ####`. This section is the complete example — no
`example.R` exists for this plot type.

### Example 1 — one continuous variable

```r
# reads: <artifacts_dir or data_path>/<file> · writes: output_dir/descriptive_name_dot_histogram.{pdf,png}

#### PLOT DOT HISTOGRAM ####

# X-axis: the full plausible range
full_range  <- c(1, 7)
axis_breaks <- round(seq(full_range[1], full_range[2], length.out = 4), 2)

# Dots
p <- ggplot(df, aes(x = x)) +
  geom_dots(layout = "bin", binwidth = NA, fill = "gray50", colour = "gray30") +
  scale_x_continuous(breaks = axis_breaks) +
  coord_cartesian(xlim = full_range, clip = "off") +
  theme_minimal(base_size = 13) +
  theme(panel.grid.minor = element_blank()) +
  labs(x = "X label")

# Y-axis: count, fully visible
built       <- ggplot_build(p)$data[[1]]
max_count   <- built |> count(bin) |> pull(n) |> max()
tick_counts <- round(seq(0, max_count, length.out = 4))

p <- p + scale_y_continuous(
  name   = "Count",
  breaks = seq(0, max(built$y), length.out = 4),
  labels = tick_counts
)

# Export
plot_name <- "descriptive_name_dot_histogram"

ggsave(file.path(output_dir, paste0(plot_name, ".pdf")), plot = p, width = 10, height = 8, bg = "white")
ggsave(file.path(output_dir, paste0(plot_name, ".png")), plot = p, width = 10, height = 8, dpi = 300, bg = "white")
```
