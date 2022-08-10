require(knitr)
require(dplyr)
require(flextable)
require(ggplot2)

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

# Misc

wordnewpage <-
  '```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```'

ishtml <- knitr::is_html_output()
ispdf <- knitr::is_latex_output()
isword <- !ishtml & !ispdf

