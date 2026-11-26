# STA1005 course book

A Quarto book written from the slides of STA1005, Quantitative Research Methods (DCU Business School). There is one chapter per lecture: chapter N is `lecture_N.qmd` in the `lectures` folder. The book renders to HTML, PDF and EPUB.

Claude (Anthropic) wrote the book in three passes:

1. **29 October 2026, first draft.** The chapters were drafted from the slides, then checked against them with a script (code, links, images, bold terms, formulas and numbers) and by reading.
2. **Language pass.** The academic-humanizer skill edited the wording of the text that I wrote (see "Language pass" below).
3. **12 November 2026, this version.** You asked for the book to be "even nicer with pictures and visualisation and call out blocks, and exercises". Your text is unchanged. Around it, each chapter now has figures drawn in R, boxes and numbered exercises with solutions, and Chapter 1 follows your current `lecture_1.qmd`. The next section gives the details.

Everything that this version adds was written by Claude, not taken from your slides. It was then checked by a second, independent pass (see "How the additions were checked"), but it is for you to review. The section "What to review" lists what needs your decision.

## What is new in this version

- **Figures.** 74 new figures explain an idea that the slides give in words: what a residual is, what the p-value measures, how VLOOKUP finds a value, what a chunk option hides. Seventy of them are drawn in R with ggplot2, from the data of the course or from a simulation with a seed, with one palette and one theme for the whole book (`R/setup.R`). Sketches say in their caption that they are not data. The other four are diagrams: the two flowcharts of your new slides in Chapter 1, and two models drawn in DOT for the exercises of Chapter 2.
- **Boxes.** Each chapter opens with an "In this chapter" box (what the reader can do afterwards, and what is needed). Along the text there are Definition, Example, how-to ("In jamovi", "In R", "In Excel"), "How to report" and "Common mistake" boxes. Your step lists and your reporting templates are now inside how-to and report boxes, word for word.
- **Exercises.** Each chapter ends with a section of numbered exercises, 70 in total, each followed by its solution (closed in the HTML book, printed in full in the PDF and the EPUB). They go from "True or false?" to tasks with the data and "Find the mistakes". Every number in a solution is computed by R when the book renders. Your "Your turn" exercises are unchanged.
- **R next to jamovi.** Chapters 4 to 6 have closed boxes called "In R: the same model", because Lecture 1 now names R as the language of the module. The jamovi steps are unchanged.
- **Chapter 1 follows your current slides.** New sections: Introducing Organisation Beta, the research paper written by AI (what came back, three papers from one prompt, the simulated employees, the placeholders, "Every number is right", the references, the AI shortcut, why the paper is not good, what is already happening, the rule of STA1005) and "AI as your Reviewer 2". The aim, the deadline and the two exercises that changed on the slides changed in the chapter too.
- **Your corrections of the slides of Lectures 2 to 8** are carried over where the chapter still had the old wording.
- **A cover and a new preface.** The cover is drawn by `R/cover.R` from the model of Chapter 4. It is the first page of the PDF, the cover of the EPUB and the picture on the first page of the HTML book. The preface has a map of the book and explains the boxes, the exercises and the colours.

What each chapter gained:

| Chapter | New figures | Definitions | Examples | Common mistakes | How-to and report boxes | Closed extras | Exercises |
|---|---|---|---|---|---|---|---|
| 1. Statistics, Research Papers and Me | 11 | 4 | 4 | 3 | 0 | 0 | 8 |
| 2. Understanding Models and Equations | 9 | 4 | 3 | 3 | 2 | 0 | 8 |
| 3. Collect, Clean, and Transform Data | 8 | 4 | 4 | 3 | 8 | 0 | 8 |
| 4. Understanding the General Linear Model | 11 | 3 | 3 | 1 | 5 | 2 | 8 |
| 5. Categories in the General Linear Model | 8 | 4 | 6 | 3 | 6 | 3 | 8 |
| 6. Assumptions of the General Linear Model | 11 | 6 | 2 | 2 | 5 | 3 | 8 |
| 7. Introduction to R for Hypothesis Testing | 7 | 5 | 2 | 7 | 7 | 1 | 8 |
| 8. Introduction to Quarto for Research | 5 | 6 | 2 | 4 | 3 | 0 | 8 |
| 9. Hypothesis Testing in Practice | 4 | 2 | 1 | 3 | 2 | 0 | 6 |
| **Total** | **74** | **38** | **27** | **29** | **38** | **9** | **70** |

