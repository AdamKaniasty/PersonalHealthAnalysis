intro_columns <- function(image_path, title, description, github_link, linkedin_link) {
  column(
    width = 12,
    img(src = image_path, class = "img-circle", align = 'center'),
    h4(title),
    p(description, align = 'center'),
    a(icon("github"), href = github_link, target = "_blank", style = "font-size: 50px;"),
    a(icon("linkedin"), href = linkedin_link, target = "_blank", style = "font-size: 50px;")
  )
}

# Ta funkcja jest konieczna, aby uniknąć printowania "TRUE" z boku kolumn