make_pie <- function(input_data, selector, categorizer)
{
  if(categorizer == "Race"){
    plot_data = input_data[[1]]
    total = input_data[[2]]
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
        marker = list(colors = c("#4A8DB5","#F47AB0","#FFFD8D","#FFC13B")),
        labels = c("Asian", "Black", "Hispanic", "White and Other"),
        textposition = "inside",
        textinfo = "label+percent+count",
        hoverinfo = "text",
        text = ~ paste0("Raw count: ", Count)
      ) %>%
      add_pie(hole = 0.45)%>%
      layout(
        title = paste0('Ethinic/Racial Composition<br>of ', name),
        margin = list(
          l = 0,
          r = 0,
          b = 0,
          t = 40
        )
      )
  }else{
    plot_data = input_data[[1]]
    total = input_data[[2]]
    if (is.null(selector)) {
      x <- total[1:31]
      x <-
        data.frame("Categories" = names(x), "Count" = x, row.names = 1:31)
      name = "the College"
    } else{
      data = plot_data[which(plot_data$lat == selector), ]
      x <- data[1, 2:32]
      x <-
        data.frame("Categories" = colnames(x), "Count" = as.numeric(x))
      name = data[1, 1]
    }
    p <-
      plot_ly(
        x,
        label = ~ Categories,
        values = ~ Count,
        labels = ~ Categories,
        textposition = "inside",
        textinfo = "label+percent+count",
        hoverinfo = "text",
        text = ~ paste0("Raw count: ", Count)
      ) %>%
      add_pie(hole = 0.45)%>%
      layout(
        title = paste0('Athletic Representation<br>in ', name),
        margin = list(
          l = 0,
          r = 0,
          b = 0,
          t = 40
        )
      )
  }
  
}