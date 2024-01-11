
source("./src/mood/wykresNastrojuLolipop.R")
source("./src/mood/wykresNastrojuLine.R")

moodLogic <- function(input, output, session) {
  
  output$moodPlot <- renderPlot({
    startDate <- as.Date(input$dateRange[1])
    endDate <- as.Date(input$dateRange[2])
    
    if (input$chartType == "Lollipop") {
      moodLollipop(startDate, endDate)
    } else if (input$chartType == "Line") {
      moodLine(startDate, endDate)
    }
  })
  
  
}