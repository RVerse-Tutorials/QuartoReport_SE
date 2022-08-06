library(knitr)
library(kableExtra)
library(xtable)
library(flextable)
library(dplyr)

ishtml <- knitr::is_html_output()
ispdf <- knitr::is_latex_output()
isword <- !ishtml & !ispdf
if(ishtml | isword) table.engine <- "flextable"
if(ispdf) table.engine <- "kbl"

myflextable <- function(x){
  if(inherits(x, "data.frame")){
    x <- flextable(x)
  }
  if(isword){
    x <- x %>% font(fontname="Times New Roman", part="all") %>%
      fontsize(size=12)
  }
  n <- ncol_keys(x)
  x %>% 
    autofit() %>%
    add_footer_row(values = "flextable", colwidths = n)
}
mykbl <- function(x, caption = NULL){
  n <- ncol(x)
  x <- kbl(x, booktabs = TRUE, caption = caption) %>%
    kableExtra::footnote(general = "kable") %>%
    kable_styling(position = "center")
    if(n>8) kable_styling(x, latex_options = c("scale_down"))
  x
 }