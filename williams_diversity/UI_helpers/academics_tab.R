
#' Function to get academics tab
#' @return a tabPanel object studying diversity by academic performance
#' 

alignCenter <- function(el) {
  htmltools::tagAppendAttributes(el,
                                 style="margin-left:auto;margin-right:auto;"
  )
}

getAcademicsTab <- function()
{
  tabPanel("Academic Recognition", 
           
           h2("Diversity in Academic Recognition"),
           
           p( class = "text-muted",
             "The following data visualizations encompass data for ~9000 Williams graduates
             from 2000 onwards. It is derived from archived course catalogs published by the college."),
           
           br(), 
           
           h3("Academic Recognition by Race"),
           
           fluidRow(
             plotOutput(height = 500, "academics_race"),
             alignCenter(sliderInput("grad_race_years", "Select range for graduating year:", min = 2000, max = 2016, 
                                     value = c(2000,2016), sep = "", width = 1000))
           ),
           
           br(), 
           
           h3("Academic Recognition by Gender"),
           
           fluidRow(
                 plotOutput(height = 500, "academics_gender"),
                 alignCenter(sliderInput("grad_gender_years", "Select range for graduating year:", min = 2000, max = 2016, 
                                         value = c(2000,2016), sep = "", width = 1000))
                 )
  )

}