The how-to and report boxes mostly hold your own step lists and reporting templates. The closed extras are the "In R: the same model" and "Going further" boxes. Chapter 1 also has four new tables that come from your new slides.

## How the additions were checked

- **Nothing of the earlier version is lost.** A script compared each chapter with its earlier version: every line, code chunk, label, image, equation and review note is still there, except the lines listed in "Lines of the earlier version that changed" below.
- **Every new figure was looked at** once rendered: in the HTML and the PDF by the writer of the chapter, then by the reviewer of the chapter and by me.
- **A second, independent pass per chapter** redid every exercise before reading its solution, recomputed the numbers of the additions in R from the data files, and checked each new statement, caption and figure. It made about thirty small corrections. The three that mattered most: in the figure of the chunk options of Chapter 8, `warning: false` also hides the messages in Quarto (tested by rendering); a sentence of Chapter 4 read lines that are close together as the sign of a non-significant interaction, where the sign is lines that are parallel; a sentence of Chapter 5 compared sums of squares where it meant mean squares. It found no wrong result in a solution, and two places where a question showed rounded values and its solution used the exact ones (Exercises 4.2 and 5.3, now consistent).
- **The palette was tested** for readers with a colour vision deficiency (see `R/setup.R`).

## Where it lives

The book has to stay in `ebook/`, next to the `data/` folder:

```
STA1005/
  data/                  data files read by the chapters
  lectures/              your slides, untouched
  ebook/                 this book
    _quarto.yml          book settings: parts, chapters, HTML, PDF and EPUB options
    index.qmd            preface
    lecture-01.qmd       one file per chapter, up to lecture-09.qmd
    R/setup.R            run by every chapter: packages, palette, plot theme and helpers
    R/cover.R            draws images/cover.png (run it only if the cover has to change)
    images/cover.png     the cover
    book.scss            HTML styling
    epub.css             EPUB styling
    strip-comments.lua   removes the review notes (HTML comments) from the HTML, PDF and EPUB output
```

The chapters read these files of `data/`: `organisation_beta.csv` (all chapters), `iqsize.txt` (Chapter 6), and for Chapter 3 `organisation_alpha.xlsx`, `unicef.xlsx`, `unicef_cleaned.csv` and `chess_llm.csv`.

`R/setup.R` calls `here::i_am("ebook/_quarto.yml")`, so that `here("data/...")` points at the `STA1005` folder (the one with `data/`) and not at `ebook/`. If you move the book, change that one line.

`_lecture-01-ai.qmd`, the conversion of your former `lecture_1_ai.qmd`, is no longer needed: its content is now in Chapter 1. I left the file where it is, because I do not delete files in your folders. You can delete it.

## Render

```bash
cd ebook
quarto render              # HTML, PDF and EPUB, written to _book/
quarto render --to html    # one format only
quarto preview             # live preview in the browser
```

## What you need

- **Quarto**. The book was built and tested with Quarto 1.10.19.
- **R** (4.5.3 here) with these packages. `papaja` is not on CRAN.

```r
install.packages(c(
  "rmarkdown", "tidyverse", "here", "knitr", "kableExtra", "gt", "patchwork",
  "ggrepel", "ggcorrplot", "gapminder", "broom", "scales", "readxl", "report",
  "performance", "see", "VennDiagram", "jmv"
))
remotes::install_github("crsh/papaja")
```

