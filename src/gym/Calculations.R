library(ggplot2)
library(readr)
library(dplyr)
library(lubridate)


gym_calculations <- function(filtered_data) {
  
  number_of_workouts <- n_distinct(filtered_data$start_time)
  total_duration <- sum(filtered_data$end_time - filtered_data$start_time, na.rm = TRUE)
  total_volume <- sum(filtered_data$weight_kg * filtered_data$reps, na.rm = TRUE) #
  total_sets <- sum(!is.na(filtered_data$set_index))
  
  
  
  return(list(
    number_of_workouts = number_of_workouts,
    total_duration = round(total_duration / 60,2),
    total_volume = round(total_volume / 1000,2),
    total_sets = total_sets
  ))
}
