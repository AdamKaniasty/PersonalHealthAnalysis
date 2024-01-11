library(shiny)
library(dplyr)
library(tidyr)

df <- read.csv("C:\\Users\\11mat\\Desktop\\Podsumowanie-żywienia-2024-01-02-do-2024-01-09.csv")

foodPlot <- function(params){

  daily_calories <- df %>%
    group_by(Data) %>%
    summarize(total_calories = sum(Kalorie),
                total_fats = sum(Tłuszcze..g.),
                total_carbs = sum(Węglowodany..g.),
                total_protein = sum(Białko..g.),
                total_sugar = sum(Cukier),
                num_meals = n())
    
    
  fig <- plot_ly(daily_calories, x = ~Data, y = ~total_fats, name = 'Tłuszcze', type = 'scatter', mode = 'lines+markers') %>% 
    layout(title = 'Dzienne spożycie mikroskładników', 
             xaxis = list(title = 'Data'), 
             yaxis = list(title = 'Dzienne spożycie (w gramach)'))
  if ("Węglowodany" %in% params == TRUE) {
    fig <- fig %>% add_trace(y = ~total_carbs, name = 'Węglowodany', mode = 'lines+markers')
  }  
  if ("Białka" %in% params == TRUE) {
    fig <- fig %>% add_trace(y = ~total_protein, name = 'Białka', mode = 'lines+markers')
  }
  if ("Cukry" %in% params == TRUE) {
    fig <- fig %>% add_trace(y = ~total_sugar, name = 'Cukry', mode = 'lines+markers') 
  }
  return(fig)
}
