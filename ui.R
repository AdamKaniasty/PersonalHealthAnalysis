library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Ja"),
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Main Page", tabName = "main", icon = icon("dashboard")),
      menuItem("Siłka", tabName = "silka", icon = icon("weight")),
      menuItem("Page 2", tabName = "page2", icon = icon("bed")),
      menuItem("Page 3", tabName = "page3", icon = icon("smile")),
      menuItem("Page 4", tabName = "page4", icon = icon("utensils")),
      
      conditionalPanel(
        condition = "input.sidebar == 'silka'",
        checkboxGroupInput("variables", "Variables to Display:", 
                           choices = c("Weight" = "weight", "Reps" = "reps"),
                           selected = "weight"),
        selectInput(
          "spider_date_start",
          "Select Date",
          choices = c(7, 31, 10000),
          selected = 7
        )
      )
    )
  ),
  dashboardBody(
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
    tabItems(
      tabItem(tabName = "main",
              fluidRow(
                column(4, h2("Section 1")),
                column(4, h2("Section 2")),
                column(4, h2("Section 3"))
              )
      ),
      tabItem(tabName = "silka",
              fluidRow(
                column(12,
                       source("./ui/gym.R", local = TRUE)
                )
              )
      ),
      tabItem(tabName = "page2",
              fluidRow(
                column(12, h2("Sen"))
              )
      ),
      tabItem(tabName = "page3",
              fluidRow(
                column(12, h2("Nastrój"))
              )
      ),
      tabItem(tabName = "page4",
              fluidRow(
                column(12, 
                       source("./ui/food.R", local = TRUE))
              ))
    )
  ),
  skin = "purple"
)
