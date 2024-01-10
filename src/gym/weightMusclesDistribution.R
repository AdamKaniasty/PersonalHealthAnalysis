library(plotly)
library(dplyr)

data <- read.csv("./data/gym/predki.csv")

weightDistribution <- function(input){
plotData <- data
plotTypes <- list()

p <- plot_ly(data, x = ~muscle_group)

if ("weight" %in% input$variables) {
  p <- p %>% add_trace(y = ~weight_kg, name = 'Weight', type = 'violin')
}

if ("reps" %in% input$variables) {
  p <- p %>% add_trace(y = ~reps, name = 'Reps', type = 'violin')
}

p <- p %>% layout(yaxis = list(title = 'Value'), xaxis = list(title = 'Muscle Group'))

return(p)
}