- **A LaTeX distribution** for the PDF, for example TinyTeX (`quarto install tinytex`). This version also uses the LaTeX package `tcolorbox` (for the exercises and the cover), which TinyTeX installs by itself at the first render.
- **Chrome or Chromium** for the PDF and the EPUB, because Quarto draws the DOT and Mermaid diagrams with it. If Quarto does not find one, run `quarto install chromium`.
- **An internet connection while rendering**. `include_img("file.png")` loads `https://raw.githubusercontent.com/damien-dupre/img/main/file.png`, so the images come from your `img` repository.

## How the chapters are written

- Each chapter starts with `# Title {#sec-lecture-NN}` and a hidden chunk that runs `source("R/setup.R")`.
- Labels start with the chapter number: `@sec-lNN-slug`, `@fig-lNN-slug`, `@tbl-lNN-slug`, `@eq-lNN-slug`, `@exr-lNN-slug`. Chapters are `@sec-lecture-NN`.
- Slide sections became sections and consecutive slides on one idea were merged into connected text.
- Code is hidden (`echo: false`) except in chunks that carry `#| echo: true`, where reading or typing the code is the lesson. Code that the slides show without running stays visible and is not run.
- UK English spelling, and no dashes in the text, as you asked.

**Boxes.** A box is a Quarto callout with a title and one class, which gives it its colour and its icon in the HTML book (`book.scss`) and in the EPUB (`epub.css`). In the PDF, a box keeps the colour of its callout type.

| Box | Opening line |
|---|---|
| Opening box of a chapter | `::: {.callout-note .box-goals title="In this chapter"}` |
| A term to know | `::: {.callout-note .box-definition title="Definition: residual"}` |
| The idea applied to the case | `::: {.callout-tip .box-example title="Example: ..."}` |
| A procedure, step by step | `::: {.callout-tip .box-howto title="In jamovi: ..."}` |
| The sentence for a results section | `::: {.callout-note .box-report title="How to report: ..."}` |
| An error that is easy to make | `::: {.callout-warning .box-mistake title="Common mistake: ..."}` |
| Optional extra, closed | `::: {.callout-note .box-further collapse="true" title="In R: the same model"}` |
| Exercise of the lecture | `::: {.callout-tip .box-yourturn title="Your turn: ..."}` |
| Solution, closed | `::: {.callout-note .box-solution collapse="true" title="Solution"}` |
| Shown live in class | `::: {.callout-note .box-demo title="Live demonstration"}` |
| End of chapter | `::: {.callout-note .box-keypoints title="Key points"}` |
| Your own "Warning" boxes | `::: {.callout-important title="Warning"}`, unchanged |

**Exercises.** An exercise is a numbered Quarto block, followed at once by its solution:

```
::: {#exr-l04-residuals}
## Residuals by hand

The question.
:::

::: {.callout-note .box-solution collapse="true" title="Solution"}
The answer.
:::
```

Quarto numbers it (Exercise 4.2) and `@exr-l04-residuals` refers to it. Do not put a figure or a table with a caption inside an exercise: it breaks the PDF. Put it just before the exercise.

**Figures.** Every figure drawn for the book is an R chunk with a label, a caption (`fig-cap`) and an alternative text (`fig-alt`). The colours come from `R/setup.R` and each one has a job, so that a figure can be read without its legend:

| Colour | `book_col()` | Job |
|---|---|---|
| Blue | `"blue"` | the model: regression lines, estimates, the alternative hypothesis |
| Red | `"red"` | what the model misses: residuals, errors, the null hypothesis |
| Orange | `"orange"` | the one element the text talks about, always with a label next to it |
| Grey | `"grey"` | background data |
| Ink | `"ink"` | points and all text |
| Green, purple | `"green"`, `"purple"` | a third and a fourth group |

Three shades of blue (`book_blues`) are used for an ordered variable (low, medium, high). In your own plot code, `"red"` and `"blue"` became `book_col("red")` and `book_col("blue")`; nothing else changed there.

