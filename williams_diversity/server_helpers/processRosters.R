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
  
  ## Compute college-wide counts and proportions 
  total <- ungroup(processed_data) %>%
    summarize(
      asi = sum(p_asi),
      his = sum(p_his),
      bla = sum(p_bla),
      whi = sum(p_whi),
      tot = sum(total)
    ) %>%
    mutate(p_asi = asi / tot,
           p_his = his / tot,
           p_bla = bla / tot,
           p_whi = whi / tot)
  
  ## Conduct the proportion test and store the pvalues for each building
  pval = numeric(nrow(processed_data))
  for (i in 1:nrow(processed_data)) {
    pval[i] <- prop.test(processed_data[i, 2:5],
                         c(processed_data[i, 6], processed_data[i, 6], processed_data[i, 6], processed_data[i, 6]),
                         total[1, 6:9],
                         alternative = "two.sided")$p.value
  }
  
  processed_data$pval = pval
  
  ## Construct an output list
  output_list = list(processed_data, total)
  
  return(output_list)
}
