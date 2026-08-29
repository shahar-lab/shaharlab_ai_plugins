# Posterior Plot Instructions

## Purpose

Use a posterior plot to show where a fitted parameter's credible values lie. Build it with **ggdist** —
`stat_slab()` for the distribution's shape and `stat_pointinterval()` for its interval and median point.
The x-axis is the whole point of the figure: it carries the parameter's values. The y-axis carries
nothing a reader needs.

## The rules

- **Geom** — `stat_slab()` for the shape, `stat_pointinterval()` for the interval and median point, as
  two separate layers.

  *Why:* keeping them separate is what lets the interval vary while the slab's fill stays uniform. A
  single `stat_halfeye()` couples them, and the CI then reads as a fill gradient rather than as a line.

- **Canvas** — 10 × 4 inches, overriding `../standards/EXPORT_STANDARD.md`'s 10 × 8 default.

  *Why:* height on this plot is an arbitrary scale that means nothing, so spending canvas on it buys
  the reader nothing; width is where the parameter's values are read. A posterior figure is therefore
  wide and short.

- **X-axis range** — wide enough to show the range the parameter could take, rather than zoomed onto
  where the posterior happens to sit. Three cases:
  - an **effect** posterior — a difference, contrast, slope, or interaction, where the question is
    "different from zero?" — takes a range symmetric about zero:
    ```r
    max_abs <- max(abs(range(draws)))
    coord_cartesian(xlim = c(-max_abs, max_abs))
    ```
  - a parameter with a **bounded** range — a probability, a proportion, a learning rate in `[0, 1]` —
    takes that full bound.
  - anything else takes the draws' range widened 20% at each end:
    ```r
    r    <- range(draws)
    xlim <- c(r[1] - 0.20 * diff(r), r[2] + 0.20 * diff(r))
    ```

  *Why:* the reader judges a parameter against what it could have been. A symmetric range keeps zero
  visually centred, so the axis itself cannot exaggerate or downplay the effect's direction; a bounded
  parameter shown across its whole bound says how much of the possible space the posterior occupies.

- **Zero line** — on an effect posterior,
  `geom_vline(xintercept = 0, linetype = "dashed", colour = "grey40", linewidth = 0.7)`.

- **Credible interval** — one interval at `.width = 0.90`.

- **Median** — the point from `stat_pointinterval()`, plus a thin dashed line at the median:
  `geom_vline(xintercept = median(draws), linetype = "dashed", colour = "grey65", linewidth = 0.4)`.
  Lighter and thinner than the zero line.

- **Annotation** — an effect posterior is labelled `[median = X.XX, pd = XX.XX%]`; any other posterior
  is labelled `[median = X.XX]`. Place it just inside the top of the panel, nudged right of the median
  line. With several distributions, each group is labelled with its own median and pd.

  *Why:* pd — the probability of direction — is the share of the posterior lying on the same side of
  zero as the median, so it only means something when zero is a meaningful reference. On a condition
  mean or a raw parameter it would report a number about nothing.

- **Y-axis** — no line, no ticks, no text, no title:
  ```r
  theme(axis.title.y = element_blank(), axis.text.y = element_blank(),
        axis.ticks.y = element_blank(), axis.line.y  = element_blank())
  ```

  *Why:* the height is a normalized density on an arbitrary scale. Labelling it invites the reader to
  compare heights, which carries no information here.

- **Y limits** — `coord_cartesian(ylim = c(0, 1.3), clip = "off")`.

  *Why:* `stat_slab()` normalizes the slab to a maximum height of 1, and the remaining 0.3 is the
  headroom the median annotation sits in above it.

- **Baseline** — every distribution is drawn at `y = 0`, including when several are shown, so they
  share one horizontal axis rather than being stacked into rows.

- **Slab fill** — one distribution: `fill = "gray80"`. Several: each group's palette colour at
  `alpha = 0.50` for overlap. The fill stays uniform within a distribution and never varies by CI width.

- **X-axis line** — `theme(axis.line.x = element_line(colour = "grey30"))`.

- **Theme** — `theme_minimal(base_size = 13)` with `panel.grid = element_blank()` — no gridlines at all.

- **Legend** — present whenever several distributions are drawn, placed inside the panel's top right:
  ```r
  theme(legend.position = "inside", legend.position.inside = c(1, 0.95),
        legend.justification = c("right", "top"),
        legend.background = element_blank(), legend.key = element_blank())
  ```

