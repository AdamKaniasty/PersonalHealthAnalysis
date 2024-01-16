gymSpider <- function(decrement){
  
  today <- Sys.Date()
  end <- floor_date(today - decrement, unit = "week")
  
  muscle_groups <- data %>%
    mutate(date = as.Date(start_time, format = "%d %b %Y")) %>%
    filter(date >= end & date < today) %>%
    group_by(muscle_group) %>%
    summarize(exercises_count = n())
  
  # Calculate the overall average
  overall_avg <- data %>%
    group_by(muscle_group) %>%
    summarize(avg_exercises_count = mean(n()))
  
  p <- plot_ly() %>%
    add_trace(
      data = overall_avg,
      type = 'scatterpolar',
      r = ~avg_exercises_count,
      theta = ~muscle_group,
      mode = 'lines',
      fill = 'toself',
      fillcolor = "#85b3b7",
      opacity = 0.5,
      line = list(color = "#85b3b7", width = 3, dash = 'dot')
    ) %>%
    add_trace(
      data = muscle_groups,
      type = 'scatterpolar',
      r = ~exercises_count,
      theta = ~muscle_group,
      mode = 'lines',
      fill = 'toself',
      fillcolor="#93d79b",
      opacity = 0.7,
      line = list(color = "#93d79b", width = 5), # More visible lines for individual data
      marker = list(size = 10)
    ) %>%
    layout(
      polar = list(
        radialaxis = list(
          visible = T,
          color = '#f7f7f7' # Color of the radial axis text and labels
        ),
        angularaxis = list(
          color = '#f7f7f7' # Color of the angular axis text and labels
        ),
        bgcolor = 'rgba(0,0,0,0)'),
      plot_bgcolor = 'rgba(0,0,0,0)',
      paper_bgcolor = 'rgba(0,0,0,0)',
      showlegend = F
    )
  
  return(p)
}
