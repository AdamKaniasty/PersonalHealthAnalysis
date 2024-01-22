library(plotly)
library(shinyjqui)
library(shinydashboard)

generate_mood_ui <- function() {
  
moodUI <- fluidPage(
  titlePanel("Analiza zmian nastroju w czasie"),

      fluidRow(
        column(
          box(
            title = "How are you feeling today?",
            status = "primary",
            solidHeader = TRUE,
            collapsible = FALSE,
            width = 12,
            p("This plot shows your mood in time. You can choose the date range and the type of chart (see on the left).
            Note that for some days the data has been collected more than once, resulting in multiple points on the lollipop chart.
            The line chart shows the average mood for each day. ", style = "font-size: 20px;"),
            ),
          box(
            title = "What impacts happiness the most?",
            status = "primary",
            solidHeader = TRUE,
            collapsible = FALSE,
            width = 12,
            p("IDK yet", style = "font-size: 20px;"),
            ),
          width = 3
          ),
        box(
          title = "Mood in time",
          status = "primary",
          solidHeader = TRUE,
          collapsible = FALSE,
          width = 9,
          plotlyOutput("moodPlotly", height = "600px")
        )
        ),
      fluidRow(
        box(
          title = "Emotions",
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          width = 6,
          d3Output("emotionsPlot", height = "600px")
        ),
        box(
          title = "Activities",
          status = "warning",
          solidHeader = TRUE,
          collapsible = FALSE,
          width = 6,
          d3Output("activitiesPlot", height = "600px")
        )
      )
  
)

return(moodUI)

}