**Helpers of `R/setup.R`** used by the new material: `theme_book()` (set for every plot), `flow_chart()` (a row of boxes joined by arrows), `format_p()` and `format_number()`, `report_fit(model)` and `report_estimate(model, "term")` (the sentences taught in Chapter 4, for inline use), `model_fit_table(model)` and `model_coefficients_table(model)` (the two jamovi tables, built from a model fitted with `lm()`).

## What to review

**Every doubt is in the source.** Each place where the slides are unclear, inconsistent, dated or where I had to choose has an HTML comment starting with `check:` (a few explanatory remarks start with `note:` or `layout:`). The filter `strip-comments.lua` removes them from the HTML, PDF and EPUB output, and the "View Source" panel of the HTML book is switched off (`code-tools: source: false` in `_quarto.yml`), so the notes cannot be read in the book or in its page source. To keep the notes in the output, delete the `filters` lines of `_quarto.yml`. If you want the "View Source" panel back, set `code-tools: true`, but it shows the notes unless you have deleted them from the chapters first. List the notes with:

```bash
grep -n -E "<!-- (check|note|layout):" *.qmd
```

The points that need a decision from you:

1. **The new boxes say things that your slides do not say.** A Definition or a Common mistake box gives the exact version of a statement in one or two sentences. Read them first: they are short, and they are where the book now speaks in your name. Search for `.box-definition` and `.box-mistake`.
2. **The exercises and their solutions are mine.** Check that their level and their length suit your students. To remove one, delete its `::: {#exr-...}` block and the Solution box after it.
3. **R in Chapters 4 to 6.** The boxes "In R: the same model" are closed by default. If you want these chapters in jamovi only, delete the boxes with the class `.box-further`.
4. **R or jamovi?** The slide "What to Expect?" of Lecture 1 now reads "Using open source coding language (R)" and no longer names jamovi, but Lectures 4 to 6 still teach the analyses with jamovi, and Lecture 9 asks for both. Chapter 1 and the preface follow the new slide.
5. **Dates.** Chapter 1 now gives the deadline as June 21st, 2027 (a Monday) and still says that the data come "in April". Chapter 9 still says "Wednesday, June 21st at 1 pm", without a year (21 June was a Wednesday in 2023).
6. **AI use statement.** Lecture 1 now asks students to disclose every use of AI. The preface does not say that this book was drafted by Claude. Add a statement if you want one (there is a comment at the end of `index.qmd`).
7. **A code fix in Lecture 1.** The slides use `mean(q1, q2, q3, q4)`, which returns only `q1` (the other values are read as the arguments `trim` and `na.rm`). I changed it to `mean(c(q1, q2, q3, q4))` in the two interaction plots. The points and slopes change (the slope drops from 0.110 to 0.023 per 1,000 of salary) but the Irish line is still steeper than the French one. Search for `mean(c(` to undo it.
8. **Slide statements that are not exact, kept as written.** I kept your wording and flagged each one with a `check:` comment. Where the new material touches one of them, a box gives the exact version next to your sentence. The most important:
   - **Lecture 5, sum to zero contrasts.** With the codes of the slides, the coefficients compare each category with the average of the three group means, not with France (the `sum_c1` estimate is 1.28, whereas Ireland minus France is 1.90). The same applies to the Placebo and Vaccine example (the coefficients would be -1 and 3, not 1 and 5).
   - **Lecture 5, rule 3 of the contrasts.** A 0 does not always leave a category out. Coding Ireland 1, France 0 and Australia 2 gives a slope of -0.11 that depends on France, and with the sum to zero codes of the slides the category coded 0 still counts. The rule holds when the model has a complete set of orthogonal contrasts, as the polynomial contrasts are.
   - **Lecture 5, default coding.** jamovi and R use dummy coding: the alphabetical order only chooses the reference level, coded 0, and not 1, 2, 3 (the intercept of 7.75 in the screenshot is the average of the high salary group).
   - **Lecture 5, ANOVA and post-hoc tests.** The distance of each value to the overall mean is the total variation, and the post-hoc table is Tukey-adjusted, which the sentence "corrections are not good practice" contradicts.
   - **Lecture 4, plot of the interaction.** The three lines of the screenshot are exactly parallel, so it seems to come from a model without the interaction (the interaction model of the chapter gives a gap between the +1SD and -1SD lines that goes from 0.44 to 0.10). Other points: the residuals sum to 0 (the criterion is the sum of squares), R cannot be negative, and the description of the p-value, the standard error and the confidence interval.
   - **Lecture 6.** Statistical power "refers to the fourth situation", which is the Type II error. In the code of the two figures on high leverage and high influence, the unusual point is the ninth of ten (x = 9), inside the range of the others, so both show an outlier that moves the line. The new three-panel figure draws the three cases with a point outside the range.
   - **Lecture 1.** "Categorical when its values are words" does not hold for codes written as numbers, such as the column `employee`. The third requirement of a mediation ("the effect must disappear") describes a full mediation only.
   - **Lecture 3.** The text says that in the long format "each variable keeps its own column", but the image `long_table.png` stacks cases and population in one pair of columns (key and value).
   - **Lecture 3, Excel menus.** "From Workbook or CSV" is called "From Text/CSV" in current versions of Excel, and "New Query" is the name used by Excel 2016. The chapter keeps your path.
   - **Lecture 7, `aov()`.** Printed on its own, `aov(lm_js)` gives no F and no p-value: `summary(aov(lm_js))` does, and each of its rows tests a predictor after the predictors written before it in the formula. A Common mistake box says so.
   - **Lectures 4 and 9, main effects in a model with an interaction.** With an interaction in the model, the row of each of its two predictors is the effect for the reference value of the other one (in the rehearsal of Chapter 9, the effect of performance for women, and the difference between men and women for a performance of 0). The solutions say so where it matters.

   **Where a new box or exercise gives another reading than one of these sentences.** Your sentence is still in the text and the box sits next to it. Chapter 5: the Definition of the reference level (dummy coding, not 1, 2, 3), the two Common mistake boxes on contrasts (the value 0, and sum to zero contrasts), and the items of Exercises 5.1 and 5.8 that practise them. Chapter 6: the Definition of statistical power (the first situation of your list, that is 1 minus the probability of the fourth) and the three-panel figure on anomalous data. Chapter 1: the Common mistake box on numbers that name a category. If you correct a sentence on your slides, the chapter can follow. If you prefer your wording, delete the box.
