library(shiny)
options(shiny.autoreload = TRUE)

source("ui.R")
source("server.R")
shinyApp(ui = ui, server = server)
