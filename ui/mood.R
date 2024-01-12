library(plotly)
library(shinyjqui)

generate_mood_ui <- function() {
  
moodUI <- fluidPage(
  titlePanel("Analiza zmian nastroju w czasie"),
  sidebarLayout(
    sidebarPanel(
      dateRangeInput(
        "dateRange",
        "Wybierz zakres dat:",
        start = "2023-12-12",
        end = "2024-01-07",
      ),
      radioButtons(
        "chartType",
        "Wybierz typ wykresu:",
        choices = c("Lollipop", "Line"),
        selected = "Lollipop"
      ),
      width = 3
    ),
    mainPanel(
      shinyjqui::jqui_resizable(plotOutput("moodPlot")),
      width = 9)
  )
)

return(moodUI)

}