9. **Data files.** `chess_llm.csv` has seven columns of moves but six headings (the last column has no name), and its first heading is spelled `attemps`. `organisation_alpha.xlsx` already holds the answers of the "Your turn" of Lecture 3 (the `js_score` column, the `salary_2017` column made with VLOOKUP and the pivot tables). In the UNICEF "Your turn", "until column P" takes in life expectancy in 1970, whereas `unicef_cleaned.csv` stops at total fertility. The new exercises of Chapter 3 work with the files as they are and point out the first two.
10. **Lecture 9, link to the examples.** The link to the formatting examples points to `rticles`, the R Markdown templates, whereas Lecture 8 teaches the Quarto journal templates.
11. **Key points** boxes, the introductory paragraph of each chapter, the "In this chapter" boxes and the preface are my summaries of the chapter, not slide content.
12. **Part names** (Research papers, models and data; The General Linear Model; From analysis to report) and the cover are my choice. They are set in `_quarto.yml` and `R/cover.R`.

## Lines of the earlier version that changed

The script that checks that nothing is lost reports these lines, and only these. Each one is a correction that you made on the slides after the first draft, a line of Chapter 1 that follows your new slide, or a summary or note of mine that became more exact.

- **Chapter 1** (your new slide): the second aim of the module, the sentence of the introduction that announces the sections (it now mentions the paper written by AI), the deadline (the two notes about the 2026 date are gone), "send it to my email before the next lecture", "Send me both tables by email" with the comparison with an AI assistant, "non-EU employees", and my note on the solution that was numbered "Hypothesis 3" twice, which you corrected.
- **Chapter 2** (your corrections): "*increases*" became "*increase*" in the two alternative hypotheses about Exam Results, and "*stays the same*" became "*stay the same*" in the null hypothesis, as on the slide.
- **Chapter 3**: no line changed.
- **Chapter 4** (your correction): "certain types of hypothesis" became "certain types of hypotheses".
- **Chapter 5**: "certain types of hypothesis" became "certain types of hypotheses" and "Omnibus Test ANOVA test" became "Omnibus ANOVA Test" (your corrections). My last Key point and my review note on rule 3 of the contrasts now give the condition under which the rule holds.
- **Chapter 6** (your correction): "non linear" became "non-linear". A review note was added on the two figures on high leverage and high influence.
- **Chapter 7** (your corrections): "pdf or jpeg" became "PDF or JPEG", and the two comments "# Macos" became "# macOS".
- **Chapter 8** (your corrections): "voila" became "voilà" and "VScode" became "VS Code". The two notes that had no title now have one ("Other editors" and "The _site folder").
- **Chapter 9**: my review note on the deadline now refers to the 2027 date of Lecture 1.

