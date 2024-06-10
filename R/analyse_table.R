analyse_table <- function(WIF_data){
  lm_conc <- lm(gene_expression ~ conc, WIF_data)
  lm_conc_cell_line <- lm(gene_expression ~ conc + cell_line + cell_line*conc, WIF_data)
  lm_conc_treatment <- lm(gene_expression ~ conc + treatment + treatment*conc, WIF_data)
  lm_conc_case <- lm(gene_expression ~ conc + case + case*conc, WIF_data)
  avo_totalGroup <- aov(gene_expression ~ .-conc -case, WIF_data)
  avo_treatment_cell_line <- aov(gene_expression ~ treatment + cell_line, WIF_data)

  t1 <- lm_conc|>
    broom::tidy() |>
    gt() |>
    fmt_number() |>
    fmt_scientific(p.value)

  t2 <- avo_totalGroup|> broom::tidy() |> gt() |> fmt_number() |> fmt_scientific(p.value)

  t3 <- avo_treatment_cell_line|> broom::tidy() |> gt() |> fmt_number() |> fmt_scientific(p.value)

  t4 <- lm_conc_cell_line|> broom::tidy() |> gt() |> fmt_number() |> fmt_scientific(p.value)

  t5 <- lm_conc_treatment|> broom::tidy() |> gt() |> fmt_number() |> fmt_scientific(p.value)

  t6 <- lm_conc_case|> broom::tidy() |> gt() |> fmt_number() |> fmt_scientific(p.value)


  list("lm_conc" = t1,
       "avo_totalGroup" = t2,
       "avo_treatment_cell_line" = t3,
       "lm_conc_cell_line" = t4,
       "lm_conc_treatment" = t5,
       "lm_conc_case" = t6
       )
}
