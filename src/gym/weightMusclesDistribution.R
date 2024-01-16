library(plotly)
library(dplyr)
library(RColorBrewer)

data <- read.csv("./data/gym/predki.csv")

weightDistribution <- function(input) {
  plotData <- data
  
  #pastel_palette <- brewer.pal(6, "Pastel1")
  pastel_palette <- c('#ffafc4', '#93d79b', '#fcac96', '#85b3b7', '#e6a0b7', '#fcac96')
  
  color_mapping <- setNames(pastel_palette, unique(plotData$muscle_group))

  
  p <- plot_ly()
  
  # Iterate over each muscle group and add a violin plot for each
  for (muscle_group in unique(plotData$muscle_group)) {
    group_data <- plotData[plotData$muscle_group == muscle_group, ]
    
    if ("weight" %in% input$variables) {
      p <- p %>% add_trace(data = group_data, x = ~muscle_group, y = ~weight_kg, 
                           type = 'violin', name = 'Weight',
                           line = list(color = color_mapping[muscle_group]),
                           fillcolor = pastel_palette[muscle_group]
                           )
    }
    
    if ("reps" %in% input$variables) {
      p <- p %>% add_trace(data = group_data, x = ~muscle_group, y = ~reps, 
                           type = 'violin', name = 'Reps',
                           line = list(color = color_mapping[muscle_group]))
    }
  }
  
  p <- p %>% layout(
    plot_bgcolor = 'rgba(0,0,0,0)',
    paper_bgcolor = 'rgba(0,0,0,0)',
    hoverlabel = list(bgcolor = 'rgba(0,0,0,0)', font = list(color = 'white')),
    yaxis = list(
      title = 'Value', 
      color = '#f7f7f7',
      gridcolor = 'rgba(247, 247, 247, 0.5)',
      zerolinecolor = 'rgba(247, 247, 247, 0.5)'
    ), 
    xaxis = list(
      title = 'Muscle Group', 
      color = '#f7f7f7',
      gridcolor = 'rgba(247, 247, 247, 0.5)',
      zerolinecolor = 'rgba(247, 247, 247, 0.5)'
    )
  )
  
  return(p)
}
