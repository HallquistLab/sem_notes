# Run once from the repository root: Rscript scripts/install_packages.R
packages <- c(
  "AICcmodavg",
  "DT",
  "DiagrammeR",
  "KernSmooth",
  "MASS",
  "MplusAutomation",
  "corrplot",
  "dagR",
  "dagitty",
  "dplyr",
  "ggcorrplot",
  "ggplot2",
  "haven",
  "interactions",
  "jtools",
  "knitr",
  "lattice",
  "lavaan",
  "lm.beta",
  "lme4",
  "matrixcalc",
  "mlbench",
  "modelr",
  "mvtnorm",
  "nlme",
  "nonnest2",
  "ppcor",
  "psych",
  "psychTools",
  "patchwork",
  "readr",
  "relaimpo",
  "rmarkdown",
  "scales",
  "semPlot",
  "semTools",
  "texreg",
  "tidyr",
  "tibble",
  "tidyverse",
  "viridis",
  "yaml"
)
if ("--list" %in% commandArgs(trailingOnly = TRUE)) {
  cat(paste(paste0("any::", packages), collapse = ","), "\n", sep = "")
  quit(save = "no")
}
missing <- setdiff(packages, rownames(installed.packages()))
if (length(missing)) install.packages(missing, repos = "https://cloud.r-project.org")
if (packageVersion("MplusAutomation") < "1.3") {
  install.packages("MplusAutomation", repos = "https://cloud.r-project.org")
}
