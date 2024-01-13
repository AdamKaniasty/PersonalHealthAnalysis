library(dplyr)
library(r2d3)

daylio <- read.csv("./data/mood/daylio-export-H2.csv", header = TRUE)

emotionsGraph <- function() {
  
  activCount <- table(unlist(strsplit(as.character(daylio$activities), " \\| ")))
  activTable <- as.data.frame.table(emotionsCount)
  colnames(activTable) <- c("emotion", "frequency")
  
  emotions <- c("szczęście", "podniecenie", "wdzięczność", "relaks", "zadowolenie", "zmęczenie", "niepewność", "nuda", "niepokój",
                "złość", "stres", "smutek", "desperacja", "ulga", "zainteresowanie", "duma", "spełnienie", "euforia", "obrzydzenie", 
                "zazdrość", "nostalgia")
  
  emotionsTable %>%
    filter(emotion %in% emotions) -> emotionsTable

  r2d3(
    data = emotionsTable,
    script = "./www/mood/emotionsGraph.js",
    d3_version = 4
  ) -> d3_emotions_graph
  
  r2d3(
    data = emotionsTable,
    script = "./www/mood/test.js",
    d3_version = 4
  ) -> d3_emotions_graph

  d3_emotions_graph
  
  return(d3_emotions_graph)
  
  }