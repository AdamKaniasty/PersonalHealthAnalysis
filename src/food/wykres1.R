library(shiny)
library(dplyr)
library(tidyr)

foodPlot <- function(datasource, showmode){

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
    
  fig <- fig %>% layout(title = 'Daily intake of selected macroelements', 
                      xaxis = list(title = 'Date'), 
                      yaxis = list(title = 'Daily intake (grams)'),
                      paper_bgcolor = 'gray60',
                      plot_bgcolor = 'gray80',
                      hovermode = 'x unified') %>% 
    add_trace(x = ~Data, y = ~mean(total_fats),
                             type = 'scatter',
                             name = 'Fat mean', 
                             mode = 'lines',
                             line = list(color = 'gold')) %>% 
    add_trace(x = ~Data, y = ~mean(total_carbs), 
                             type = 'scatter',
                             name = 'Carb. mean', 
                             mode = 'lines',
                             line = list(color = 'darkturquoise')) %>% 
    add_trace(x = ~Data, y = ~mean(total_protein), 
                             type = 'scatter',
                             name = 'Protein mean', 
                             mode = 'lines',
                             line = list(color = 'lightcoral')) %>% 
    add_trace(x = ~Data, y = ~mean(total_sugar),
                             type = 'scatter',
                             name = 'Sugar mean', 
                             mode = 'lines',
                             line = list(color = 'lightslategrey'))  %>%
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

caloriePlot <- function(datasource){
  
  daily_calories <- read.csv(datasource) 
  daily_calories <- daily_calories %>%
    group_by(Data) %>%
    reframe(total_calories = sum(`Kalorie`),
              numdate = as.numeric(as.Date(`Data`)),
              num_meals = n(),
              cal_root = sqrt(total_calories))
  
  daily_calories <- distinct(daily_calories)
  
  fig <- plot_ly(
    daily_calories,
    type = 'barpolar',
    theta = ~numdate*360/(max(daily_calories$numdate) - min(daily_calories$numdate) + 1), #Divides circle to required number of slices
    r = ~cal_root,
    hoverinfo = 'text',
    text = ~paste('Date: ', Data, '<br>Consumed calories: ', total_calories),
    marker = list(color = ~total_calories, colorscale = "Temps")
  )
  
  fig <- fig %>% layout(
    polar = list(
      radialaxis = list(visible = TRUE, 
                        range = c(0, 71),
                        tickvals = list(sqrt(250), sqrt(500), sqrt(1000), 
                                        sqrt(1500), sqrt(2000), sqrt(2500),
                                        sqrt(3000), sqrt(4000), sqrt(5000)),
                        ticktext = list('250', '500', '1000', '1500', '2000', 
                                        '2500', '3000', '4000', '5000')), #Now intake is relative to field of slice
      angularaxis = list(direction = "clockwise", 
                         rotation = 270, 
                         dtick = 360/(max(daily_calories$numdate) - min(daily_calories$numdate) + 1),
                         showticklabels = FALSE),
                         ticktext = seq.Date(as.Date(min(daily_calories$numdate)), as.Date(max(daily_calories$numdate)), by = 1)
    ),
    showlegend = FALSE,
    paper_bgcolor = 'gray60',
    plot_bgcolor = 'gray80',
    title = 'Sum of kcal consumed on each day'
  )
  
  return(fig)
}

