library(shiny)
library(shinythemes)

ui <- fluidPage(
  theme = shinytheme("yeti"),
  includeCSS("./styles.css"),
  navbarPage("Navigation",
             tabPanel("Main Page",
                      fluidRow(
                        column(4,
                               h2("Section 1")
                        ),
                        column(4,
                               h2("Section 2")
                        ),
                        column(4,
                               h2("Section 3")
                        )
                      )
             ),
             tabPanel("Siłka",
                      fluidRow(
                        column(12,
                          source("./ui/gym.R")
                          )
                      )
             ),
             tabPanel("Sen",
                      fluidRow(
                        column(12,
                          source("./ui/sleep.R")
                      )
                  )
             ),
             tabPanel("Nastrój",
                      fluidRow(
                        column(12,
                          source("./ui/mood.R")
                      )
             )
  )
)
)

