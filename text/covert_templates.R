a = readLines("text/CRchum.qmd")
ids <- c("ICSRFchinook", "ICSRsthd", "ICUCchinook", "ICUCsthd", "LCchinook", "LCcoho", "LCsthd", "OCcoho", "UWchinook", "UWsthd")
nams <- c(
  "Interior Columbia Snake River Chinook", 
  "Interior Columbia Snake River Chinook steelhead", 
  "Upper Columbia Chinook", 
  "Upper Columbia steelhead", 
  "Lower Columbia Chinook", 
  "Lower Columbia coho", 
  "Lower Columbia steelhead", 
  "Oregon Coast coho", 
  "Upper Willamette Chinook", 
  "Upper Willamette steelhead")
for(i in 1:length(ids)){ #
  b <- paste0(a, collapse="\n")
  b <- stringr::str_replace_all(b, "CRchum", ids[i])
  b <- stringr::str_replace_all(b, "Columbia River Chum", nams[i])
  cat(b, file=here::here("text", paste0(ids[i], ".qmd")))
}