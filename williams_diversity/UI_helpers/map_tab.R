#' Function to get map tab
#' @return a tabPanel object with interactive map to display social graph with
#'         probabilities of "clustering" across demographics like race, athelete-status,
#'         majors, etc.
getMapTab <- function()
{
  tabPanel(
    "Interactive map",
    id = "interactive",
    includeCSS("introjs.css"),
    includeScript("intro.js"),
    includeScript("apptour.js"),
    
    div(
      class = "outer",
      
      tags$head(# Include our custom CSS
        includeCSS("styles.css"),
          includeCSS("main.css"),
          includeScript("parallaxImg.js"),
          includeScript("scroll.js")
        ),
      
      
      # introBox(
      #
      #   data.step = 1,
      #   data.intro = "This is the title panel"
      # ),
      
      div(
        `data-step` = "1",
        `data-intro` = "<center><h3>Welcome to the Interactive Map of Williams College Housing!</h3></center>
        <br>
        Take this tour for a quick overview of all the functionality.",
        `data-position` = 'bottom',
        style = 'margin-left: 50px; margin-right: 50px;'
      ),
      
      leafletOutput("map", width = "100%", height = "100%"),
      
      
      absolutePanel(
        id = "controls",
        class = "panel panel-default",
        fixed = FALSE,
        draggable = TRUE,
        top = 20,
        left = "auto",
        right = 20,
        bottom = "auto",
        width = 300,
        height = 800,
        style = 'max-height: 740px',
        div(
          `data-step` = "2",
          `data-intro` = "<center><h3>Statistics</h3></center>
          View information about the proportional representation in a building by <b>hovering</b> over it.",
          `data-position` = 'left'
        ),
        p(div("Proportions by:",
              style = "font-size:24px;")),
        div(
          `data-step` = "3",
          `data-intro` = "<center><h3>Select Category</h3></center>
          Choose between racial/ethnic representation or atheltic representation.",
          `data-position` = 'left'
        ),
        div(
          radioGroupButtons(
            "categorizer",
            label = NULL,
            c("Race", "Sports"),
            # ,"Major"
            selected = "Race",
            status = "default",
            size = "normal",
            direction = "horizontal",
            justified = TRUE,
            individual = TRUE
          ),
          align = "center"
        ),
        div(
          `data-step` = "4",
          `data-intro` = "<center><h3>Donut Chart</h3></center>
          Check out the <b>percentage representation</b> of each group in a building.",
          `data-position` = 'left'
        ),
        div(id = "c", plotlyOutput("pie", height = 350)),
        div(
          `data-step` = "5",
          `data-intro` = "<center><h3>Hypothesis Testing</h3></center>
          We use a proportion test to calculate how likely is such a composition
          to occur by chance.
          <br>
          <b>In other words, if you lined up everyone in the school and filled up the
          house by picking randomly, how often would you see this composition?</b>",
          `data-position` = 'left'
        ),
        div(
          `data-step` = "6",
          `data-intro` = "<center><h3>Hypothesis Testing</h3></center>
          <b>Likely:</b> Happens regularly.
          <br>
          <b>Unlikely:</b> Happens at most once in <u>3 years</u>.
          <br>
          <b>Very Unlikely:</b> Happens at most once in <u>10 years</u>.
          <br>
          <b>Super Unlikely:</b> Happens at most once in <u>20 years</u>",
          `data-position` = 'left'
        ),
        div(id = "d", plotlyOutput("chi", height = 200))
      ),
      
      tags$div(
        id = "cite",
        tags$em(
          'Data compiled for a study on proportional representation at Williams College.'
        ),
        'Gabriella Carmona, Connor Dunn, Arjun Kakkar, Karan Tiberwal and Tarun Yadav'
      )
        )
        )
}