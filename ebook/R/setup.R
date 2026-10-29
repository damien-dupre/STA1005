# Shared setup for every chapter of the STA1005 course book.
#
# Each chapter starts with a hidden chunk that runs: source("R/setup.R")
# Packages that only one chapter needs are attached in that chapter.
# This file is the single place for options and helpers shared by all chapters.

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

# Plots: one clean default theme for the whole book.
theme_set(theme_minimal(base_size = 12))

# Images ----------------------------------------------------------------------
# The lecture images live in the public repository damien-dupre/img.
# include_img("file.png") builds the address from this single location.
img_base_url <- "https://raw.githubusercontent.com/damien-dupre/img/main/"

include_img <- function(file, ...) {
  knitr::include_graphics(paste0(img_base_url, file), ...)
}
