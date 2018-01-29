processSports <- function(sport_data, locations)
{
   data <- select(sport_data, -Name.y, -firstname.y, -n, -firstname.x, -surname, -predrace)%>%
     mutate(Sport = ifelse(is.na(Sport), "Non-Athlete", Sport)) %>%
     group_by(Building) %>%
     count(Sport) %>%
     spread(Sport, n, fill = 0)
   
   data$total <- rowSums(data[,2:32])
   sport_totals <- colSums(data[,2:33])
   sport_props <- colSums(data[,2:32])/colSums(data[,"total"])
   data <- left_join(data, locations, by = "Building")
   
   pval = numeric(nrow(data))
   for (i in 1:nrow(data)) {
     pval[i] <- prop.test(data.frame(data[i, 2:32]),
                          data.frame(rep(data[i, 33], 31)),
                          sport_props,
                          alternative = "two.sided")$p.val
   }
   
   data$pval = pval
   
   output_list = list(data, c(sport_totals, sport_props))
   return(output_list)
}



#################### Processing by code and hand to create dataset ##############################
# sports_data <- mutate(sports_data, surname = str_extract(sports_data$Name, "\\S+(?=\\s*$)"))%>%
#   mutate(firstname = str_extract(sports_data$Name, "\\w*"))
# 
# counts <- left_join(building_rosters, locations, by = "Building")%>%
#   left_join(sports_data, by = "surname") %>%
#   mutate(surname = as.factor(surname)) %>%
#   count(surname)
# 
# 
# merged_data <- left_join(building_rosters, locations, by = "Building")%>%
#   left_join(sports_data, by = "surname") %>%
#   mutate(surname = as.factor(surname)) %>%
#   left_join(counts) %>%
#   filter(n!=1)%>%
#   filter(!is.na(Name.y))
#
# ##clean this stuff by hand
# write.csv(merged_data, "duplicated.csv")
# 
# clean_data <- left_join(building_rosters, locations, by = "Building")%>%
#   left_join(sports_data, by = "surname") %>%
#   mutate(surname = as.factor(surname)) %>%
#   left_join(counts) %>%
#   filter(n==1|is.na(Name.y))
# 
# write.csv(clean_data, "clean.csv")