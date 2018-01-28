#' Function to process building rosters
#' @description We aggregate demographics by building and subsequently
#'              join latitude and longitude info
#'              
#' @param bulding_rosters roster information from college data set
#'                        with race info
#' @param locations latitude/longitude information for buildings

processRosters <- function(building_rosters, locations)
{
  library(tidyr)
  ## aggregate race data
  race_data <- building_rosters %>%
               group_by(Building) %>%
               count(predrace) %>%
               spread(predrace, n, fill = 0) %>%
               mutate(total = p_asi + p_bla + p_his + p_whi)
  
  ## join in locations
  processed_data <- left_join(race_data, locations, by = "Building")
}