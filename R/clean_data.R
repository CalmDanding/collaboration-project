clean_data <- function(WIF_file){
  WIF_df <- read_excel(WIF_file)
  for (i in 1:88){
    for (j in 1:3){
      WIF_df[i, j] <- str_to_title(WIF_df[i, j])
    }
  }
  WIF_df$case = paste(WIF_df$cell_line, WIF_df$treatment, sep="&")
  # Save data
  writexl::write_xlsx(WIF_df,here::here("data/WIF-tis4d-cleaned.xlsx"))
  return(WIF_df)
}


