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
                      sidebarPanel(
                        checkboxGroupInput("variables", "Variables to Display:", 
                                           choices = c("Weight" = "weight", "Reps" = "reps"),
                                           selected = "weight")
                      ),
                      fluidRow(
                        column(12,
                          source("./ui/gym.R")
                          )
                      )
             ),
             tabPanel("Page 2",
                      fluidRow(
                        column(12,
                               h2("Sen"))
                      )
             ),
             tabPanel("Page 3",
                      fluidRow(
                        column(12,
                               h2("Nastrój"))
                      )
             )
  )
)