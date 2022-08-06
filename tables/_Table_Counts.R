ishtml <- knitr::is_html_output()
ispdf <- knitr::is_latex_output()
isword <- !ishtml & !ispdf

fixcols <- function(x){
  # fix _ and . in colname and make title format
  x <- stringr::str_replace_all(x, "_", " ")
  x <- stringr::str_replace_all(x, "[,]", " ")
  x <- stringr::str_to_title(x)
  x[x=="Esu"] <- "ESU"
  x[x=="Number Of Spawners"] <- "Spawners"
  x
}

wordnewpage <-
  '```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```'

readTableCounts <- function(datafile){
  filful <- here::here("data", datafile)
  modtime <- system(paste("git log -1 --format=%cd", filful), intern=TRUE)
  counts <- read.csv(filful, stringsAsFactors=FALSE)
  colnames(counts) <- fixcols(colnames(counts))
  return(list(counts=counts, modtime=modtime))
}