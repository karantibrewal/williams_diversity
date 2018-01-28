
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
source("server_helpers/processRosters.R")

############################################## READ IN REQUIRED DATA FRAMES ####################################################

#' (1) read in raw data from "raw_data.csv" 
#' @description 
raw_anon_data <- read.csv("Data/raw_data.csv", header = TRUE,
                          stringsAsFactors = FALSE)

# ----------------------------------------------------------------------------------------------------------------------------

#' (2) read in building rosters from "building_data.csv"
#' @description 

building_rosters <- read.csv("Data/building_data.csv", header = TRUE,
                              stringsAsFactors = FALSE)

# ----------------------------------------------------------------------------------------------------------------------------

#' (3) read in building location data from "building_location.csv"
#' @description  

locations <- read.csv("Data/building_locations.csv", header = TRUE,
             stringsAsFactors = FALSE) %>%
             mutate(lat = as.numeric(lat), long = as.numeric(long)) ## ideally this should be done elsewhere, 
                                                                    ## but leaving here in case it's one-off


########################################################### PROCESS DATA   ###############################################################

# -------------------------------------------------MAP DATA ------------------------------------------------------------------------

## get processed data for social map 
map_data <- processRosters(building_rosters, locations)


shinyServer(function(input, output) {

  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
