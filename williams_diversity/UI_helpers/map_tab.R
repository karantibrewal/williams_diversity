#' Function to get map tab
#' @return a tabPanel object with interactive map to display social graph with 
#'         probabilities of "clustering" across demographics like race, athelete-status, 
#'         majors, etc. 
getMapTab <- function()
{
  tabPanel(
    "Interactive map",
    div(
      class = "outer",
      
      tags$head(# Include our custom CSS
        includeCSS("styles.css"),
        includeScript("gomap.js")),
      
      # If not using custom CSS, set height of leafletOutput to a number instead of percent
      leafletOutput("map", width = "100%", height = "100%"),
      
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                    draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                    width = 330, height = "auto", style = 'opacity: 0.85',
                    h3("Proportions by:"),
                    div(radioGroupButtons("selection", 
                                         label = NULL, 
                                         c("Race", "Sports", "Major"), 
                                         selected = "Race",
                                         status = "primary", 
                                         size = "lg", 
                                         direction = "horizontal",
                                         justified = TRUE, 
                                         individual = TRUE),
                        align = "center"),
                    plotlyOutput("pie", height = 350),
                    plotlyOutput("chi", height = 200)
      ),
      
      tags$div(
        id = "cite",
        tags$em(
          'Data compiled for a study on proportional representation at Williams College.'
        ),
        'Gabriella Carmona, Arjun Kakkar, Karan Tiberwal and Tarun Yadav'
        )
    )
    )
}