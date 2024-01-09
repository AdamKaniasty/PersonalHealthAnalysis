library(shiny)
source("./servers/gym.R")

server <- function(input, output, session) {
  gymLogic(input, output, session)  
}
