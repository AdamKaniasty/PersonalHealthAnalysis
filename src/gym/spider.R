library(plotly)
library(dplyr)
library(lubridate)
data <- read.csv("./data/gym/predki.csv")


gymSpider <- function(decrement){

today <- Sys.Date()
end <- floor_date(today - decrement, unit = "week")

muscle_groups <- data %>%
  mutate(date = as.Date(start_time, format = "%d %b %Y")) %>%
  filter(date >= end & date < today) %>%
  group_by(muscle_group) %>%
  summarize(exercises_count = n())

p <- plot_ly(muscle_groups, type = 'scatterpolar', fill = 'toself',
        r = ~exercises_count,
        theta = ~muscle_group,
        mode = 'markers+text',
        marker = list(size = 10)) %>%
  layout(polar = list(radialaxis = list(visible = T)),
         showlegend = F)
return(p)
}