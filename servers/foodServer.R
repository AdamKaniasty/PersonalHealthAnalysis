source("./src/food/wykres1.R")

foodLogic <- function(input, output, session) {
  
  output$foodPlot <- renderPlotly({
    foodPlot(input$nawykresie)
    
  })
}