#' @description Function to get academic performance visualizations by race
#'              We will display demographic proportion as bars 
#'              with one bar each for PBK, Latin Honors - (Suma, Magna, Cum), Theses, and then "other"


getAcademicsRacePlot <- function(processed_data, year_min, year_max)
{
  library(dplyr)
  library(ggplot2)
  library(tidyr)
  processed_data <- filter(processed_data, !is.na(race) & year >= year_min & year <= year_max & race != "None")
  
  
  grouped_class <- dplyr::group_by(processed_data, class) %>% dplyr::summarise(total = n())
  
  grouped_class_race <- dplyr::group_by(processed_data, class, race) %>% dplyr::summarise(race_total = n())
  merged_summary <- left_join(grouped_class_race, grouped_class, by = "class")
  merged_summary$percent <- merged_summary$race_total/merged_summary$total * 100
  
  merged_summary <- data.frame(merged_summary)
  merged_summary <- rbind(merged_summary, 
                          data.frame(class = "College Wide", race = "White/Black", 
                                     race_total = 4306, total = 8687, percent = 80.69), 
                          data.frame(class = "College Wide", race = "Asian", 
                                     race_total = 4372, total = 8687, percent = 12.49309),
                          data.frame(class = "College Wide", race = "Hispanic", 
                                     race_total = 4372, total = 8687, percent = 6.82)
                          )
  
  
  cols = c("White/Black" = "#FFC13B", "Asian" = "#4A8DB5", "Hispanic" = "#FFFD8D")
  plot <- ggplot(merged_summary, aes(class)) + 
    geom_bar(aes(fill = race, weight = percent)) + 
    theme_bw() +
    theme(text = element_text(size = 15)) +
    ylab("Proportions") + xlab("Academic Distinction") + 
    geom_rect(aes(xmin = 6.55, xmax = 7.45, ymin = 0, ymax = 100), colour="orange", alpha = 0, size = 1.5) + 
    geom_hline(aes(yintercept=80.69), colour="#990000", linetype="dashed", size = 1) + 
    geom_hline(aes(yintercept=80.69 + 6.82), colour="#990000", linetype="dashed", size = 1) + 
    scale_fill_manual(values = cols) + scale_x_discrete(limits = c("PBK", "Summa Cum Laude", "Magna Cum Laude", 
                                                                   "Cum Laude", "Thesis", "None", "College Wide"))
  
  plot
  
}









