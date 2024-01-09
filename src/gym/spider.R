library(plotly)
library(dplyr)
library(lubridate)
setwd("./projekty/health")
data <- read.csv("./data/gym/predki.csv")

last_week_start <- floor_date(Sys.Date() - 7, unit = "week")


muscle_groups <- data %>%
  mutate(date = as.Date(start_time, format = "%d %b %Y")) %>%
  filter(date >= last_week_start & date < last_week_start + 7) %>%
  group_by(muscle_group) %>%
  summarize(exercises_count = n())

plot_ly(muscle_groups, type = 'scatterpolar', fill = 'toself',
        r = ~exercises_count,
        theta = ~muscle_group,
        mode = 'markers+text',
        marker = list(size = 10)) %>%
  layout(polar = list(radialaxis = list(visible = T)),
         showlegend = F)