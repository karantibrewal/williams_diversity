make_chi <- function(data, selector)
{
  input_data = data[[1]]
  
  x1 <- seq(0, qchisq(0.7, 3), 0.1)
  x2 <- seq(qchisq(0.7, 3), qchisq(0.9, 3), 0.1)
  x3 <- seq(qchisq(0.9, 3), qchisq(0.95, 3), 0.1)
  x4 <- seq(qchisq(0.95, 3), 15, 0.1)
  x = c(x1, x2, x3, x4)
  y1 <- c(dchisq(x1, 3), rep(0, 114))
  y2 <- c(rep(0, 37), dchisq(x2, 3), rep(0, 88))
  y3 <- c(rep(0, 63), dchisq(x3, 3), rep(0, 72))
  y4 <- c(rep(0, 79), dchisq(x4, 3))
  if (is.null(selector)) {
    y5 <- rep(0, 151)
    a = list()
  } else{
    temp_data = input_data[which(input_data$lat == selector), ]
    pval <- temp_data$pval
    stat <- qchisq(1 - pval, 3)
    y5 <- ifelse(x >= stat, dchisq(x, 3), 0)
    a <- list(
      x = stat,
      y = dchisq(stat, 3),
      text = paste0(
        formatC(pval * 100, digits = 2),
        "% probability of<br>occuring by chance."
      ),
      xref = "x",
      yref = "y",
      showarrow = TRUE,
      arrowhead = 4,
      ax = 30,
      ay = -40
    )
  }
  plot_data <- data.frame(x, y1, y2, y3, y4, y5)
  plot_ly(
    plot_data,
    x = ~ x,
    y = ~ y1,
    type = "scatter",
    mode = "line",
    fill = "tozeroy",
    fillcolor = "#1A9641",
    line = list(color = "#1A9641"),
    autosize = F,
    height = 200,
    width = 300,
    hoverinfo = "none"
  ) %>%
    add_trace(
      y = ~ y2,
      type = "scatter",
      mode = "line",
      fill = "tozeroy",
      fillcolor = "#A6D96A",
      line = list(color = "#A6D96A")
    ) %>%
    add_trace(
      y = ~ y3,
      type = "scatter",
      mode = "line",
      fill = "tozeroy",
      fillcolor = "#FDAE61",
      line = list(color = "#FDAE61")
    ) %>%
    add_trace(
      y = ~ y4,
      type = "scatter",
      mode = "line",
      fill = "tozeroy",
      fillcolor = "#D7191C",
      line = list(color = "#D7191C")
    ) %>%
    add_trace(
      y = ~ y5,
      type = "scatter",
      mode = "line",
      fill = "tozeroy",
      fillcolor = "#A64BC6",
      line = list(color = "#A64BC6")
    ) %>%
    layout(
      showlegend = FALSE,
      xaxis = list(title = "Test Statistic"),
      yaxis = list(title = ""),
      title = "Probability of Random Occurance",
      margin = list(
        l = 20,
        r = 20,
        b = 40,
        t = 50
      ),
      annotations = a
    )
}