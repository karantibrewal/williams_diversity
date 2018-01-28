make_allbar <- function(data)
{
  plot_data <- data[[1]]
  
  col_data = data.frame(
    Building = rep("College-Wide", 4),
    type = c("Asian", "Hispanic", "Black", "White and Other"),
    value = c(0.2014519, 0.09921355, 0.1113128, 0.5880218)
  )
  
  allbar_data <- plot_data %>%
    mutate(
      Asian = p_asi / total,
      Hispanic = p_his / total,
      Black = p_bla / total,
      `White and Other` = p_whi / total
    ) %>%
    select(1, Asian, Hispanic, Black, `White and Other`) %>%
    gather(type, value, 2:5) %>%
    as.data.frame() %>%
    rbind(col_data)
  
  ggplot(data = allbar_data, aes(x = Building,
                                 group = type,
                                 fill = type)) +
    geom_bar(aes(weight = value)) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    ylab("Proportions") +
    geom_hline(
      aes(yintercept = 0.5880218),
      colour = "#990000",
      linetype = "dashed",
      size = 1
    ) +
    geom_hline(
      aes(yintercept = 0.6872354),
      colour = "#990000",
      linetype = "dashed",
      size = 1
    ) +
    geom_hline(
      aes(yintercept = 0.7985482),
      colour = "#990000",
      linetype = "dashed",
      size = 1
    ) +
    geom_rect(
      aes(
        xmin = 6.5,
        xmax = 7.5,
        ymin = 0,
        ymax = 1
      ),
      colour = "orange",
      alpha = 0,
      size = 1.5
    ) +
    guides(fill = guide_legend(title = "Ethnicity/Race")) +
    ggtitle("Proportions of Ethnic Groups across Campus")
}