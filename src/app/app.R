library(shiny)
# setwd("./projekty/health/src/app")

source("ui.R")
source("server.R")
shinyApp(ui = ui, server = server)
