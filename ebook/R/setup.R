# Shared setup for every chapter of the STA1005 course book.
#
# Each chapter starts with a hidden chunk that runs: source("R/setup.R")
# Packages that only one chapter needs are attached in that chapter.
# This file is the single place for options, colours, the plot theme and the
# helpers shared by all chapters.

suppressPackageStartupMessages({
  library(tidyverse)
  library(knitr)
  library(kableExtra)
  library(here)
})

# Project root ----------------------------------------------------------------
# The book lives in STA1005/ebook/ and reads the course data from STA1005/data/.
# The here package treats a folder that contains _quarto.yml as a project root, so
# without this line here() would point to ebook/ instead of STA1005/.
# If the book folder is renamed or moved, this is the only line to change.
here::i_am("ebook/_quarto.yml")

# Numbers are never printed in scientific notation, as in the lecture slides.
options(scipen = 999)

# Colours ---------------------------------------------------------------------
# One palette for every figure of the book. The boxes of the book use the same
# values (book.scss, epub.css).
#
# Each colour has one job, so that a figure can be read without its legend:
#   blue   the model: regression lines, estimates, the alternative hypothesis
#   red    what the model misses: residuals, errors, the null hypothesis
#   green and purple: a third and a fourth group
#   orange a highlight: the one point, line or area the text talks about
#   ink    data points, axes and all text
#   grey   everything that should stay in the background
#
# blue, red, green and purple (in that order) are the colours for groups. Any two of
# them stay distinct for readers with a colour vision deficiency, on screen and in print
# (checked with a colour-difference test under simulated protanopia and deuteranopia).
# Orange is the accent of the lecture slides. It is light on a white page, so always
# put a label next to what it highlights and never use it for a group.
book_colours <- c(
  ink    = "#1a292c",
  grey   = "#8a9396",
  blue   = "#0072B2",
  red    = "#CC3311",
  green  = "#009E73",
  purple = "#882255",
  orange = "#eb811b"
)

# book_col("blue") returns "#0072B2"; book_col("blue", "red") returns both, in that order.
book_col <- function(...) {
  names_wanted <- c(...)
  unknown <- setdiff(names_wanted, names(book_colours))
  if (length(unknown) > 0) {
    stop("Unknown book colour: ", paste(unknown, collapse = ", "))
  }
  unname(book_colours[names_wanted])
}

# Three shades of the book blue for an ordered variable, from low to high
# (for example -1SD, Mean and +1SD). The middle shade is the book blue.
book_blues <- c(light = "#7FB0D6", medium = "#0072B2", dark = "#063F66")

# Plots -----------------------------------------------------------------------
# One theme for the whole book: white background, light grid, legend above the plot.
theme_book <- function(base_size = 12) {
  theme_minimal(base_size = base_size) +
    theme(
      text = element_text(colour = book_colours[["ink"]]),
      plot.title = element_text(face = "bold", size = rel(1.05)),
      plot.title.position = "plot",
      plot.subtitle = element_text(colour = "#43464b"),
      plot.caption = element_text(colour = "#43464b", hjust = 0),
      plot.caption.position = "plot",
      axis.title = element_text(colour = "#43464b"),
      axis.text = element_text(colour = "#43464b"),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_line(colour = "#e6e9ea", linewidth = 0.4),
      legend.position = "top",
      legend.justification = "left",
      legend.title = element_text(face = "bold", size = rel(0.9)),
      strip.text = element_text(face = "bold", hjust = 0, colour = book_colours[["ink"]]),
      plot.margin = margin(8, 12, 8, 8)
    )
}

theme_set(theme_book())

# Default colours of the most common layers, so that a plot written without any
# colour already follows the palette.
update_geom_defaults("point", list(colour = book_colours[["ink"]]))
update_geom_defaults("text", list(colour = book_colours[["ink"]]))
update_geom_defaults("label", list(colour = book_colours[["ink"]]))
update_geom_defaults("smooth", list(colour = book_colours[["blue"]]))

