# servers/gym.R

library(r2d3)
library(jsonlite)
library(dplyr)
library(plotly)
library(tidyr)


source("./src/gym/spider.R")
source("./src/gym/muscles/muscles.R")
source("./src/gym/weightMusclesDistribution.R")
source("./src/gym/progress.R")

gymLogic <- function(input, output, session) {
  
  output$gym_spider <- renderPlotly({
    gymSpider(as.numeric(input$spider_date_start))
  })
  
  #output$gym_progress <- 
    
  output$gym_weight_distribution <- renderPlotly({
    weightDistribution(input)
  })
    
  #output$gym_time-performance <-
  
  output$gym_muscles <- renderImage({
    image <- musclesPlot()
    list(
      src="./image_composite.png"
    )
  }, deleteFile = T)
  
  output$stacked_progress <- renderD3({
    data <- read.csv("./data/gym/predki.csv")
    processed_data <- data %>%
      mutate(week = week(as.Date(start_time, format = "%d %b %Y")),
             year = year(as.Date(start_time, format = "%d %b %Y")),
             total_weight = weight_kg * reps) %>%
      group_by(year, week, muscle_group) %>%
      summarize(total_weight = sum(total_weight, na.rm = TRUE)) %>%
      ungroup() %>%
      complete(year, week, muscle_group, fill = list(total_weight = 0)) %>%
      arrange(year, week)
    
      d3_data <- processed_data %>%
        pivot_wider(names_from = muscle_group, values_from = total_weight) %>%
        replace(is.na(.), 0)
      print(d3_data)
      r2d3(data = d3_data, script = "www/gym/stacked_bar_chart.js")
  })
}
