library(shiny)
options(shiny.autoreload = TRUE)
try(
  setwd("./projekty/health/")
)
source("ui.R")
source("server.R")
shinyApp(ui = ui, server = server)
