require(knitr)
require(dplyr)
require(flextable)
require(ggplot2)
require(kableExtra)

ishtml <- knitr::is_html_output()
ispdf <- knitr::is_latex_output()
isword <- !ishtml & !ispdf
if(ishtml) table.engine <- "flextable"
if(isword) table.engine <- "flextable"
if(ispdf) table.engine <- "kbl"

mapfigure <- function(title, id=NULL){
  require(ggmap)
  # bbox_dat <- c(left = -125, bottom = 42, right = -110, top = 50)
  # p <- ggmap(get_stamenmap(bbox_dat, zoom = 5, maptype="terrain-background")) 
  load(here::here("data", "pnwmap.rda"))
  p + ggtitle(title)
  if(!is.null(id)){
    load(here::here("data", "maplocs.rda"))
    if(!all(id %in% maplocs$id)) stop("mapfigure function: some of the id's are not in the maplocs data")
    points <- maplocs[maplocs$id %in% id,]  
    p +
      geom_point(data=points, alpha = .7, aes(x=lon, y=lat, size =5), color='red') +
      theme(legend.position="none")
  }
}

statusfigure <- function(title, id, x="YEAR", y="NUMBER_OF_SPAWNERS"){
  filename <- here::here("data", paste0(id, ".csv"))
  dat <- read.csv(filename, stringsAsFactors = FALSE)
  dat$x <- dat[[x]]
  dat$y <- log(dat[[y]])
  ggplot(dat, aes(x=x, y=y)) + 
    xlab("Year") +
    ylab("log(Spawners)") +
    ggtitle(title) +
    geom_line() +
    facet_wrap(~COMMON_POPULATION_NAME)
}

# Table functions



fixcols <- function(x){
  # fix _ and . in colname and make title format
  x <- stringr::str_replace_all(x, "_", " ")
  x <- stringr::str_replace_all(x, "[,]", " ")
  x <- stringr::str_to_title(x)
  x[x=="Esu"] <- "ESU"
  x[x=="Number Of Spawners"] <- "Spawners"
  x
}

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
    kableExtra::kable_styling(position = "center")
  if(n>8) kable_styling(x, latex_options = c("scale_down"))
  x
}
# Misc

wordnewpage <-
  '```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```'



