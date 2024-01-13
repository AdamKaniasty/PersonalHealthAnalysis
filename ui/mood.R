library(plotly)
library(shinyjqui)
library(shinydashboard)

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
      fluidRow(
        box(
          title = "How are you feeling today?",
          status = "primary",
          solidHeader = TRUE,
          collapsible = FALSE,
          width = 3,
          "This plot shows your mood in time. You can choose the date range and the type of chart (see on the left).
          Note that for some days the data has been collected more than once, resulting in multiple points on the lollipop chart.
          The line chart shows the average mood for each day. "
        ),
        box(
          title = "Mood in time",
          status = "primary",
          solidHeader = TRUE,
          collapsible = FALSE,
          width = 9,
          plotOutput("moodPlot", height = "600px")
        )
      ),
      fluidRow(
        box(
          title = "Emotions",
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          width = 12,
          d3Output("emotionsPlot", height = "600px")
        )
      ),
      width = 9)
  )
)

return(moodUI)

}