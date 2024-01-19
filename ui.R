library(shiny)
library(shinydashboard)
source("./intro/intro.R")
source("./ui/sleep.R")
source("./ui/mood.R")
source("./ui/food.R")

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
        ),
        dateRangeInput(
          "dateRangeGym",
          "Wybierz zakres dat:",
          start = "2023-12-12",
          end = "2024-01-07",
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
      ),
      
      # Conditional for nutrition page
      conditionalPanel(
        condition = "input.sidebar == 'food'",
        radioButtons("showModeFood",
                    "Select style of chart",
                    choices = c("Lines and markers", "Bars"),
                    selected = "Lines and markers")
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
                       HTML(paste("<span style='font-size: 60px; margin-bottom: 10px;'>
                                  <strong>Welcome!</strong></span><br>
                                  <span style='font-size: 20px;'>
                                  Modern technology advancements have enabled a lot of 
                                  different ways to control your well-being better - applications 
                                  on your smartphone can help you see how effectively you
                                  eat, sleep or exercise. They allow you to easily track your 
                                  mood, meals or trainings. In this project, we have decided 
                                  to use that opportunity to take a look at our lifestyles.
                                  Combining R, JS, HTML and CSS in its code, this application 
                                  summarizes and analyzes important information we have 
                                  gathered about ourselves and our health.<br>")),
                       
                       libraries_used(),
                       
                       HTML('<h2>About us:</h2>')
                            ),
              ),
              
              fluidRow(
                column(4, intro_columns("./photos/Adam.jpg", 
                                        "Adam Kaniasty", 
                                        "Krotki opis",
                                        "https://github.com/AdamKaniasty",
                                        "https://www.youtube.com/watch?v=dQw4w9WgXcQ"), 
                       align = 'center'),
                column(4, intro_columns("./photos/Hubert.jpg", 
                                        "Hubert Kowalski", 
                                        "Krotki opis",
                                        "https://github.com/kowalskihubert",
                                        "https://www.linkedin.com/in/hubert-kowalski-1b19bb1a3"), 
                       align = 'center'),
                column(4, intro_columns("./photos/Mateusz.jpg", 
                                        "Mateusz Król", 
                                        "From Koszalin. Currently studies data analysis on Warsaw University of Technology. Fan of cycling and astronomy.",
                                        "https://github.com/mkrol11",
                                        "https://www.linkedin.com/in/mateusz-król-1a6a38265"), 
                       align = 'center')
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
                column(12, generate_nutrition_ui())
              )
      )
    )
  ),
  skin = "purple"
)

