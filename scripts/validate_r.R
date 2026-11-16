# Parse all R examples, including chunks that are intentionally not executed.
files <- list.files('.', pattern = '\\.qmd$', recursive = TRUE, full.names = TRUE)
files <- files[!grepl('/(_site|maintenance)/', files)]
for (file in files) {
  output <- tempfile(fileext = '.R')
  knitr::purl(file, output = output, quiet = TRUE)
  tryCatch(parse(output), error = function(e) stop(file, ': ', conditionMessage(e)))
  unlink(output)
}
cat('Parsed R code from', length(files), 'Quarto pages.\n')
