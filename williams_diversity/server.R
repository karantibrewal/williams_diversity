# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(dplyr)
library(ggplot2)
library(leaflet)
library(RColorBrewer)
library(DT)
library(scales)
library(lattice)
library(plotly)
library(tidyr)
library(shinyWidgets)
library(stringr)
library(shinycssloaders)
library(rintrojs)
library(jsonlite)
source("server_helpers/processRosters.R")
source("server_helpers/processSports.R")
source("server_helpers/getAcademicsGenderPlot.R")
source("server_helpers/getAcademicsRacePlot.R")
source("server_helpers/make_map.R")
source("server_helpers/make_pie.R")
source("server_helpers/make_chi.R")
source("server_helpers/make_allbar.R")

############################################## READ IN REQUIRED DATA FRAMES ####################################################

#' (1) read in raw data from "raw_data.csv"
#' @description
raw_anon_data <- read.csv("data/raw_data.csv",
                          header = TRUE,
                          stringsAsFactors = FALSE)

# ----------------------------------------------------------------------------------------------------------------------------

#' (2) read in building rosters from "building_data.csv"
#' @description

building_rosters <- read.csv("data/building_data.csv",
                             header = TRUE,
                             stringsAsFactors = FALSE)

# ----------------------------------------------------------------------------------------------------------------------------

#' (3) read in building location data from "building_location.csv"
#' @description

locations <- read.csv("data/building_locations.csv",
                      header = TRUE,
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

load("data/graduates_details.RData")


#' (5) read in graduates data for the gender plot
#' @description

grad_plot <- read.csv("data/grad_plot.csv")

#' (5) read in sports data for the map tab
#' @description

sport_data <-
  read.csv("data/sport_data.csv",
           header = TRUE,
           stringsAsFactors = FALSE)


########################################################### PROCESS DATA   ###############################################################

# -------------------------------------------------MAP DATA ------------------------------------------------------------------------

## get processed data for social map
map_data_race <- processRosters(building_rosters, locations)
map_data_sports <- processSports(sport_data, locations)



shinyServer(function(input, output, session) {
  ################################ introduction for the map page ###########################################
  count <- reactiveVal(0)
  observeEvent(input$nav, {
    if (input$nav == "Interactive map") {
      newcount = count() + 1
      count(newcount)
    }
  })
  
  observeEvent(count(), {
    if (count() == 1) {
      session$sendCustomMessage(type = 'startHelp', message = list(""))
    }
  })
  
  ################################ regular server logic ##################################################
  
  output$map <- renderLeaflet({
    if (input$categorizer == "Race") {
      data <- map_data_race
    } else{
      data <- map_data_sports
    }
    make_map(data)
  })
  
  output$pie <- renderPlotly({
    if (input$categorizer == "Race") {
      data <- map_data_race
    } else{
      data <- map_data_sports
    }
    categorizer <- input$categorizer
    selector <- input$map_shape_mouseover$lat
    make_pie(data, selector, categorizer)
  })
  
  output$chi <- renderPlotly({
    if (input$categorizer == "Race") {
      data <- map_data_race
    } else{
      data <- map_data_sports
    }
    categorizer <- input$categorizer
    selector <- input$map_shape_mouseover$lat
    make_chi(data, selector)
  })
  
  output$allbar <- renderPlot({
    make_allbar(map_data_race)
  })
  
  output$raw_data <- DT::renderDataTable({
    datatable(
      raw_anon_data,
      class = 'cell-border stripe',
      filter = "top",
      rownames = FALSE,
      options = list(lengthMenu = c(5, 15, 50, 100, 1000))
    )
  })
  
  output$academics_gender <- renderPlot({
    getAcademicsGenderPlot(grad_plot,
                           input$grad_gender_years[1],
                           input$grad_gender_years[2])
  })
  
  output$academics_race <- renderPlot({
    getAcademicsRacePlot(grad_plot,
                         input$grad_race_years[1],
                         input$grad_race_years[2])
  })
  
})
