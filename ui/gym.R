# ui/gym.R

library(r2d3)
library(plotly)

gymUI <- fluidRow(
  column(12, 
         h2("Gym Dashboard"))
)

gymUI <- tagList(gymUI, 
                 fluidRow(
                   box(
                     title = "Bedtime line plot",
                     status = "primary",
                     solidHeader = TRUE,
                     collapsible = FALSE,
                     width = 6,
                     class = 'box-calc',
                     fluidRow(
                       box(
                         title = "Total sets",
                         status = "primary",
                         solidHeader = TRUE,
                         collapsible = FALSE,
                         width = 6,
                         class = 'box-calc-item',
                         verbatimTextOutput("total_sets")
                       ),
                       box(
                         title = "Total sets",
                         status = "primary",
                         solidHeader = TRUE,
                         collapsible = FALSE,
                         width = 6,
                         verbatimTextOutput("total_duration")
                       ),  
                     ),
                     fluidRow(
                       box(
                         title = "Total sets",
                         status = "primary",
                         solidHeader = TRUE,
                         collapsible = FALSE,
                         width = 6,
                         verbatimTextOutput("number_of_workouts")
                       ),
                       box(
                         title = "Total sets",
                         status = "primary",
                         solidHeader = TRUE,
                         collapsible = FALSE,
                         width = 6,
                         verbatimTextOutput("total_volume")
                       )
                     )
                   ),
                   box(
                     title = "Bedtime line plot",
                     status = "primary",
                     solidHeader = TRUE,
                     collapsible = FALSE,
                     width = 6,
                     plotlyOutput("gym_weight_distribution")
                   ),
                 ))

gymUI <- tagList(gymUI,
                 fluidRow(
                   box(
                    title = "Bedtime line plot",
                    status = "primary",
                    solidHeader = TRUE,
                    collapsible = FALSE,
                    width = 12,
                    class = "row2",
                    fluidRow(
                      column(3,
                             imageOutput("gym_muscles")
                      ),
                      column(7,
                             class = "spider",
                             plotlyOutput("gym_spider")
                      ),
                      column(2, 
                             h4("Information about Plot 3"),
                             verbatimTextOutput("text1")
                      )
                    )
                    )
  )
)

gymUI <- tagList(gymUI,
                 fluidRow(
                   box(
                     title = "Bedtime line plot",
                     status = "primary",
                     solidHeader = TRUE,
                     collapsible = FALSE,
                     width = 12,
                   column(12, d3Output("stacked_progress")),
                   )
                 ))

gymUI