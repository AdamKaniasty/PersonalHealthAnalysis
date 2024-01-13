library(plotly)
library(shinyjqui)

generate_sleep_ui <- function() {
  
sleepUI <- fluidPage(
  titlePanel("Analiza jakości i długości snu"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput(
        "dateRangeSleep",
        "Wybierz zakres dat:",
        start = "2023-12-12",
        end = "2024-01-07",
      ),
      width = 3
    ),
    mainPanel(
      shinyjqui::jqui_resizable(plotlyOutput("sleeptimePlot")),
      width = 9)
  )
)

return(sleepUI)

}