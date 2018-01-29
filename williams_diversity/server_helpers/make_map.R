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
      label = ~ as.character(Building),
      radius = ~ total ^ (1 / 2) * 2,
      color = ~ pal(pval),
      opacity = 0.7
    )
}