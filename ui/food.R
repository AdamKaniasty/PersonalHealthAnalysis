generate_nutrition_ui <- function() {

  foodUI <- fluidPage(
    titlePanel("Analysis of diet and nutrition"),
  
    sidebarLayout(  

      mainPanel(
        box(
          title = "Macroelement intake",
          status = "warning",
          width = 12,
          solidHeader = TRUE,
          collapsible = FALSE,
          plotlyOutput("foodPlot")
        )
        ),
      sidebarPanel(
  
        selectInput("plotMeanFood",
                    "Show means of which parameters?",
                    list("Fats", "Carbohydrates", "Protein", "Sugar"),
                    selected = list("Fats", "Protein"),
                    multiple = TRUE),
        
        box(
          title = "Panel na jakies tam gadanie",
          status = "warning",
          width = 12,
          solidHeader = TRUE,
          collapsible = FALSE,
          p("Jakies tam gadanie, pozniej sprobuje dorobic jeszcze jeden wykres nizej", 
            style = "font-size: 20px;"),
        )
      )
    )
  )
  
  return(foodUI)
}
