get_predictive_model <- function(WIF_data){
  # Detail shown in the Report
  # Split data into train data and test data
  set.seed(114514)
  WIF_data_modeling <-
    dplyr::select(WIF_data, gene_expression, conc, case)

  WIF_split <- initial_split(WIF_data_modeling, strata = gene_expression)
  WIF_train <- training(WIF_split)
  WIF_test <- testing(WIF_split)
  WIF_cv <- vfold_cv(WIF_train)

  # Modeling
  WIF_recipe <-
    recipe(gene_expression ~ conc + case, data = WIF_train) |>
    step_dummy(all_nominal()) |>
    step_normalize(all_numeric(), -all_outcomes()) |>
    step_interact(terms = ~ conc:case_Cell.Type.101.Placebo) |>
    step_interact(terms = ~ conc:case_Wild.Type.Activating.Factor.42) |>
    step_interact(terms = ~ conc:case_Wild.Type.Placebo)

  WIF_model <- linear_reg(penalty = tune(), mixture = 1) |>
    set_mode("regression") |>
    set_engine("glmnet")

  WIF_wf <- workflow(WIF_recipe, WIF_model)

  # Tune the model
  WIF_grid <- grid_regular(penalty(), levels = 50)

  WIF_tune <- tune_grid(
    WIF_wf,
    resamples = WIF_cv,
    grid = WIF_grid
  )

  # Find best model we get
  penalty <- select_best(WIF_tune, metric = "rmse")


  # Fit final model
  WIF_wf <- WIF_wf |>
    finalize_workflow(penalty)

  WIF_fit <- WIF_wf |> fit(WIF_train)

  Best_model_estimate <- WIF_fit |>
    pull_workflow_fit() |>
    tidy()

  return(Best_model_estimate)
}
