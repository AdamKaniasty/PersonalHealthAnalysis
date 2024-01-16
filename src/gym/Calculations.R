library(ggplot2)
library(readr)
library(dplyr)
library(lubridate)

data <- read.csv("./data/gym/predki.csv")

gym_calculations <- function(start_date, end_date) {
  data$start_time <- as.POSIXct(data$start_time, format="%d %b %Y, %H:%M")
  data$end_time <- as.POSIXct(data$end_time, format="%d %b %Y, %H:%M")
  start_date_posix <- as.POSIXct(start_date, format="%d %b %Y, %H:%M")
  end_date_posix <- as.POSIXct(end_date, format="%d %b %Y, %H:%M")
  
  filtered_data <- data %>% 
    filter(start_time >= start_date_posix & end_time <= end_date_posix)
  
  number_of_workouts <- n_distinct(filtered_data$start_time)
  total_duration <- sum(filtered_data$end_time - filtered_data$start_time, na.rm = TRUE)
  total_volume <- sum(filtered_data$weight_kg * filtered_data$reps, na.rm = TRUE) #
  total_sets <- sum(!is.na(filtered_data$set_index))
  
  
  
  return(list(
    number_of_workouts = number_of_workouts,
    total_duration = total_duration,
    total_volume = total_volume,
    total_sets = total_sets
  ))
}
