foodUI <- fluidPage(
  titlePanel("Przyjmowane mikroelementy"),

    
  mainPanel(
    selectInput("nawykresie",
                "Które parametry chcesz zobaczyć?",
                list("Węglowodany", "Białka", "Cukry"),
                selected = list("Węglowodany", "Białka", "Cukry"),
                multiple = TRUE),

    plotlyOutput("foodPlot")
    )
  )


return(foodUI)