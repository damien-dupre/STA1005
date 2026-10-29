# STA1005 course book

A Quarto book written from the slides of STA1005, Quantitative Research Methods (DCU Business School). There is one chapter per lecture: chapter N is `lecture_N.qmd` in the `lectures` folder. The book renders to HTML, PDF and EPUB.

Claude (Anthropic) drafted the chapters from the slides, then checked each one against its slides with a script (code, links, images, bold terms, formulas and numbers) and by reading it. It is a first draft for you to review, not a finished text. The section "What to review" below lists what needs your decision.

## Where it lives

The book has to stay in `ebook/`, next to the `data/` folder:

```
STA1005/
  data/                  data files read by the chapters (organisation_beta.csv, iqsize.txt)
  lectures/              your slides, untouched
  ebook/                 this book
    _quarto.yml          book settings: parts, chapters, HTML, PDF and EPUB options
    index.qmd            preface
    lecture-01.qmd       one file per chapter, up to lecture-09.qmd
    _lecture-01-ai.qmd   Lecture 1 rewritten for the AI revamp (not rendered, see below)
    R/setup.R            run by every chapter: packages, plot theme, include_img()
    book.scss            HTML styling
    epub.css             EPUB styling
    strip-comments.lua   removes the review notes (HTML comments) from the HTML, PDF and EPUB output
```

`R/setup.R` calls `here::i_am("ebook/_quarto.yml")`, so that `here("data/...")` points at the `STA1005` folder (the one with `data/`) and not at `ebook/`. If you move the book, change that one line.

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
  "ggrepel", "ggcorrplot", "gapminder", "broom", "report", "performance", "see",
  "VennDiagram", "jmv"
))
remotes::install_github("crsh/papaja")
```

- **A LaTeX distribution** for the PDF, for example TinyTeX (`quarto install tinytex`).
- **Chrome or Chromium** for the PDF and the EPUB, because Quarto draws the DOT and Mermaid diagrams with it. If Quarto does not find one, run `quarto install chromium`.
- **An internet connection while rendering**. `include_img("file.png")` loads `https://raw.githubusercontent.com/damien-dupre/img/main/file.png`, so the images come from your `img` repository.

## How the chapters are written

- Each chapter starts with `# Title {#sec-lecture-NN}` and a hidden chunk that runs `source("R/setup.R")`.
- Labels start with the chapter number: `@sec-lNN-slug`, `@fig-lNN-slug`, `@tbl-lNN-slug`, `@eq-lNN-slug`. Chapters are `@sec-lecture-NN`.
- Slide sections became sections and consecutive slides on one idea were merged into connected text.
- Callouts: `Your turn` (exercise, with the suggested time), `Solution` (closed by default), `Warning`, `Live demonstration` (what is shown live in class) and `Key points` (end of every chapter).
- Code is hidden (`echo: false`) except in chunks that carry `#| echo: true`, where reading or typing the code is the lesson. Code that the slides show without running stays visible and is not run.
- UK English spelling, and no dashes in the text, as you asked.

## What to review

**Every doubt is in the source.** Each place where the slides are unclear, inconsistent, dated or where I had to choose has an HTML comment starting with `check:` (three explanatory remarks start with `note:` or `layout:`). The filter `strip-comments.lua` removes them from the HTML, PDF and EPUB output, and the "View Source" panel of the HTML book is switched off (`code-tools: source: false` in `_quarto.yml`), so the notes cannot be read in the book or in its page source. To keep the notes in the output, delete the `filters` lines of `_quarto.yml`. If you want the "View Source" panel back, set `code-tools: true`, but it shows the notes unless you have deleted them from the chapters first. List the notes with:

```bash
grep -n -E "<!-- (check|note|layout):" *.qmd
```

The points that need a decision from you:

1. **Dates.** Lecture 1 says the deadline is "June 21st, 2026" (a Sunday) and that the data come "in April". Lecture 9 says "Wednesday, June 21st at 1 pm" (21 June was a Wednesday in 2023). The AI revamp asks for the deadline to be updated for 2026-2027. All three are kept as written.
2. **Lecture 1.** Chapter 1 is built from the original `lecture_1.qmd`. The AI revamp (`lecture_1_ai.qmd`) is converted too, as `_lecture-01-ai.qmd`. To use it, from `ebook/`:

   ```bash
   mv lecture-01.qmd _lecture-01-original.qmd
   mv _lecture-01-ai.qmd lecture-01.qmd
   ```

   The AI revamp adds rules that the slides mark as PROPOSED (an AI use statement, the Quarto file with the paper, the 6-page limit), which Chapter 9 does not mention yet. The instructor-only "Ideas Bank" appendix of that deck is not in the book.