# Roadmaps --------------------------------------------------------------------
# flow_chart() draws a row of boxes joined by arrows. Chapters use it to show the
# steps that they follow. steps is a table with one row per box and two columns:
#   step    the name of the step (bold, one or two words)
#   detail  one or two short lines under the name (use "\n" to break the line)
# A row holds up to six boxes on the width of a page.
flow_chart <- function(steps) {
  boxes <- steps |>
    mutate(position = row_number())
  arrows <- boxes |>
    filter(position < max(position))

  ggplot(boxes, aes(x = position)) +
    geom_tile(
      aes(y = 0),
      width = 0.88, height = 1,
      fill = "#fdf0e1", colour = book_colours[["orange"]], linewidth = 0.6
    ) +
    geom_text(aes(y = 0.22, label = step), fontface = "bold", size = 3.6) +
    geom_text(aes(y = -0.17, label = detail), size = 3.3, colour = "#43464b", lineheight = 0.95) +
    geom_segment(
      data = arrows,
      aes(x = position + 0.455, xend = position + 0.545, y = 0, yend = 0),
      arrow = arrow(length = unit(0.14, "cm"), type = "closed"),
      colour = "#43464b", linewidth = 0.5
    ) +
    scale_x_continuous(expand = expansion(add = 0.05)) +
    scale_y_continuous(limits = c(-0.55, 0.55), expand = expansion(add = 0)) +
    theme_void()
}

# Images ----------------------------------------------------------------------
# The lecture images live in the public repository damien-dupre/img.
# include_img("file.png") builds the address from this single location.
img_base_url <- "https://raw.githubusercontent.com/damien-dupre/img/main/"

include_img <- function(file, ...) {
  knitr::include_graphics(paste0(img_base_url, file), ...)
}

# Reporting -------------------------------------------------------------------
# Helpers used in the solutions of the exercises. They write the results of a
# linear model in the format taught in Chapter 4:
#   an estimate:  b = ..., 95% CI [..., ...], t(df2) = ..., p = ...
#   a model:      R2 = ..., F(df1, df2) = ..., p = ...
# The text they return contains LaTeX maths, to be used inline: `r report_fit(model)`.

# A p-value in APA style: "p < .001" below 0.001, otherwise three decimals and no leading zero.
format_p <- function(p_value) {
  if (p_value < 0.001) {
    return("p < .001")
  }
  paste0("p = ", sub("^0", "", formatC(p_value, digits = 3, format = "f")))
}

# A number with a fixed number of decimals, as text: format_number(1.5) gives "1.50".
format_number <- function(x, digits = 2) {
  formatC(x, digits = digits, format = "f")
}

# A p-value as jamovi prints it in a table: "< .001" or three decimals.
format_p_table <- function(p_value) {
  if (p_value < 0.001) {
    return("< .001")
  }
  formatC(p_value, digits = 3, format = "f")
}

# One estimate of a model: report_estimate(model, "salary").
# term_name is the name of the row in the coefficients table of R, as shown by summary(model).
report_estimate <- function(model, term_name, digits = 2) {
  estimates <- broom::tidy(model, conf.int = TRUE)
  row <- estimates[estimates$term == term_name, ]
  if (nrow(row) != 1) {
    stop("No single estimate called '", term_name, "'. Available: ", paste(estimates$term, collapse = ", "))
  }
  paste0(
    "$b = ", format_number(row$estimate, digits), "$, ",
    "95% CI $[", format_number(row$conf.low, digits), ", ", format_number(row$conf.high, digits), "]$, ",
    "$t(", df.residual(model), ") = ", format_number(row$statistic, 2), "$, ",
    "$", format_p(row$p.value), "$"
  )
}

# The overall fit of a model: report_fit(model).
report_fit <- function(model) {
  fit <- broom::glance(model)
  paste0(
    "$R^2 = ", sub("^0", "", format_number(fit$r.squared, 2)), "$, ",
    "$F(", fit$df, ", ", fit$df.residual, ") = ", format_number(fit$statistic, 2), "$, ",
    "$", format_p(fit$p.value), "$"
  )
}

# The two tables that jamovi prints for a linear regression, built from a model
# fitted in R with lm(). The exercises use them to give or to check results.
# Every number is written with two decimals, as in jamovi.

# Model Fit Measures, with the Overall Model Test.
model_fit_table <- function(model) {
  fit <- broom::glance(model)
  tibble(
    R = format_number(sqrt(fit$r.squared)),
    `$R^2$` = format_number(fit$r.squared),
    F = format_number(fit$statistic),
    df1 = fit$df,
    df2 = fit$df.residual,
    p = format_p_table(fit$p.value)
  ) |>
    kable(align = "c")
}

# Model Coefficients, with the 95% confidence interval of each estimate.
# The rows keep the names that R gives to the estimates (for example salary:perf for an
# interaction), except the intercept, which is named as in jamovi.
model_coefficients_table <- function(model) {
  broom::tidy(model, conf.int = TRUE) |>
    transmute(
      Predictor = if_else(term == "(Intercept)", "Intercept", term),
      Estimate = format_number(estimate),
      SE = format_number(std.error),
      Lower = format_number(conf.low),
      Upper = format_number(conf.high),
      t = format_number(statistic),
      p = purrr::map_chr(p.value, format_p_table)
    ) |>
    kable(align = "lcccccc")
}
