# Draws the cover of the book: ebook/images/cover.png, in the proportions of an A4 page
# (1654 x 2339 pixels), because it is also the first page of the PDF.
#
# Run it from the ebook folder, only when the cover has to change:
#   Rscript R/cover.R
#
# The picture is the model that the book builds on (Chapter 4): the job satisfaction
# of the 20 employees of Organisation Beta explained by their salary, with the
# regression line in blue and the residuals in red.

source("R/setup.R")

# The words on the cover.
cover_title <- "Quantitative\nResearch\nMethods"
cover_subtitle <- "STA1005 course book"
# "\u00e9" is the letter e with an acute accent, written so that it reads the same on every computer.
cover_author <- "Damien Dupr\u00e9"
cover_affiliation <- "DCU Business School, Dublin City University"

# The font of the cover. If it is not installed on your computer, R uses its default font.
cover_font <- "Inter"

organisation_beta <- read_csv(here("data/organisation_beta.csv"), show_col_types = FALSE)

model_cover <- lm(js_score ~ salary, data = organisation_beta)

employees <- organisation_beta |>
  mutate(js_score_predicted = fitted(model_cover))

cover <- ggplot(employees, aes(x = salary, y = js_score)) +
  geom_segment(
    aes(xend = salary, yend = js_score_predicted),
    colour = book_col("red"), linewidth = 1.2
  ) +
  geom_smooth(
    method = "lm", formula = y ~ x, se = FALSE, fullrange = TRUE,
    colour = book_col("blue"), linewidth = 2.2
  ) +
  # A white ring keeps each point apart from the line and the residuals.
  geom_point(size = 6.6, colour = "white") +
  geom_point(size = 4.8, colour = book_col("ink")) +
  # The orange rule of the chapter titles, drawn along the top of the picture.
  annotate(
    "segment",
    x = -Inf, xend = Inf, y = Inf, yend = Inf,
    colour = book_col("orange"), linewidth = 2.4
  ) +
  scale_x_continuous(expand = expansion(mult = 0.06)) +
  scale_y_continuous(expand = expansion(mult = c(0.10, 0.16))) +
  coord_cartesian(clip = "off") +
  labs(
    title = cover_title,
    subtitle = cover_subtitle,
    caption = paste0(cover_author, "\n", cover_affiliation)
  ) +
  theme_void(base_family = cover_font) +
  theme(
    plot.background = element_rect(fill = "white", colour = NA),
    plot.title = element_text(
      face = "bold", size = 46, lineheight = 0.95, colour = book_col("ink"),
      margin = margin(b = 18)
    ),
    plot.subtitle = element_text(size = 17, colour = "#43464b", margin = margin(b = 26)),
    plot.caption = element_text(
      size = 14, lineheight = 1.25, hjust = 0, colour = book_col("ink"),
      margin = margin(t = 30)
    ),
    plot.title.position = "plot",
    plot.caption.position = "plot",
    plot.margin = margin(t = 60, r = 48, b = 48, l = 48)
  )

dir.create("images", showWarnings = FALSE)

ggsave("images/cover.png", cover, width = 1654, height = 2339, units = "px", dpi = 300)
