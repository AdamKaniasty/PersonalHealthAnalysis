library(shiny)
library(dplyr)
library(tidyr)

foodPlot <- function(datasource, params, showmode){

  daily_calories <- read.csv(datasource) %>%
    group_by(Data) %>%
    summarize(total_calories = sum(Kalorie),
                total_fats = sum(`Tłuszcze..g.`),
                total_carbs = sum(`Węglowodany..g.`),
                total_protein = sum(`Białko..g.`),
                total_sugar = sum(`Cukier`),
                num_meals = n())
    
  if (showmode == 'Lines and markers') {
    fig <- plot_ly(daily_calories, type = 'scatter') 
    }  else {
    fig <- plot_ly(daily_calories)
  }
  
  if ("Fats" %in% params == TRUE) {
    fig <- fig %>% add_trace(x = ~Data, y = ~mean(total_fats),
                             type = 'scatter',
                             name = 'Fat mean', 
                             mode = 'lines',
                             line = list(color = 'gold'))
  }
  if ("Carbohydrates" %in% params == TRUE) {
    fig <- fig %>% add_trace(x = ~Data, y = ~mean(total_carbs), 
                             type = 'scatter',
                             name = 'Carb. mean', 
                             mode = 'lines',
                             line = list(color = 'darkturquoise'))
  }  
  if ("Protein" %in% params == TRUE) {
    fig <- fig %>% add_trace(x = ~Data, y = ~mean(total_protein), 
                             type = 'scatter',
                             name = 'Protein mean', 
                             mode = 'lines',
                             line = list(color = 'lightcoral'))
  }
  if ("Sugar" %in% params == TRUE) {
    fig <- fig %>% add_trace(x = ~Data, y = ~mean(total_sugar),
                             type = 'scatter',
                             name = 'Sugar mean', 
                             mode = 'lines',
                             line = list(color = 'lightslategrey')) 
  }
  
  fig <- fig %>% layout(title = 'Daily intake of selected macroelements', 
                      xaxis = list(title = 'Date'), 
                      yaxis = list(title = 'Daily intake (grams)')) %>%
    add_trace(x = ~Data, y = ~total_fats, 
              name = 'Fats', 
              mode = 'lines+markers',
              line = list(color = 'orange', shape = 'spline'),
              marker = list(color = 'orange')) %>% 
    add_trace(x = ~Data, y = ~total_carbs, 
              name = 'Carbohydrates', 
              mode = 'lines+markers', 
              line = list(color = 'blue', shape = 'spline'),
              marker = list(color = 'blue')) %>%
    add_trace(x = ~Data, y = ~total_protein, 
              name = 'Protein', 
              mode = 'lines+markers', 
              line = list(color = 'red', shape = 'spline'),
              marker = list(color = 'red')) %>%
    add_trace(x = ~Data, y = ~total_sugar, 
              name = 'Sugar', 
              mode = 'lines+markers',
              line = list(color = 'black', shape = 'spline'),
              marker = list(color = 'black'))

  return(fig)
}
