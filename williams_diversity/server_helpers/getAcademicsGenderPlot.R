#' @description Function to get academic performance visualizations by gender
#'              We will display demographic proportion as bars 
#'              with one bar each for PBK, Latin Honors - (Suma, Magna, Cum), Theses, and then "other"


getAcademicsGenderPlot <- function(processed_data, year_min, year_max)
{
  library(dplyr)
  library(ggplot2)
  library(tidyr)
  processed_data <- filter(processed_data, !is.na(gender) & year >= year_min & year <= year_max)
  
  grouped_class <- dplyr::group_by(processed_data, class) %>% dplyr::summarise(total = n())
  
  grouped_class_gender <- dplyr::group_by(processed_data, class, gender) %>% dplyr::summarise(gender_total = n())
  merged_summary <- left_join(grouped_class_gender, grouped_class, by = "class")
  merged_summary$percent <- merged_summary$gender_total/merged_summary$total * 100
  
  merged_summary <- data.frame(merged_summary)
  merged_summary <- rbind(merged_summary, 
                          data.frame(class = "College Wide", gender = "male", 
                                     gender_total = 4306, total = 8687, percent = 49.61), 
                          data.frame(class = "College Wide", gender = "female", 
                                     gender_total = 4372, total = 8687, percent = 50.39))
  
  levels(merged_summary$class) <- c("Cum Laude\n(Top 30%)",       "Magna Cum Laude\n(Top 15%)", "None"   ,         "PBK\n(Top 12.5%)"     ,        "Summa Cum Laude\n(Top 2%)", "Thesis"   ,      
                                    "College Wide"  ) 
  

  cols = c(male = "#512698", female = "#fdcc09")
  plot <- ggplot(merged_summary, aes(class)) + 
    geom_bar(aes(fill = gender, weight = percent)) + 
    theme_bw() +
    theme(text = element_text(size = 15)) +
    ylab("Proportions") + xlab("Academic Distinction") + 
    geom_rect(aes(xmin = 0.55, xmax = 1.45, ymin = 0, ymax = 100), colour="orange", alpha = 0, size = 1.5) + 
    geom_hline(aes(yintercept=50), colour="#990000", linetype="dashed", size = 1.5) + 
    scale_fill_manual(values = cols) + scale_x_discrete(limits = c("College Wide", "Thesis","Summa Cum Laude\n(Top 2%)", 
                                                                   "PBK\n(Top 12.5%)", "Magna Cum Laude\n(Top 15%)", "Cum Laude\n(Top 30%)", "None"))
  
  
  plot
  
}










