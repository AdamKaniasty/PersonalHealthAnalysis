library(shiny)
source("./servers/gym.R")
source("./servers/moodServer.R")
source("./servers/sleepServer.R")

server <- function(input, output, session) {
  gymLogic(input, output, session)
  moodLogic(input, output, session)
  sleepLogic(input, output, session)
}
