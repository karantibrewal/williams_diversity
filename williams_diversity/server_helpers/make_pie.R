make_pie <- function(data, selector)
{
  plot_data = data[[1]]
  total = data[[2]]
  if (is.null(selector)) {
    x <- total[1, 1:4]
    x <-
      data.frame("Categories" = colnames(x), "Count" = as.numeric(x))
    name = "the College"
  } else{
    data = plot_data[which(plot_data$lat == selector), ]
    x <- data[1, 2:5]
    x <-
      data.frame("Categories" = colnames(x), "Count" = as.numeric(x))
    name = data[1, 1]
  }
  p <-
    plot_ly(
      x,
      label = ~ Categories,
      values = ~ Count,
      type = "pie",
      labels = c("Asian", "Hispanic", "Black", "White and Other"),
      textposition = "inside",
      textinfo = "label+percent+count",
      hoverinfo = "text",
      text = ~ paste0("Raw count: ", Count)
    ) %>%
    layout(
      title = paste0('Ethinic/Racial Composition<br>of ', name),
      margin = list(
        l = 0,
        r = 0,
        b = 0,
        t = 60
      )
    )
}