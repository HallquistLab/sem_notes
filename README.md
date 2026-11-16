# Structural Equation Modeling Notes

Michael Hallquist's structural equation modeling notes and worked examples, maintained in Quarto.

The collection includes 27 lecture and tutorial documents spanning regression, matrix algebra, path analysis, psychometrics, EFA/CFA, full SEM, model fit and comparison, best practices, missing/categorical data, measurement invariance, MIMIC models, mediation/moderation, causal graphs, growth curves, and multilevel SEM.

## Use

Requirements: R (validated with 4.5.2), Quarto (validated with 1.11.9), and the R packages listed in `scripts/install_packages.R`.

```sh
git clone git@github.com:HallquistLab/sem_notes.git
cd sem_notes
Rscript scripts/install_packages.R
quarto render
quarto preview
```

Open `_site/index.html` after rendering. The repository stores editable sources and teaching assets; generated HTML, caches, and local environment files are ignored.

Mplus is optional: the multilevel chapter reads archived outputs unless `SEM_RUN_MPLUS=true`. Set `MPLUS_COMMAND` when its executable is outside your PATH. The factor-score simulation defaults to five replications per scenario; set `SEM_SIM_REPS` for a longer simulation. Each source file runs with its own directory as the working directory.

## Website deployment

The notes are published at <https://hallquistlab.github.io/sem_notes/>.
The `Publish course notes` GitHub Actions workflow renders and validates the
collection on every push to `main`, then deploys `_site` to GitHub Pages.
It can also be run manually from the repository's Actions tab. Pages uses
GitHub Actions as its publishing source (Settings → Pages → Source).

The workflow uses R 4.5.2, Quarto 1.11.9, and the package list in
`scripts/install_packages.R`. R dependencies are cached between builds.
Mplus examples use archived results, and simulations use five replications
per scenario, matching the local defaults. A failed build or validation
prevents deployment.

## Contributing

- Edit `.qmd` sources and render the collection before committing.
- Run `make render` for source checks, R syntax validation, rendering, and rendered-link checks.

Original author and contributor credits are preserved in the notes and [about page](about.qmd). No additional license is imposed on third-party teaching figures, data, or adapted material.
