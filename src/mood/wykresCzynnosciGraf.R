library(dplyr)
library(r2d3)

daylio <- read.csv("./data/mood/daylio-export-H2.csv", header = TRUE)

activGraph <- function() {
  
  activCount <- table(unlist(strsplit(as.character(daylio$activities), " \\| ")))
  activTable <- as.data.frame.table(activCount)
  colnames(activTable) <- c("activity", "frequency")
  
  activities <- c("ćwiczenie", "spacer", "filmy i tv", "czytanie", "sport", "impreza", "pianino", "relaks",
                  "wieczór z drugą połówką", "praca", "zakupy", "sprzątanie", "gotowanie", "pranie", "mycie naczyń",
                  "śmieci", "nauka", "zajęcia", "projekt grupowy", "pielęgnacja skóry")
  # Translated into english:
  activitiesEN <- c("exercise", "walk", "movies", "reading", "sport", "party", "piano", "relaxation",
                  "randez-vous", "work", "shopping", "cleaning", "cooking", "laundry", "dishes",
                  "taking out trash", "learning", "classes", "group project", "skin care")
  
  # Change activities into english
  activTable %>%
    filter(activity %in% activities) %>%
    mutate(activity = activitiesEN[match(activity, activities)]) -> activitiesTable
  
  r2d3(
    data = activitiesTable,
    script = "./www/mood/activitiesGraph.js",
    d3_version = 4
  ) -> d3_activ_graph
  
  d3_activ_graph
  
  return(d3_activ_graph)
  
}