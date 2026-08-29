# Scatter Plot Instructions

## Purpose

Use a scatter plot to show how two measures move together across observations — an observed value
against a predicted one, a true parameter against a recovered one, a measure at test against retest, or
any two variables whose relationship is the question. Build it with **ggplot2**. Colour is required for
this plot type.

## The rules

- **Geom** — `geom_point(alpha = 0.75, size = 2)`, one point per observation.

- **Input** — one data frame carrying an x column and a y column, filtered to complete cases on both.

  *Why:* building the pair as two columns of one data frame makes each row one observation, so the
  pairing holds by construction; when the measures arrive as loose vectors, join them on the
  observation id first. Two vectors of unequal length are recycled by R rather than rejected, so a
  mismatch yields a plausible-looking wrong figure instead of an error — and a length check placed
  after the fact compares two columns that are equal in length by construction and can never fire.

- **Panel shape** — square. On a same-scale pair `coord_equal()` gives the square and one shared data
  unit together; otherwise `theme(aspect.ratio = 1)`.

  *Why:* `coord_equal()` fixes one *data unit* on x to one data unit on y, not one inch of axis to one
  inch of axis. On a same-scale pair — observed vs predicted, parameter recovery, test vs retest — one
  range given to both axes makes the panel square and makes a data unit mean the same thing in both
  directions. On a differently-scaled pair it would map one accuracy point onto one millisecond and
  render a sliver, so the square comes from the aspect ratio and each axis keeps its own range.

- **Axis limits** — same-scale pair: one range computed from both variables, applied to both axes.
  Different scales: each axis takes its own range.

- **Axis ticks** — 3 to 5 per axis, 4 by default, one at each end. The same values on both axes
  whenever the limits are shared.

- **Tick labels** — whole integers where the range allows, otherwise
  `round(seq(lo, hi, length.out = 4), 2)`.

- **Trend line** — `geom_smooth(method = "lm", formula = y ~ x, se = FALSE, linewidth = 0.8)`. Pass
  `se = TRUE` when the user asks for the uncertainty band.

- **Equality line** — `geom_abline(slope = 1, intercept = 0, linetype = "dashed", colour = "grey60",
  linewidth = 0.6)` on a same-scale pair; left off when the two scales differ.

  *Why:* on a same-scale pair a point above the line means y exceeded x, which is the whole content of
  a recovery, observed-vs-predicted, or test–retest figure. On a differently-scaled pair the line
  compares two units with no common meaning and usually falls outside the panel entirely.

- **Correlation label** — Pearson's r in the panel's top-right as `[Pearson r = 0.87]`, anchored at
  `x = Inf, y = Inf` with `hjust = 1.05, vjust = 1.4`, computed on the complete-case data.

  *Why:* the label anchors at the panel's corner, and the `hjust` / `vjust` values just over 1 are what
  pull it back inside from there — which is why they are not exactly 1.

- **Colour** — required for this plot type. One point colour and one line colour from a single pair →
  `../standards/COLOR_STANDARD.md`.

- **Theme** — `theme_minimal(base_size = 13)`, `panel.grid.minor` removed.

- **Labels** — `labs(x = ..., y = ...)`. Add a title, subtitle, or caption when the user asks for one.

- **Export** — PDF and PNG to `output_dir` → `../standards/EXPORT_STANDARD.md`.

## Examples

Each example assumes `df`, a data frame carrying the two columns, already loaded from `artifacts_dir` or
`data_path` per the folder's `rules.md`, and `output_dir` defined by `main.R`. `ggplot2` is loaded in
`main.R`'s `#### SETUP ####`, and the point and line colours are the pair taken from
`../standards/COLOR_STANDARD.md`. This section is the complete example — no `example.R` exists for
this plot type.

### Example 1 — two measures on one scale (parameter recovery)

```r
# reads: artifacts_dir/recovery.rds · writes: output_dir/parameter_recovery_scatter.{pdf,png}

#### PLOT PARAMETER RECOVERY ####

df <- df[complete.cases(df$true_val, df$recovered_val), ]

shared_limits <- range(c(df$true_val, df$recovered_val))
axis_breaks   <- round(seq(shared_limits[1], shared_limits[2], length.out = 4), 2)
pearson_r     <- cor(df$true_val, df$recovered_val, method = "pearson")

p <- ggplot(df, aes(x = true_val, y = recovered_val)) +
  geom_point(colour = "#4477AA", alpha = 0.75, size = 2) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, colour = "#EE6677", linewidth = 0.8) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", colour = "grey60", linewidth = 0.6) +
  annotate("text", x = Inf, y = Inf, label = sprintf("[Pearson r = %.2f]", pearson_r),
           hjust = 1.05, vjust = 1.4, size = 3.5, colour = "grey30") +
  scale_x_continuous(breaks = axis_breaks) +
  scale_y_continuous(breaks = axis_breaks) +
  coord_equal(xlim = shared_limits, ylim = shared_limits, clip = "off") +
  theme_minimal(base_size = 13) +
  theme(panel.grid.minor = element_blank()) +
  labs(x = "True Parameter Value", y = "Recovered Parameter Value")

plot_name <- "parameter_recovery_scatter"

ggsave(file.path(output_dir, paste0(plot_name, ".pdf")), plot = p, width = 10, height = 8, bg = "white")
ggsave(file.path(output_dir, paste0(plot_name, ".png")), plot = p, width = 10, height = 8, dpi = 300, bg = "white")
```

### Example 2 — two measures on different scales (RT against accuracy)

```r
# reads: artifacts_dir/df_subject.rds · writes: output_dir/rt_by_accuracy_scatter.{pdf,png}

#### PLOT RT AGAINST ACCURACY ####

df <- df[complete.cases(df$mean_rt, df$accuracy), ]

x_breaks  <- round(seq(min(df$mean_rt), max(df$mean_rt), length.out = 4), 2)
y_breaks  <- round(seq(min(df$accuracy), max(df$accuracy), length.out = 4), 2)
pearson_r <- cor(df$mean_rt, df$accuracy, method = "pearson")

p <- ggplot(df, aes(x = mean_rt, y = accuracy)) +
  geom_point(colour = "#4477AA", alpha = 0.75, size = 2) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, colour = "#EE6677", linewidth = 0.8) +
  annotate("text", x = Inf, y = Inf, label = sprintf("[Pearson r = %.2f]", pearson_r),
           hjust = 1.05, vjust = 1.4, size = 3.5, colour = "grey30") +
  scale_x_continuous(breaks = x_breaks) +
  scale_y_continuous(breaks = y_breaks) +
  theme_minimal(base_size = 13) +
  theme(aspect.ratio = 1, panel.grid.minor = element_blank()) +
  labs(x = "Mean RT (ms)", y = "Accuracy")

plot_name <- "rt_by_accuracy_scatter"

ggsave(file.path(output_dir, paste0(plot_name, ".pdf")), plot = p, width = 10, height = 8, bg = "white")
ggsave(file.path(output_dir, paste0(plot_name, ".png")), plot = p, width = 10, height = 8, dpi = 300, bg = "white")
```
