library(shiny)
library(shinydashboard)
source("./intro/intro.R")

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
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
              tags$style(
                HTML(".img-circle {
              border-radius: 50%;
              width: 150px; 
              height: 150px; 
              object-fit: cover;
                }
              ")
            )),
    tabItems(
      tabItem(tabName = "main",
              fluidRow(
                column(12, align = 'center',
                       "Tu na górze będą informacje o projekcie i użytych bibliotekach, oczywiście odpowiednio wystylowane")
              ),
              fluidRow(
                column(4, intro_columns("./photos/Adam.jpg", 
                                        "Adam Kaniasty", 
                                        "Krótki opis",
                                        "https://github.com/AdamKaniasty",
                                        "https://www.youtube.com/watch?v=dQw4w9WgXcQ"), 
                       align = 'center'),
                column(4, intro_columns("./photos/Hubert.jpg", 
                                        "Hubert Kowalski", 
                                        "Krótki opis",
                                        "https://github.com/kowalskihubert",
                                        "https://www.linkedin.com/in/hubert-kowalski-1b19bb1a3"), 
                       align = 'center'),
                column(4, intro_columns("./photos/Mateusz.jpg", 
                                        "Mateusz Król", 
                                        "Krótki opis",
                                        "https://github.com/mkrol11",
                                        "https://www.linkedin.com/in/mateusz-król-1a6a38265"), 
                       align = 'center')
              ),
              fluidRow(
                column(1)
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