- **Labels** — `labs(x = ...)`, plus `labs(fill = NULL)` to drop a legend title. Add a title, subtitle,
  or caption when the user asks for one.

- **Panels** — assemble with patchwork and tag `A`, `B`, `C` via
  `plot_annotation(tag_levels = "A")` → `../standards/PANEL_TAGGING_STANDARD.md`.

- **Colour** — required whenever several distributions are drawn; optional for a single one and used
  only on request → `../standards/COLOR_STANDARD.md`.

- **Export** — PDF and PNG to `output_dir` at 10 × 4 → `../standards/EXPORT_STANDARD.md`.

## Examples

Each example assumes its draws already loaded from `artifacts_dir` per the folder's `rules.md`, and
`output_dir` defined by `main.R`. `ggplot2`, `ggdist`, `dplyr`, and — for Example 3 — `patchwork` are
loaded in `main.R`'s `#### SETUP ####`. This section is the complete example — no `example.R` exists
for this plot type.

### Example 1 — one effect posterior

```r
# reads: artifacts_dir/draws_effect.rds · writes: output_dir/posterior_effect.{pdf,png}

#### PLOT POSTERIOR EFFECT ####

df <- data.frame(theta = draws)

med_val <- median(draws)
pd_val  <- max(mean(draws > 0), mean(draws < 0)) * 100
max_abs <- max(abs(range(draws)))

p <- ggplot(df, aes(x = theta, y = 0)) +
  stat_slab(fill = "gray80") +
  stat_pointinterval(.width = 0.90, point_size = 3) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey40", linewidth = 0.7) +
  geom_vline(xintercept = med_val, linetype = "dashed", colour = "grey65", linewidth = 0.4) +
  annotate("text", x = med_val, y = Inf,
           label = sprintf("[median = %.2f, pd = %.2f%%]", med_val, pd_val),
           hjust = -0.05, vjust = 1.4, size = 3.2, colour = "grey40") +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid   = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank(),
    axis.line.y  = element_blank(),
    axis.line.x  = element_line(colour = "grey30")
  ) +
  labs(x = "Effect Size") +
  coord_cartesian(xlim = c(-max_abs, max_abs), ylim = c(0, 1.3), clip = "off")

plot_name <- "posterior_effect"

ggsave(file.path(output_dir, paste0(plot_name, ".pdf")), plot = p, width = 10, height = 4, bg = "white")
ggsave(file.path(output_dir, paste0(plot_name, ".png")), plot = p, width = 10, height = 4, dpi = 300, bg = "white")
```

### Example 2 — several posteriors on one axis

```r
# reads: artifacts_dir/draws_by_group.rds · writes: output_dir/posterior_by_group.{pdf,png}

#### PLOT POSTERIORS BY GROUP ####

# df carries one row per draw, with columns theta and group

pal <- c("Group A" = "#4477AA", "Group B" = "#EE6677")

group_stats <- df |>
  group_by(group) |>
  summarise(
    med = median(theta),
    pd  = max(mean(theta > 0), mean(theta < 0)) * 100,
    .groups = "drop"
  ) |>
  mutate(label = sprintf("%s: [median = %.2f, pd = %.2f%%]", group, med, pd))

max_abs <- max(abs(range(df$theta)))

p <- ggplot(df, aes(x = theta, y = 0, fill = group, colour = group)) +
  stat_slab(alpha = 0.50) +
  stat_pointinterval(.width = 0.90, point_size = 3) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey40", linewidth = 0.7) +
  geom_vline(data = group_stats, aes(xintercept = med, colour = group),
             linetype = "dashed", linewidth = 0.4, show.legend = FALSE) +
  geom_text(data = group_stats,
            aes(x = med, y = Inf, label = label, colour = group),
            hjust = -0.05, vjust = seq(1.4, by = 1.4, length.out = nrow(group_stats)),
            size = 3.2, show.legend = FALSE) +
  scale_fill_manual(values = pal, guide = guide_legend(override.aes = list(alpha = 0.7))) +
  scale_colour_manual(values = pal, guide = "none") +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid             = element_blank(),
    axis.title.y           = element_blank(),
    axis.text.y            = element_blank(),
    axis.ticks.y           = element_blank(),
    axis.line.y            = element_blank(),
    axis.line.x            = element_line(colour = "grey30"),
    legend.position        = "inside",
    legend.position.inside = c(1, 0.95),
    legend.justification   = c("right", "top"),
    legend.background      = element_blank(),
    legend.key             = element_blank()
  ) +
  labs(x = "Estimate", fill = NULL) +
  coord_cartesian(xlim = c(-max_abs, max_abs), ylim = c(0, 1.3), clip = "off")

plot_name <- "posterior_by_group"

ggsave(file.path(output_dir, paste0(plot_name, ".pdf")), plot = p, width = 10, height = 4, bg = "white")
ggsave(file.path(output_dir, paste0(plot_name, ".png")), plot = p, width = 10, height = 4, dpi = 300, bg = "white")
```

