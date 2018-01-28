make_map <- function(data)
{
  
  data = data[[1]]
  
  pal <- colorBin(
    palette = "RdYlGn",
    domain = data$pval,
    bins = c(0, 0.05, 0.1, 0.3, 1)
  )
  
  leaflet(data = data) %>%
    addTiles() %>%
    setView(-73.20554, 42.71343, zoom = 16) %>%
    addCircles(
      ~ long,
      ~ lat,
      popup = ~ paste(
        paste0("<b>Ethinic/Racial Composition</b>"),
        paste0(
          "Percent White and Other: ",
          formatC(100 * p_whi / total, digits = 3),
          "%"
        ),
        paste0(
          "Percent Black: ",
          formatC(100 * p_bla / total, digits = 3),
          "%"
        ),
        paste0(
          "Percent Hispanic: ",
          formatC(100 * p_his / total, digits = 3),
          "%"
        ),
        paste0("Percent Asian: ", formatC(100 *
                                            p_asi / total, digits = 3), "%"),
        sep = "<br/>"
      ),
      label = ~ as.character(Building),
      radius = ~ total ^ (1 / 2) * 2,
      color = ~ pal(pval),
      opacity = 0.7
    ) %>%
    addLegend(
      "bottomleft",
      values = ~ pval,
      title = "How likely is this to<br>happen randomly?",
      colors = c("#D7191C", "#FDAE61", "#A6D96A", "#1A9641"),
      labels = c("Super Unlikely", "Very Unlikely", "Unlikely", "Likely")
    )
}