
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(ggplot2)
source("server_helpers/processRosters.R")
source("getAcademicsGenderPlot.R")

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
# ----------------------------------------------------------------------------------------------------------------------------

#' (4) read in graduates academic performance from "data/graduates_details.RData" 
#' @description data set describing academic performance by race/gender from 2000-2016
#' \describe{
#' \item{year}{numeric, year of graduation}
#' \item{first.name}{character, first name of graduate}
#' \item{last.name}{character, last name of graduate}
#' \item{latin.honors}{character, Latin Honors recieved by graduate (if any)}
#' \item{Phi.Beta.Kappa}{lgical, indicates Phi Beta Kappa membership}
#' \item{Sigma.Xi}{lgical, indicates Sigma Xi membership}
#' \item{honor}{character, first department honor awarded, if any.}
#' \item{major}{character, academic field in which graduate won primary honor.}
#' \item{gender}{character, based on \code{first.name}, using the gender package.}
#' \item{race}{character, based on \code{last.name}, using the wru package.}
#' }}

graduates <- load("data/graduates_details.RData")


#' (5) read in graduates data for the gender plot
#' @description 

graduates <- load("data/grad_gender_plot_dat.RData")


########################################################### PROCESS DATA   ###############################################################

# -------------------------------------------------MAP DATA ------------------------------------------------------------------------

## get processed data for social map 
map_data <- processRosters(building_rosters, locations)


shinyServer(function(input, output) {
  output$academics_gender <- renderPlot({
    getAcademicsGenderPlot(grad_gender_plot_dat)
  })

})
