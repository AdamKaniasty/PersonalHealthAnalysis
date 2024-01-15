library(shiny)
library(shinydashboard)
source("./intro/intro.R")
source("./ui/sleep.R")
source("./ui/mood.R")

ui <- dashboardPage(
  dashboardHeader(title = "Ja"),
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Main Page", tabName = "main", icon = icon("dashboard")),
      menuItem("Siłka", tabName = "silka", icon = icon("weight")),
      menuItem("Sleep", tabName = "sleep", icon = icon("bed")),
      menuItem("Emotions", tabName = "mood", icon = icon("smile")),
      menuItem("Nutrition", tabName = "food", icon = icon("utensils")),
      
      # Conditional for silka page
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
      ),
      
      # Conditional for mood page
      conditionalPanel(
        condition = "input.sidebar == 'mood'",
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
        )
      ),
      
      # Conditional for sleep page
      conditionalPanel(
        condition = "input.sidebar == 'sleep'",
        dateRangeInput(
          "dateRangeSleep",
          "Wybierz zakres dat:",
          start = "2023-12-12",
          end = "2024-01-07",
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
              .box.box-solid.box-primary>.box-header {
                color:#fff;
                background:#605ca8;
                
              }
              .box.box-solid.box-primary{
                border-bottom-color:#605ca8;
                border-left-color:#605ca8;
                border-right-color:#605ca8;
                border-top-color:#605ca8;
                             
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
      tabItem(tabName = "sleep",
              fluidRow(
                column(12, generate_sleep_ui()
                       )
              )
      ),
      tabItem(tabName = "mood",
              fluidRow(
                column(12, generate_mood_ui()
                       )
              )
      ),
      tabItem(tabName = "food",
              fluidRow(
                column(12, 
                       source("./ui/food.R", local = TRUE))
              ))
    )
  ),
  skin = "purple"
)
