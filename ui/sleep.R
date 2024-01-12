library(plotly)
library(shinyjqui)

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
      shinyjqui::jqui_resizable(plotOutput("sleeptimePlot")),
      width = 9)
  )
)

return(sleepUI)