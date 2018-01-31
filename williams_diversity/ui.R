
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(leaflet)
library(plotly)
library(shinyWidgets)
library(shinycssloaders)
library(rintrojs)
source("UI_helpers/main_tab.R")
source("UI_helpers/map_tab.R")
source("UI_helpers/academics_tab.R")
source("UI_helpers/positions_of_power_tab.R")
source("UI_helpers/data_and_analysis_tab.R")
source("UI_helpers/about_tab.R")
source("UI_helpers/contact_tab.R")

shinyUI(
navbarPage(
  "Diversity at Williams College",
  id = "nav",
  getMainTab(),
  getMapTab(),
  getAcademicsTab(), 
  #getPositionsOfPowerTab(),
  getDataAndAnalysisTab(),
  getContactTab()
  
)
)