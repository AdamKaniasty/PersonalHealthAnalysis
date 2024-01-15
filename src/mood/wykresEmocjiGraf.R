library(dplyr)
library(r2d3)

daylio <- read.csv("./data/mood/daylio-export-H2.csv", header = TRUE)

emotionsGraph <- function() {
  
  activCount <- table(unlist(strsplit(as.character(daylio$activities), " \\| ")))
  activTable <- as.data.frame.table(activCount)
  colnames(activTable) <- c("emotion", "frequency")
  
  emotions <- c("szczęście", "podniecenie", "wdzięczność", "relaks", "zadowolenie", "zmęczenie", "niepewność", "nuda", "niepokój",
                "złość", "stres", "smutek", "desperacja", "ulga", "zainteresowanie", "duma", "spełnienie", "euforia", "obrzydzenie", 
                "zazdrość", "nostalgia")
  # Translated into english:
  emotionsEN <- c("happiness", "excitement", "gratitude", "relaxation", "satisfaction", "tiredness", "uncertainty", "boredom", "anxiety",
                "anger", "stress", "sadness", "desperation", "relief", "interest", "pride", "fulfillment", "euphoria", "disgust",
                "jealousy", "nostalgia")
  
  # Change emotions to english
  activTable %>%
    filter(emotion %in% emotions) %>%
    mutate(emotion = emotionsEN[match(emotion, emotions)]) -> emotionsTable

  r2d3(
    data = emotionsTable,
    script = "./www/mood/emotionsGraph.js",
    d3_version = 4
  ) -> d3_emotions_graph

  d3_emotions_graph
  
  return(d3_emotions_graph)
  
  }