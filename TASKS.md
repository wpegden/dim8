# Tasks

<!-- SUPERVISOR_TASKS:START -->
## Supervisor Tasks
- [ ] Prove the target statements presented in `PaperTheorems.lean`.
- [ ] Keep reusable proof infrastructure in separate support files when that yields a cleaner project structure.
- [ ] Maintain `TASKS.md` and `PLAN.md` as the proof frontier moves.
- [ ] Keep sorrys within the configured policy.
- [ ] Do not introduce unapproved axioms.
<!-- SUPERVISOR_TASKS:END -->

## Worker Tasks
- [x] Replace the paper-facing `E_8` predicates with an actual internal lattice object and prove the first interface lemmas in `Dim8/E8Lattice.lean` (`e8SquaredNorm`, `e8PositiveSquaredNorm`, `e8MinimalDistance`).
- [ ] Use the now-defined modular inputs (`phi` layer, `h`, `psi_I`, `psi_T`, `psi_S`) to define the first raw `a` or `b` profile from the paper's integral formulas.
- [ ] Construct actual `PaperAWitness` and `PaperBWitness` data in separate Section 4 support files and use them to discharge the thin wrappers for `theoremAStatement` and `theoremBStatement`.
- [x] Make the proof source for the Section 5 sign lemmas explicit: default to Lee 2024's algebraic proof, with Romik 2023 as the fallback cross-check instead of undocumented interval arithmetic.
- [ ] Translate the chosen Lee 2024 source into proved Lean lemmas for the concrete kernel targets `PaperANeg` and `PaperBPos`.

## Completed
- [x] Read `repo/paper/arxiv-1603.04246.tex` from start to finish and performed a first mathematical audit.
- [x] Recorded initial corrections, proof dependencies, and open questions in `repo/PAPERNOTES.md`.
- [x] Checked the Section 5 frontier against later primary sources and confirmed that the interval-arithmetic step is replaceable, but the extra nonvanishing clause for `g` is not proved by the 2016 manuscript itself.
- [x] Wrote a comprehensive `PLAN.md` that separates the paper-faithful core from optional later-source extensions.
- [x] Added `PaperDefinitions.lean`, `PaperTheorems.lean`, and the initial support-module skeleton with paper-facing core definitions and theorem signatures.
- [x] Tightened the root `PaperDefinitions.lean` and `PaperTheorems.lean` files so they carry the real public statement surface: typed Schwartz/Fourier data on `R8`, the explicit linear combination defining `g`, non-tautological `E_8` interface statements, and standalone Lake build targets.
- [x] Separated the `E_8` lattice norm facts into `2ℕ` versus `2ℕ_{>0}`, exposed the Section 4 special values of `a` and `b` in the public theorem statements, and replaced the dimension-only main theorem wrapper with a packing-level statement over centers and density.
- [x] Strengthened the `g` interface so Fourier-side nonnegativity is stated as a real-valued nonnegativity condition, and added explicit double-zero clauses for the Section 4 public `a`/`b` statements.
- [x] Replaced the empty `Dim8/ModularFormsAux.lean` placeholder with actual Section 4 modular-form definitions for `E4`, `E6`, `varphi_{-2}`, `varphi_{-4}`, `phi_{-2}`, `phi_{-4}`, `phi_0`, and their positive-imaginary-axis evaluation helpers.
- [x] Finished the remaining Section 4 modular ingredients in `Dim8/ModularFormsAux.lean` by defining `theta_{00}`, `theta_{01}`, `theta_{10}`, `h`, `psi_I`, `psi_T`, and `psi_S`, and translated the paper's Section 5 kernels into the concrete Lean definitions `paperAKernel`, `paperBKernel`, `PaperANeg`, and `PaperBPos`.
