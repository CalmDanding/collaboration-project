# Generate data
tar_make()
tar_load(point_plots)
tar_load(analysis_tabs)
tar_load(conference_plot)

# Packages
p_load(ggplot2)

# Save plots
ggsave(
  filename = here::here("figs", "conference_plot.tiff"),
  plot = conference_plot,
  width = 9,
  height = 6
)

ggsave(
  filename = here::here("figs", "GroupByTreatment.png"),
  plot = point_plots$GroupByTreatment
)

ggsave(
  filename = here::here("figs", "GroupByCell_line.png"),
  plot = point_plots$GroupByCell_line
)

ggsave(
  filename = here::here("figs", "GroupByName.png"),
  plot = point_plots$GroupByName
)

ggsave(
  filename = here::here("figs", "GroupByCase.png"),
  plot = point_plots$GroupByCase
)

# Save tables

gtsave(analysis_tabs$lm_conc, filename = here::here("tabs", "lm_conc.png"))
gtsave(analysis_tabs$avo_totalGroup, filename = here::here("tabs", "avo_totalGroup.png"))
gtsave(analysis_tabs$avo_treatment_cell_line, filename = here::here("tabs", "avo_treatment_cell_line.png"))
gtsave(analysis_tabs$lm_conc_cell_line, filename = here::here("tabs", "lm_conc_cell_line.png"))
gtsave(analysis_tabs$lm_conc_treatment, filename = here::here("tabs", "lm_conc_treatment.png"))
gtsave(analysis_tabs$lm_conc_case, filename = here::here("tabs", "lm_conc_case.png"))
