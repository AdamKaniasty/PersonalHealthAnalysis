library(dbplyr)
library(ggplot2)
library(plotly)

daylio <- read.csv("./data/mood/daylio-export-H2.csv", header = TRUE)

moodLollipop <- function(startDate, endDate) {


# Mapping moods to integers:
map_mood <- data.frame(
  mood = c("okropnie", "źle", "tak sobie", "dobrze", "wspaniale"),
  value = c(1,2,3,4,5)
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


# Change of mood in time (lollipop plot)
ggthemr::ggthemr(palette = 'earth')
daylio_moods %>%
  ggplot(aes(x = as.Date(full_date))) +
  geom_linerange(data = daylio_moods_dup, aes(x = as.Date(full_date), ymin = minm, ymax = meanm, color = minm), size = 1.5) +
  geom_linerange(data = daylio_moods_dup, aes(x = as.Date(full_date), ymin = meanm, ymax = maxm, color = maxm), size = 1.5) + 
  geom_point(data = daylio_moods, aes(x = as.Date(full_date), y = value, color = value), size = 6) + 
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
    breaks = c(1, 2, 3, 4, 5),
    labels = c("terrible", "bad", "so-so", "good", "fantastic"),
    limits = c(1,5.5)
  ) + 
  scale_color_gradientn(
    colours = c("#FF0000", "#FFA500", "#FFFF00", "#00FF00", "#008000")
  ) -> mood_change_lollipop

  return(mood_change_lollipop)
}
