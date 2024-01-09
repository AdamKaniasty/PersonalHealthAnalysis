library(r2d3)
library(plotly)

gymUI <- fluidRow(
  column(12, 
         h2("Gym Dashboard"))
)

gymUI <- tagList(gymUI, 
                 fluidRow(
                   column(6,
                          selectInput(
                            "spider_date_start",
                            "Select Date",
                            choices = c(7, 31, 10000),
                            selected = 7),
                          plotlyOutput("gym_spider")
                          ),
                   column(6, d3Output("plot2"))
                 ))

# Second row: Plot and text next to each other
gymUI <- tagList(gymUI,
                 fluidRow(
                   column(6, imageOutput("gym_muscles")),
                   column(6, 
                          h4("Information about Plot 3"),
                          verbatimTextOutput("text1"))
                 ))

# Third row: Two plots next to each other
gymUI <- tagList(gymUI,
                 fluidRow(
                   column(12, d3Output("stacked_progress")),
                 ))

return(gymUI)
