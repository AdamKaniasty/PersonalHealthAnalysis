source("./src/sleep/wykresSleepTimeLine.R")

sleepLogic <- function(input, output, session) {
  
  output$sleeptimePlot <- renderPlot({
    startDate <- as.Date(input$dateRangeSleep[1])
    endDate <- as.Date(input$dateRangeSleep[2])
  
    sleeptimeLine(startDate, endDate)
    
  })
  
  
}