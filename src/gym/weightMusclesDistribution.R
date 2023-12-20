library(plotly)
library(dplyr)

data <- read.csv("./data/gym/predki.csv")

data <- data %>%
  filter(!is.na(weight_kg)) %>%
  mutate(weight_kg = as.numeric(weight_kg))

plot <- plot_ly(data, y = ~weight_kg, x = ~muscle_group, type = 'violin') %>%
  layout(yaxis = list(title = 'Waga [kg]'), xaxis = list(title = 'Grupa mięśniowa'))

plot
