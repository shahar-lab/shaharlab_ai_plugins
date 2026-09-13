# Shahar Lab Export Standard for All Figures

## Mandatory Dual-Format Export

Every figure must be saved in BOTH PDF and PNG. No exceptions.

### Defaults (Apply unless user requests otherwise)

- **Width:** 10 inches
- **Height:** 8 inches
- **DPI (PNG only):** 300
- **Background:** white
- **Location:** output_dir/

## Code Template

### Single plot export
```r
plot_name <- "04_posterior_effect"

ggsave(
  file.path(output_dir, paste0(plot_name, ".pdf")),
  plot = p,
  width = 10, height = 8, bg = "white"
)

ggsave(
  file.path(output_dir, paste0(plot_name, ".png")),
  plot = p,
  width = 10, height = 8, dpi = 300, bg = "white"
)
```

### Multi-panel export (with tagging)
```r
p_final <- (p1 | p2) / p3 +
  plot_annotation(tag_levels = 'A') &
  theme(plot.tag = element_text(face = "bold", size = 14))

plot_name <- "04_composite_results"

ggsave(
  file.path(output_dir, paste0(plot_name, ".pdf")),
  plot = p_final,
  width = 10, height = 8, bg = "white"
)

ggsave(
  file.path(output_dir, paste0(plot_name, ".png")),
  plot = p_final,
  width = 10, height = 8, dpi = 300, bg = "white"
)
```

## File Naming Convention

- Prefix with the two-digit `source()` number of the writing script, then a descriptive snake_case stem: `04_posterior_effect.pdf`
- Both PDF and PNG share the same basename (only extension differs)

## Post-Export Checklist

- [ ] Both .pdf and .png files exist in output_dir/?
- [ ] File sizes are reasonable (not empty, not >10MB)?
- [ ] PNG displays correctly at 300 DPI?
- [ ] PDF is vector-based (can zoom without artifacts)?
- [ ] Multi-panel figure shows panel letters (A, B, C)?
- [ ] All text is readable at manuscript size (10-12pt)?

## When Not to Use These Defaults

- **Width/Height:** Modify only if the user explicitly requests "wider" or "smaller", or if a plot
  type's own instructions state a canvas — `plot-posterior.md` sets 10 × 4 in, because
  height there carries no information and the default 10 × 8 wastes it.
- **DPI:** keep at 300, the publication standard
- **Background:** keep white, the lab standard
- **Format:** export both PDF and PNG, every time
