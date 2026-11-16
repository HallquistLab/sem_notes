# Default to the archived teaching results. Opt in to estimation explicitly.
sem_run_mplus <- function() {
  identical(tolower(Sys.getenv("SEM_RUN_MPLUS")), "true")
}

sem_mplus_command <- function() {
  cmd <- Sys.getenv("MPLUS_COMMAND", unset = "")
  if (nzchar(cmd)) return(cmd)
  tryCatch(MplusAutomation::detectMplus(), error = function(e) "mplus")
}

fit_mplus_example <- function(object, modelout) {
  if (sem_run_mplus()) {
    return(MplusAutomation::mplusModeler(
      object, modelout = modelout, run = TRUE, hashfilename = FALSE,
      Mplus_command = sem_mplus_command()
    ))
  }
  output <- sub("\\.inp$", ".out", modelout)
  if (!file.exists(output)) stop("Missing saved teaching output: ", output)
  object$results <- MplusAutomation::readModels(output, quiet = TRUE)
  object
}

load_or_fit_mplus_model <- function(syntax = NULL, data = NULL, dir, file_stem,
                                    run = sem_run_mplus(),
                                    replaceOutfile = "always", ...) {
  if (run) {
    m <- MplusAutomation::mplusModel(
      syntax = syntax,
      data = data,
      dir = dir,
      file_stem = file_stem,
      Mplus_command = sem_mplus_command(),
      ...
    )
    invisible(capture.output(m$run(replaceOutfile = replaceOutfile, logFile = NULL)))
    return(m)
  }
  out_file <- file.path(dir, paste0(file_stem, ".out"))
  if (!file.exists(out_file)) stop("Missing saved teaching output: ", out_file)
  withCallingHandlers(
    MplusAutomation::mplusModel(
      dir = dir,
      file_stem = file_stem,
      Mplus_command = sem_mplus_command()
    ),
    warning = function(w) {
      if (grepl("Mplus_command does not point to a valid location", conditionMessage(w), fixed = TRUE)) {
        invokeRestart("muffleWarning")
      }
    }
  )
}