## Language pass

The academic-humanizer skill was applied to the text that I wrote in the first draft: the introduction of each chapter, the Key points, the sentences that link slide bullets, and the preface. It split sentences of more than 30 words, replaced vague wording with content that is already in the chapter, and corrected a few slips of grammar. It left your own slide sentences as they were, apart from a few that I had joined into one long sentence and that are now split again. It did not change any number, equation, code chunk, label, cross-reference, link or image.

The text added on 12 November was written to the same standard (plain sentences, no filler, every number computed) but did not go through the skill.

## Images left out

Pictures hosted on other websites are not in the book. A broken address would make the PDF fail, and the pictures are not yours. Where they carry teaching content (screenshots, diagrams), the chapter describes them in words, and this version redraws two of them in R: the hourglass of a research paper (Chapter 1) and the targets of validity and reliability (Chapter 3). The closing slides (with the `404.gif` picture) are also left out, as are your DCU photo and three pictures from your own `img` repository: `map_about.png` (Lecture 1, About Me), `the_matrix.gif` (Lecture 7, "Time to enter ...") and `meme_error.webp` (Lecture 7, debugging). All the other pictures from your `img` repository are used, memes included.

To restore one of your own pictures, add a chunk like the other figures of the chapter, with `include_img("meme_error.webp")` as its code. For the others, add `![caption](address)` where it belongs. The addresses by lecture:

