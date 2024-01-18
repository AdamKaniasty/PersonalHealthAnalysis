source("./src/food/wykres1.R")

foodLogic <- function(input, output, session) {
  
  output$foodPlot <- renderPlotly({
    foodPlot("./data/food/Podsumowanie-żywienia-2024-01-02-do-2024-01-09.csv",
             input$plotMeanFood, 
             input$showModeFood)
    
  })
  
  output$caloriePlot <- renderPlotly({
    caloriePlot("./data/food/Podsumowanie-żywienia-2024-01-02-do-2024-01-09.csv")
  })
}

