plot_point <- function(WIF_data){
  p1 <-
    ggplot(WIF_data, aes(conc, gene_expression, col = treatment))+
    geom_point(size = 2)+
    geom_smooth(method = "lm", se = FALSE) +
    labs(x = "Concentration ", y = "Gene Expression") +
    ggtitle("Group By Treatment")

  p2 <-
    ggplot(WIF_data, aes(conc, gene_expression, col = cell_line))+
    geom_point()+
    geom_smooth(method = "lm", se = FALSE) +
    labs(x = "Concentration ", y = "Gene Expression") +
    ggtitle("Group By Cell_line")

  p3 <-
    ggplot(WIF_data, aes(conc, gene_expression, col = name))+
    geom_point()+
    geom_smooth(method = "lm", se = FALSE) +
    labs(x = "Concentration ", y = "Gene Expression") +
    ggtitle("Group By Name")

  p4 <-
    ggplot(WIF_data, aes(conc, gene_expression, col = case))+
    geom_point()+
    geom_smooth(method = "lm", se = FALSE) +
    labs(x = "Concentration ", y = "Gene Expression") +
    ggtitle("Group By Case")

  return(list("GroupByTreatment" = p1,
              "GroupByCell_line" = p2,
              "GroupByName" = p3,
              "GroupByCase" = p4))
}