| Lecture | Slide | Address |
|---|---|---|
| 1 | About Me | https://www.dcu.ie/sites/default/files/styles/max_1300x1300/public/dcu_business_school_editor/2025-01/professional_picture.jpeg |
| 1 | Details on the Assignment | https://achonaonline.com/wp-content/uploads/2015/02/59369457.jpg |
| 1 | Anatomy of a Paper | https://explorable.com/sites/default/files/images/steps-of-the-scientific-method.jpg |
| 2 | A Bad Theory/Model | https://d3i71xaburhd42.cloudfront.net/2a3e4a3024bfc4df27db07a1d48f77a6f371b0c3/8-Figure1-1.png |
| 2 | Representing a Model | https://www.myofficetricks.com/wp-content/uploads/2020/09/myofficetricks.com_2020-09-23_01-58-57.gif |
| 2 | DotUML Extension for Google Docs | https://dotuml.com/img/googledocs.200.png |
| 2 | Representing an Equation | https://i.ytimg.com/vi/SRGaW3maK38/maxresdefault.jpg |
| 2 | Auto-LaTeX Equations for Google Docs | https://mathpix.com/images/google-docs-power-point2.webp |
| 2 | quiver | https://raw.githubusercontent.com/varkor/quiver/refs/heads/master/screenshots/title.png |
| 3 | Data Everywhere | https://www.memesmonkey.com/images/memesmonkey/f1/f1a0708d5337e2afa78b515520c6c5fd.jpeg |
| 3 | Collecting Data | https://i.imgflip.com/3jtxnx.jpg |
| 3 | Validity and Reliability | https://www.publichealthnotes.com/wp-content/uploads/2018/08/560px-Reliability_and_validity.svg_.png |
| 3 | An Essential Step | https://miro.medium.com/max/624/1*FAzumPnvzKUDolMG7SNcHw.png |
| 3 | Warning | https://www.excel-easy.com/data-analysis/images/filter/filter-result.png |
| 4 | Vocabulary | https://psyteachr.github.io/msc-data-skills/images/memes/glm_meme.png |
| 4 | Warning | https://www.jamovi.org/assets/header-logo.svg |
| 4 | p-hacking in Correlation Tables | https://media.makeameme.org/created/what-is-something-5ea39c449c.jpg |
| 5 | Vocabulary | https://psyteachr.github.io/msc-data-skills/images/memes/glm_meme.png |
| 5 | Hypotheses with Categorical Predictors | https://media.makeameme.org/created/what-if-i-8de3498d3a.jpg |
| 6 | Assumption 3: Normality | https://www.isixsigma.com/wp-content/uploads/2018/11/shelf_life_residuals_plots-400x165.png |
| 6 | Theoretical Principle | https://learning.eupati.eu/pluginfile.php/673/mod_book/chapter/388/eupati-types1-2-errors.png |
| 6 | Sample Size Estimation | https://www.psychologie.hhu.de/fileadmin/_processed_/f/d/csm_GPowerIcon_b6bfb17f0c.png |
| 6 | Always more homework | https://www.learnstatswithjamovi.com/images/bookcover.png |
| 7 | Posit Cloud | https://miro.medium.com/max/1400/1*JBHNRwGr3ZiyBzYWpvH6zg.png |
| 7 | Code in RStudio | https://c.tenor.com/0heitU7-tg4AAAAC/copy-paste-paste.gif |
| 7 | Environment: R's Brain | https://www.statology.org/wp-content/uploads/2021/10/envir1.png |
| 7 | Code Editor: R's Nervous System | https://miro.medium.com/max/1600/1*eLjON45R_kHIfg_IgL8FIg.jpeg |
| 7 | What are .R and .qmd files? | https://r4ds.hadley.nz/quarto/diamond-sizes-report.png |
| 7 | Assign Values to Objects in R | https://bookdown.org/introrbook/intro2r/images/chapter5/fig1.PNG |
| 7 | Open your Data as R Object (1) | https://community-cdn.rstudio.com/uploads/default/original/2X/9/91a128299a9d910f84279be9ecd89b60aa15f20b.png |
| 7 | Open your Data as R Object (2) | https://support.rstudio.com/hc/article_attachments/360017333414/data-import-rstudio-overview.gif |
| 8 | Simple Example | https://quarto.org/docs/tools/images/new-quarto-doc.png |
| 8 | Create the Output File | https://quarto.org/docs/get-started/hello/images/rstudio-render-button.png |
| 8 | Create the Output File | https://quarto.org/docs/get-started/hello/images/rstudio-render.png |
| 8 | Slide Decks | https://raw.githubusercontent.com/katiejolly/blog/master/assets/slide-design/twitter_img_march.png |
| 8 | CV | https://raw.githubusercontent.com/schochastics/quarto-cv/main/classic-cv.png |
| 8 | Quarto Websites | https://www.paulbarrs.com/wp-content/uploads/2017/09/painful.jpg |
| 8 | Quarto Websites | https://ucsb-meds.github.io/creating-quarto-websites/media/rendered_site.png |
| All | Closing slide | https://damien-dupre.github.io/assets/404.gif |

## Where the code differs from the slides

