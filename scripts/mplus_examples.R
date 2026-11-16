# Default to the archived teaching results. Opt in to estimation explicitly.
fit_mplus_example <- function(object, modelout) {
  if (identical(tolower(Sys.getenv("SEM_RUN_MPLUS")), "true")) {
    return(MplusAutomation::mplusModeler(
      object, modelout = modelout, run = TRUE, hashfilename = FALSE,
      Mplus_command = Sys.getenv("MPLUS_COMMAND", "mplus")
    ))
  }
  output <- sub("\\.inp$", ".out", modelout)
  if (!file.exists(output)) stop("Missing saved teaching output: ", output)
  object$results <- MplusAutomation::readModels(output, quiet = TRUE)
  object
}
