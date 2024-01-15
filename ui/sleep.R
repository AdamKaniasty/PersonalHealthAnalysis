library(plotly)
library(shinyjqui)
library(shinydashboard)

generate_sleep_ui <- function() {
  
sleepUI <- fluidPage(
  titlePanel("Analiza jakości i długości snu"),
  
  fluidRow(
    box(
      title = "Time to bed",
      status = "primary",
      solidHeader = TRUE,
      collapsible = FALSE,
      width = 6,
      p("The plot on the right shows the time when each of us went to bed.", style = "font-size: 20px;"),
    ),
    box(
      title = "Bedtime line plot",
      status = "primary",
      solidHeader = TRUE,
      collapsible = FALSE,
      width = 6,
      shinyjqui::jqui_resizable(plotlyOutput("sleeptimePlot"))
    )
  ),
  
  fluidRow(
    box(
      title = "Actigraph",
      status = "warning",
      solidHeader = TRUE,
      collapsible = FALSE,
      width = 6,
      plotlyOutput("actigraphPlot")
    ),
    box(
      title = "Activity during sleep",
      status = "warning",
      solidHeader = TRUE,
      collapsible = FALSE,
      width = 6,
      p("Actigraph gives us an insight into the details of our sleep. It presents the sleep
        duration as well as activity during sleep, measured by the sounds like snoring or coughing
        but also by the movement of body. Since each graph represents a separate night, in order to
        see a graph user has to choose a specific date and a person for whom the graph should be drawn.", style = "font-size: 20px;"),
      dateInput(
        "dateActigraph",
        "Choose a date for actigraph:",
        value = "2023-12-12"
      )
    )
  )
    

)

return(sleepUI)

}