3. **A code fix in Lecture 1.** The slides use `mean(q1, q2, q3, q4)`, which returns only `q1` (the other values are read as the arguments `trim` and `na.rm`). I changed it to `mean(c(q1, q2, q3, q4))` in the two interaction plots, in both versions. The points and slopes change (the slope drops from 0.110 to 0.023 per 1,000 of salary) but the Irish line is still steeper than the French one. Search for `mean(c(` to undo it.
4. **A sentence that is not on a slide.** Chapter 4 says that the Organisation Beta data are not real and were simulated for 20 employees. It comes from the simulation code that is commented out in `lecture_4.qmd`.
5. **Slide statements that are not exact, kept as written.** Two independent reviewers recomputed Chapters 4 and 5 in R and found no wrong number, but they found statements in the slides that are inexact. I kept your wording and flagged each one with a `check:` comment. The most important:
   - **Lecture 5, sum to zero contrasts.** With the codes of the slides, the coefficients compare each category with the average of the three group means, not with France (the `sum_c1` estimate is 1.28, whereas Ireland minus France is 1.90). The same applies to the Placebo and Vaccine example (the coefficients would be -1 and 3, not 1 and 5).
   - **Lecture 5, rule 3 of the contrasts.** A 0 does not ignore a category unless the codes of the contrast sum to zero (coding Ireland 1, France 0 and Australia 2 gives a slope of -0.11 that depends on France).
   - **Lecture 5, default coding.** jamovi and R use dummy coding: the alphabetical order only chooses the reference level, coded 0, and not 1, 2, 3 (the intercept of 7.75 in the screenshot is the average of the high salary group).
   - **Lecture 5, ANOVA and post-hoc tests.** The distance of each value to the overall mean is the total variation, and the post-hoc table is Tukey-adjusted, which the sentence "corrections are not good practice" contradicts.
   - **Lecture 4, plot of the interaction.** The three lines of the screenshot are exactly parallel, so it seems to come from a model without the interaction (the interaction model of the chapter gives a gap between the +1SD and -1SD lines that goes from 0.44 to 0.10). Other points: the residuals sum to 0 (the criterion is the sum of squares), R cannot be negative, and the description of the p-value, the standard error and the confidence interval.
   - **Lecture 6.** Statistical power "refers to the fourth situation", which is the Type II error.
6. **Key points** boxes and the introductory paragraph of each chapter are my summaries of the chapter, not slide content.
7. **Part names** (Research papers, models and data; The General Linear Model; From analysis to report) are my choice. They are set in `_quarto.yml`.
8. **AI use statement.** Your AI revamp asks students to disclose every use of AI. The preface does not say that this book was drafted by Claude. Add a statement if you want one (there is a comment at the end of `index.qmd`).

## Images left out

Pictures hosted on other websites are not in the book. A broken address would make the PDF fail, and the pictures are not yours. Where they carry teaching content (screenshots, diagrams), the chapter describes them in words. The closing slides (with the `404.gif` picture) are also left out, as are your DCU photo and three pictures from your own `img` repository: `map_about.png` (Lecture 1, About Me), `the_matrix.gif` (Lecture 7, "Time to enter ...") and `meme_error.webp` (Lecture 7, debugging). All the other pictures from your `img` repository are used, memes included.

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
- `grViz()` diagrams became Quarto `{dot}` chunks, and the two Mermaid flowcharts of Lecture 1 (original version) run from top to bottom so that they stay legible on a page.
- Libraries that only serve the slides (`countdown`, `fontawesome`, `anicon`, `ggVennDiagram`) are not loaded, and neither is `papaja` in Lecture 6, where the slides load it without using it.
- The `mean()` fix of Lecture 1, described above.
- In Lecture 2, `$\LaTeX$` is written as plain LaTeX, because the logo command breaks the PDF and the EPUB.
- In Lecture 7, the text quotes the intercept as -49.1865081, as the code prints it, where the slide has -49.1865079 (there is a `check:` comment).

## What was not verified

- **papaja.** Chapters 4 and 5 print some results inline with `apa_print()` from `papaja`: `lm_1` and `lm_2` in Chapter 4, `lm_c`, `lm_c2` and `lm_c3` in Chapter 5. `papaja` could not be installed where the book was built, so those sentences were not produced by a real run. To test that the book builds, a stand-in function that imitates the format of `apa_print()` was used in test copies only. It is not in any chapter. Two reviewers computed by hand what `papaja` prints (for example `b = -1.87, 95% CI [-3.24, -0.50], t(18) = -2.88, p = .010` for the salary effect of Chapter 5) and all of them agree with the sentences around them. A recent `papaja` may also print a 90% confidence interval of R2. After your first render, compare the printed values with the jamovi tables of the same chapters.
- **Equations in the HTML book.** They are rendered by MathJax, which loads from the internet and was blocked where the book was built. The equations were checked in the PDF and the EPUB.
- **Links.** The links come from your slides and were not tested one by one, apart from the pictures. Some addresses may have moved.
- **Alt text of diagrams.** Quarto does not pass the `fig-alt` text of `{dot}` and `{mermaid}` chunks to the HTML or EPUB output. It is kept in the source for when it does.
- **Numbers recomputed in R**: Chapter 1 (both versions), Chapter 4 and Chapter 5 (every value read from your jamovi screenshots, tables, figures and inline results, by two reviewers who had not written the chapters), Chapter 6 (correlations, VIFs, AIC, power analyses) and the fix of the `mean()` code. Chapters 2, 3, 7, 8 and 9 were compared with the slides by a script (code, links, images, bold terms, formulas and numbers) and by reading, not recomputed.
- **The EPUB in an e-reader.** I did not open it in one. EPUBCheck reports 49 errors, in Chapters 1, 2, 3, 4 and 6, all caused by markup that Quarto and `gt` write (an `alt` attribute on the figure wrapper of the diagrams, `<style>` blocks, and repeated ids in the `gt` tables and in the diagrams) and by the link `http://mermaid-js.github.io/mermaid/##/` of Lecture 2. The images keep their alt text. The EPUB has no pages for the three part titles, because Quarto leaves them out of EPUB books; the chapters are numbered 1 to 9.

## Known cosmetic points

- The 12-column data table of Lecture 1 (AI version) wraps its cells in the PDF.
- A data table that runs over a page break repeats its caption at the top of the next page in the PDF (for example in Chapter 5).
- Some figures leave white space under them in the PDF because figures stay where they are written.
- Chapter 2 plots use `ggrepel` labels, which move at each render because the slides set no seed.