### Example 3 — two panels: condition means, then their difference

This is the figure `plot-posterior.png` alongside this file renders. Panel A shows two condition means, which are
non-effect posteriors — no zero line, and labelled with the median alone. Panel B shows their
difference, which is an effect posterior — symmetric about zero, with the zero line and pd.

```r
# reads: artifacts_dir/draws_conditions.rds · writes: output_dir/posterior_conditions.{pdf,png}

#### PLOT CONDITION MEANS AND THEIR DIFFERENCE ####

# df_means carries columns theta and condition; draws_diff is a numeric vector

pal <- c("Condition A" = "#4477AA", "Condition B" = "#EE6677")

mean_stats <- df_means |>
  group_by(condition) |>
  summarise(med = median(theta), .groups = "drop") |>
  mutate(label = sprintf("%s: [median = %.2f]", condition, med))

r         <- range(df_means$theta)
means_lim <- c(r[1] - 0.20 * diff(r), r[2] + 0.20 * diff(r))

panel_a <- ggplot(df_means, aes(x = theta, y = 0, fill = condition, colour = condition)) +
  stat_slab(alpha = 0.50) +
  stat_pointinterval(.width = 0.90, point_size = 3) +
  geom_text(data = mean_stats,
            aes(x = med, y = Inf, label = label, colour = condition),
            hjust = -0.05, vjust = seq(1.4, by = 1.4, length.out = nrow(mean_stats)),
            size = 3.2, show.legend = FALSE) +
  scale_fill_manual(values = pal, guide = guide_legend(override.aes = list(alpha = 0.7))) +
  scale_colour_manual(values = pal, guide = "none") +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid             = element_blank(),
    axis.title.y           = element_blank(),
    axis.text.y            = element_blank(),
    axis.ticks.y           = element_blank(),
    axis.line.y            = element_blank(),
    axis.line.x            = element_line(colour = "grey30"),
    legend.position        = "inside",
    legend.position.inside = c(1, 0.95),
    legend.justification   = c("right", "top"),
    legend.background      = element_blank(),
    legend.key             = element_blank()
  ) +
  labs(x = "Condition Mean", fill = NULL) +
  coord_cartesian(xlim = means_lim, ylim = c(0, 1.3), clip = "off")

df_diff  <- data.frame(theta = draws_diff)
med_diff <- median(draws_diff)
pd_diff  <- max(mean(draws_diff > 0), mean(draws_diff < 0)) * 100
max_abs  <- max(abs(range(draws_diff)))

panel_b <- ggplot(df_diff, aes(x = theta, y = 0)) +
  stat_slab(fill = "gray80") +
  stat_pointinterval(.width = 0.90, point_size = 3) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey40", linewidth = 0.7) +
  geom_vline(xintercept = med_diff, linetype = "dashed", colour = "grey65", linewidth = 0.4) +
  annotate("text", x = med_diff, y = Inf,
           label = sprintf("[median = %.2f, pd = %.2f%%]", med_diff, pd_diff),
           hjust = -0.05, vjust = 1.4, size = 3.2, colour = "grey40") +
  theme_minimal(base_size = 13) +
  theme(
    panel.grid   = element_blank(),
    axis.title.y = element_blank(),
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank(),
    axis.line.y  = element_blank(),
    axis.line.x  = element_line(colour = "grey30")
  ) +
  labs(x = "Difference (B − A)") +
  coord_cartesian(xlim = c(-max_abs, max_abs), ylim = c(0, 1.3), clip = "off")

p_final <- (panel_a / panel_b) +
  plot_annotation(tag_levels = "A") &
  theme(plot.tag = element_text(face = "bold", size = 14))

plot_name <- "posterior_conditions"

ggsave(file.path(output_dir, paste0(plot_name, ".pdf")), plot = p_final, width = 10, height = 8, bg = "white")
ggsave(file.path(output_dir, paste0(plot_name, ".png")), plot = p_final, width = 10, height = 8, dpi = 300, bg = "white")
```
