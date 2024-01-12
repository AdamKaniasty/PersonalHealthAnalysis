library(dplyr)
library(ggplot2)
library(tidyr)
library(ggthemr)
library(htmltools)
library(chron)

## Preparing the data

# File paths
input_file <- "./data/sleep/sleep-export/sleep-export-H2.csv"

# Open the file for reading
con <- file(input_file, "r")

# Initialize variables
file_number <- 1
data_list <- list()
current_data <- NULL
start_reading <- FALSE

# Process the file line by line
while (TRUE) {
  line <- readLines(con, n = 1)
  if (length(line) == 0) {
    break
  }
  
  if (grepl("^Id,Tz,From,To", line)) {
    if (start_reading) {
      data_list[[paste0("sd", file_number)]] <- current_data
      file_number <- file_number + 1
    }
    current_data <- NULL
    start_reading <- TRUE
    
    # Store the column names and remove the double quotes
    col_names <- gsub('"', '', unlist(strsplit(line, ",")))
    
    # Read the next line for values
    line <- readLines(con, n = 1)
    values <- gsub('"', '', unlist(strsplit(line, ",")))
    
    # Create a dataframe with column names and values
    current_data <- as.data.frame(matrix(values, nrow = 1, byrow = TRUE))
    names(current_data) <- col_names
  }
}

# Save the last part
if (!is.null(current_data)) {
  data_list[[paste0("sd", file_number)]] <- current_data
}

# Close the file
close(con)





# Main function returning the plot
sleeptimeLine <- function(startDate, endDate) {

# Format dates and times
for (i in 1:length(data_list)) {
  data_list[[paste0("sd", i)]] <- data_list[[paste0("sd", i)]] %>%
    select(-Event) %>%
    pivot_longer(cols = -c(Id, Tz, From, To, Sched, Hours, Rating, Comment, Framerate, Snore, Noise, Cycles, DeepSleep, LenAdjust, Geo), names_to = "Time", values_to = "Value")    
  
  data_list[[paste0("sd", i)]]$To <- as.POSIXct(data_list[[paste0("sd", i)]]$To, format = "%d. %m. %Y %H:%M")
  data_list[[paste0("sd", i)]]$From <- as.POSIXct(data_list[[paste0("sd", i)]]$From, format = "%d. %m. %Y %H:%M")
  # Format Value to numeric
  data_list[[paste0("sd", i)]]$Value <- as.numeric(data_list[[paste0("sd", i)]]$Value)
  
  data_list[[paste0("sd", i)]]$Time <- format(as.POSIXct(data_list[[paste0("sd", i)]]$Time, format = "%H:%M"), format = "%H:%M")
}

sleeptime <- data_list[[1]] %>%
  select(From) %>%
  head(1)

for(i in 2:length(data_list)) {
  sleeptime <- rbind(sleeptime, data_list[[paste0("sd", i)]] %>%
                       select(From) %>%
                       head(1))
}

sleeptime %>% 
  arrange(From) -> sleeptime

sleeptime$Date <- as.Date(sleeptime$From, format = "%Y-%m-%d %H:%M:%S")
sleeptime$Time <- times(format(as.POSIXct(sleeptime$From, format = "%Y-%m-%d %H:%M:%S"), format = "%H:%M:%S")) # tymczasowo do czasu pójścia spać dopisuje się też data
sleeptime$From <- NULL
sleeptime$TimeN <- as.numeric(sleeptime$Time)


# Remove duplicated dates in sleeptime, taking the first one
sleeptime %>% 
  distinct(Date, .keep_all = TRUE) -> sleeptimerm

sleeptimerm[19, "TimeN"] <- 0.0
sleeptimerm[19,"Time"] <- chron::as.times(0.0)
  

sleeptimeA <- read.csv("./data/sleep/sleep-export/sleeptime-A.csv", sep = ";")
sleeptimeA$Date <- as.Date(sleeptimeA$Date, format = "%Y-%m-%d")
sleeptimeM <- read.csv("./data/sleep/sleep-export/sleeptime-M.csv", sep = ";")
sleeptimeM$Date <- as.Date(sleeptimeM$Date, format = "%Y-%m-%d")

# Filtering dates
sleeptimerm %>% 
  filter(Date >= startDate & Date <= endDate) -> sleeptimerm

sleeptimeA %>%
  filter(Date >= startDate & Date <= endDate) -> sleeptimeA

sleeptimeM %>%
  filter(Date >= startDate & Date <= endDate) -> sleeptimeM

# Line plot
sleeptimerm %>%
  ggplot(aes(x = Date, y = TimeN - 0.04166667, color = TimeN)) +
  geom_line(size = 1.5) + 
  geom_point(size = 4) + 
  theme(
    plot.title = element_text(size = 20, hjust = 0.5),
    axis.text.x = element_text(angle = 0, hjust = 1, vjust = 0.5, size = 14),
    axis.text.y = element_text(angle = 0, hjust = 1, vjust = 0.5, size = 14),
    axis.title = element_text(size = 16),
    panel.grid.major.x = element_blank(),
    legend.position = "none",
    panel.background = element_rect(fill = "white")
  ) + 
  labs(
    title = "Time of going to sleep each day",
    x = "Date",
    y = "Time of going to sleep"
  ) +
  scale_y_chron(
    format = "%H:%M"
  ) + 
  scale_color_gradient(
    low = "dodgerblue", # lighter blue 
    high = "navy", # navy 
  ) +
  geom_point(data = sleeptimeA, aes(x = Date, y = TimeN - 0.04166667), size = 4, color = "red3") +
  geom_line(data = sleeptimeA, aes(x = Date, y = TimeN - 0.04166667), size = 1.5, color = "red3") +
  geom_point(data = sleeptimeM, aes(x = Date, y = TimeN - 0.04166667), size = 4, color = "green4") +
  geom_line(data = sleeptimeM, aes(x = Date, y = TimeN - 0.04166667), size = 1.5, color = "green4") -> sleeptime_plot


return (sleeptime_plot)
}
