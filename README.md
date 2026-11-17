# Structural Equation Modeling Notes

Michael Hallquist's structural equation modeling notes and worked examples, maintained in Quarto.

The collection includes 28 lecture and tutorial documents spanning regression, matrix algebra, path analysis, psychometrics, EFA/CFA, full SEM, model fit and comparison, best practices, missing/categorical data, measurement invariance, MIMIC models, mediation/moderation, causal graphs, growth curves, multilevel SEM, and Bayesian SEM.

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

The [Bayesian SEM lecture](16_bayesian_sem/bayesian_sem.qmd) also reads archived
Mplus results by default and requires `MplusAutomation >= 1.3`. Its saved
posterior draws support the diagnostic plots without licensed software.
See its [archive notes](16_bayesian_sem/mplus_models/README.md) for provenance
and limitations of the timing illustration.

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

R chapters include `/scripts/matrix-rendering.qmd` before their setup chunk.
The shared renderer formats matrices, named lavaan matrix lists, ANOVA/model
comparison results, and selected fit-measure vectors as tables. It preserves
model-comparison test descriptions and leaves full model summaries unchanged.
Numbers use three decimal places, with scientific notation for nonzero values
that would otherwise round to zero. Table p-values below .001 display as
`< .001`; missing values remain `NA`.

Set `#| matrix.digits: 5` in a chunk to show more precision. End an expression
with the object itself rather than `print(object)` so knitr can format it;
explicit `print()` calls use R's console output. Use
`#| render: !expr knitr::normal_print` when a chunk needs the original console
presentation. Formatting does not change values used in calculations.

Original author and contributor credits are preserved in the notes and [about page](about.qmd). No additional license is imposed on third-party teaching figures, data, or adapted material.
