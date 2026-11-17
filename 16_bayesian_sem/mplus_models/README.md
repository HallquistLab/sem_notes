# Saved Bayesian SEM examples

These inputs, data, outputs, posterior draws, and timing cache accompanied
Michael Hallquist's Bayesian SEM draft in `bsem_lecture/mplus_models`.
The saved outputs identify Mplus 9.1 and were generated on November 15, 2026.
The lecture's default render reads them without running Mplus.

The `med_*` and `bami_*` examples were added and fitted with Mplus 9.1 on
November 16, 2026:

- `med_bayes.*`: synthetic observed-variable mediation (N = 100; R seed 1612),
  with explicit slope, intercept, and residual-variance priors.
- `med_draws.rds`: paired post-burn-in coefficient draws from both chains,
  including indirect and total effects, used for posterior summaries and plots.
  The lecture regenerates this compact file and removes the temporary
  `med_bparams.dat` when re-estimating.
- `bami_*`: synthetic two-group, four-indicator CFA (200 per group; R seed
  1611), comparing exact scalar invariance with difference-prior variances
  .0025, .01, and .04. Residual variances remain free across groups. Other
  free parameters use Mplus defaults; the examples isolate the difference
  priors and do not claim that those defaults suit every application.

The new fits use two chains and fixed budgets: 20,000 iterations for mediation
and 30,000 for invariance, discarding the first half as burn-in. Model inputs
and outputs retain the prior specifications and TECH8 convergence histories.

- `hs_*`: Grant-White subset of lavaan's Holzinger–Swineford data,
  standardized within the school; strict CFA and approximate-zero CFA.
- `sens_*`: six cross-loading prior variances for the same CFA.
- `hs_x9_draws.rds`: compact post-burn-in posterior draws for the focal
  cross-loading (`VISUAL BY X9`) used by the diagnostic chain plots.
- `ema_*`: synthetic repeated-measures data, fitted multilevel model,
  and person-level posterior summaries.
- `bench_*` and `quad_vs_bayes_bench_r6.rds`: saved timing illustration.
  Both ML and Bayes fit the same probit random-effects likelihood
  (`LINK = PROBIT;`). The d=4,5 ML times are 15^d extrapolations from d=3,
  not live runs.

Set `SEM_RUN_MPLUS=true` to opt into licensed re-estimation of all lecture
models, posterior draw excerpts, and timing runs. Set `MPLUS_COMMAND` if
`MplusAutomation::detectMplus()` cannot locate your executable automatically.
Regenerating results can change numerical summaries quoted in the prose.
Normal termination in a saved output is not a guarantee of adequate mixing;
the lecture discusses additional convergence and sensitivity checks.
