
#' Function to get academics tab
#' @return a tabPanel object studying diversity by academic performance
getAcademicsTab <- function()
{
  tabPanel("Academic Performance", 
           
           h2("Diversity by Academic Performance"),
           
           p( class = "text-muted",
             "The following data visualizations encompass data for ~9000 Williams graduates
             from 2000 onwards. It is derived from archived course catalogs published by the college."),
           
           fluidRow(
                 plotOutput("acedmics_gender"),
                 sliderInput("orders", "Orders", min = 1, max = 2000, value = 650)
                 )
           )
}
