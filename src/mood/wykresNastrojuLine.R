library(dplyr)
library(ggplot2)

daylio <- read.csv("./data/mood/daylio-export-H2.csv", header = TRUE)

moodLine <- function(startDate, endDate) {

# Mapping moods to integers:
map_mood <- data.frame(
  mood = c("wspaniale", "dobrze", "tak sobie", "źle", "okropnie"),
  value = c(5.0, 4.0, 3.0, 2.0, 1.0)
)

daylio_moods <- merge(daylio, map_mood, by = "mood")

# Filter dates:
daylio_moods <- daylio_moods %>%
  filter(as.Date(full_date) >= startDate & as.Date(full_date) <= endDate)


# Divide data into two sets: duplicated dates and unique dates
daylio_moods %>%
  group_by(full_date) %>%
  summarise(n = n()) %>%
  filter(n > 1) %>%
  select(full_date) -> duplicated_dates

daylio_moods_dup <- daylio_moods %>%
  filter(full_date %in% simplify2array(duplicated_dates)) %>%
  group_by(full_date) %>%
  summarise(maxm = max(value), minm = min(value), meanm = mean(value))

daylio_moods_sin <- daylio_moods %>%
  filter(!full_date %in% simplify2array(duplicated_dates))

daylio_moods_dup_line <- daylio_moods %>%
  filter(full_date %in% simplify2array(duplicated_dates)) %>%
  merge(daylio_moods_dup, by = "full_date") %>%
  select(-c(minm, maxm, value)) %>%
  rename(value = meanm)

daylio_moods_line <- rbind(daylio_moods_dup_line, daylio_moods_sin)

# Line plot od mood in time with gradient depending on Mood
ggthemr::ggthemr(palette = 'earth')
daylio_moods_line %>%
  ggplot(aes(x = as.Date(full_date))) +
  geom_line(aes(y = value, color = value), size = 2) +
  theme(
    plot.title = element_text(size = 20, hjust = 0.5),
    axis.text.x = element_text(angle = 30, hjust = 0.5, vjust = 0.5, size = 14),
    axis.text.y = element_text(angle = 0, hjust = 0.5, vjust = 0.5, size = 14),
    axis.title = element_text(size = 16),
    panel.grid.major.x = element_blank(),
    legend.position = "none",
    panel.background = element_rect(fill = "white")
  ) + 
  labs(
    title = "Mood change in time",
    x = "Date",
    y = "Mood"
  ) + 
  scale_x_date(
    date_breaks = "4 days",
    date_labels = "%d %b"
  ) + 
  scale_y_continuous(
    breaks = c(1.0, 2.0, 3.0, 4.0, 5.0),
    labels = c("okropnie", "źle", "tak sobie", "dobrze", "wspaniale"),
    limits = c(1,5.5)
  ) +
  scale_color_gradientn(
    colours = c("red", "orange", "yellow", "green", "#008000"),
    values = c(0, 0.25, 0.5, 0.75, 1)
  ) -> mood_change_line


return(mood_change_line)
}