- Slide-size text settings (for example `theme(text = element_text(size = 20))`) are dropped, and the plot theme is set once in `R/setup.R`.
- The literal colours `"red"` and `"blue"` of your plots are now `book_col("red")` and `book_col("blue")`, the red and the blue of the palette.
- `grViz()` diagrams became Quarto `{dot}` chunks, and the Mermaid flowcharts of Lecture 1 run from top to bottom so that they stay legible on a page.
- Libraries that only serve the slides (`countdown`, `fontawesome`, `anicon`, `ggVennDiagram`) are not loaded, and neither is `papaja` in Lecture 6, where the slides load it without using it.
- The `mean()` fix of Lecture 1, described above.
- In Lecture 2, `$\LaTeX$` is written as plain LaTeX, because the logo command breaks the PDF and the EPUB.
- In Lecture 7, the text quotes the intercept as -49.1865081, as the code prints it, where the slide has -49.1865079 (there is a `check:` comment).

## What was not verified

- **papaja.** Chapters 4 and 5 print some results inline with `apa_print()` from `papaja`: `lm_1` and `lm_2` in Chapter 4, `lm_c`, `lm_c2` and `lm_c3` in Chapter 5. `papaja` could not be installed where the book was built, so those sentences were not produced by a real run. To test that the book builds, a stand-in function that imitates the format of `apa_print()` was used in test copies only. It is not in any chapter. Two reviewers computed by hand what `papaja` prints (for example `b = -1.87, 95% CI [-3.24, -0.50], t(18) = -2.88, p = .010` for the salary effect of Chapter 5) and all of them agree with the sentences around them. A recent `papaja` may also print a 90% confidence interval of R2. After your first render, compare the printed values with the jamovi tables of the same chapters. The new material does not use `papaja`: its sentences come from `report_fit()` and `report_estimate()` in `R/setup.R`.
- **jamovi, Excel, G\*Power and Posit Cloud.** None of them could be opened where the book was built. The new how-to boxes wrap your own steps, and the solutions of the exercises use the menu names of your slides. Where a solution names an option that your slides do not show, it is listed here: the "Reference Levels" option of the jamovi Linear Regression and the Tukey correction as the default of the jamovi post-hoc tests (Chapter 5, both taken from the `jmv` package), "Number Filters > Greater Than" and "Home > Close & Load" in Excel (Chapter 3), and the label of the gender row in the jamovi table of Chapter 9. `quarto use template` and GitHub Pages could not be run either (no access to GitHub).
- **Equations and fonts in the HTML book.** The equations are rendered by MathJax and the text is set in Montserrat. Both load from the internet and were blocked where the book was built, so the HTML pages were checked with another font and with the equations of the browser. The equations were checked in the PDF and the EPUB.
- **Links.** The links come from your slides and were not tested one by one, apart from the pictures. Some addresses may have moved.
- **The counts of the three AI papers** in Chapter 1 (words, references, p-values, lines of code, placeholders) come from your slides: the papers are not in the repository that I can see.
- **Alt text of diagrams.** Quarto does not pass the `fig-alt` text of `{dot}` and `{mermaid}` chunks to the HTML or EPUB output. It is kept in the source for when it does.
- **The EPUB in an e-reader.** I did not open it in one. EPUBCheck reports 49 errors for this version and no fatal one. All of them come from markup that Quarto and `gt` write (an `alt` attribute on the wrapper of some figures, `<style>` blocks and repeated ids in the `gt` tables) and from the link `http://mermaid-js.github.io/mermaid/##/` of Lecture 2. The EPUB has no pages for the three part titles, because Quarto leaves them out of EPUB books; the chapters are numbered 1 to 9.

## Known cosmetic points

- In the PDF, a box keeps the colour of its callout type (blue for notes, green for tips, orange for warnings): the box classes only style the HTML and the EPUB. Solutions and "Going further" boxes cannot be closed in the PDF and the EPUB, so they are printed in full.
- A data table that runs over a page break repeats its caption at the top of the next page in the PDF (for example in Chapter 5).
- Some figures leave white space under them in the PDF because figures stay where they are written.
- Chapter 2 plots use `ggrepel` labels, which move at each render because the slides set no seed. Several simulations of your slides (Chapters 4 and 6) set no seed either, so their figures change at each render. The simulations added in this version all set a seed.
- The figure of the chunk options of Chapter 8 describes Quarto 1.10, the version used here.
