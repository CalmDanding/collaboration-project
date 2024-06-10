# Load packages required to define the pipeline:
library(targets)
library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("tidyverse", "tidymodels", "textrecipes","readxl","gt","pwr","ggrepel","showtext","lme4","merTools","caret","ggpubr", "glmnet"), # Packages that your targets need for their tasks.
  format = "rds",
)

tar_source()

# Replace the target list below with your own:
list(
  # Data Clean/Generate
  tar_file(WIF_file,"raw-data/2024-3-4-WIF-tis4d.xlsx"),
  tar_target(WIF_data, clean_data(WIF_file)),
  # Analysis
  tar_target(lm_conc, lm(gene_expression ~ conc, WIF_data)),
  tar_target(lm_total, lm(gene_expression ~ conc + cell_line + treatment + cell_line*conc + treatment*conc, WIF_data)),
  tar_target(lm_conc_cell_line, lm(gene_expression ~ conc + cell_line + cell_line*conc, WIF_data)),
  tar_target(lm_conc_treatment, lm(gene_expression ~ conc + treatment + treatment*conc, WIF_data)),
  tar_target(lm_conc_case, lm(gene_expression ~ conc + case + case*conc, WIF_data)),
  tar_target(avo_totalGroup, aov(gene_expression ~ .-conc -case, WIF_data)),
  tar_target(avo_treatment_cell_line, aov(gene_expression ~ treatment + cell_line, WIF_data)),
  #Model
  tar_target(predictive_model, get_predictive_model(WIF_data)),
  #Plots
  tar_target(point_plots, plot_point(WIF_data)),
  tar_target(conference_plot, replot_conference(WIF_data)),
  #Table
  tar_target(analysis_tabs, analyse_table(WIF_data)),
  #Quarto
  tar_quarto(sample_size,"Karl_Sample_Size.qmd"),
  tar_quarto(readme,"README.qmd"),
  tar_quarto(IMRaD_Report,"IMRaD_Report.qmd")

)
