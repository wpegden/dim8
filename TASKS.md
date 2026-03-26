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
- [ ] Extend the proved wrappers in `PaperTheorems.lean` from the `E_8` lattice interface to the Section 4 `a`/`b` outputs and the `g_core_properties` split.
- [ ] Decide the proof source for the Section 5 sign lemmas (`Romik/Lee` replacement proof versus an in-repo certificate) before committing to the endgame for `g`.

## Completed
- [x] Read `repo/paper/arxiv-1603.04246.tex` from start to finish and performed a first mathematical audit.
- [x] Recorded initial corrections, proof dependencies, and open questions in `repo/PAPERNOTES.md`.
- [x] Checked the Section 5 frontier against later primary sources and confirmed that the interval-arithmetic step is replaceable, but the extra nonvanishing clause for `g` is not proved by the 2016 manuscript itself.
- [x] Wrote a comprehensive `PLAN.md` that separates the paper-faithful core from optional later-source extensions.
- [x] Added `PaperDefinitions.lean`, `PaperTheorems.lean`, and the initial support-module skeleton with paper-facing core definitions and theorem signatures.
- [x] Tightened the root `PaperDefinitions.lean` and `PaperTheorems.lean` files so they carry the real public statement surface: typed Schwartz/Fourier data on `R8`, the explicit linear combination defining `g`, non-tautological `E_8` interface statements, and standalone Lake build targets.
- [x] Separated the `E_8` lattice norm facts into `2ℕ` versus `2ℕ_{>0}`, exposed the Section 4 special values of `a` and `b` in the public theorem statements, and replaced the dimension-only main theorem wrapper with a packing-level statement over centers and density.
- [x] Strengthened the `g` interface so Fourier-side nonnegativity is stated as a real-valued nonnegativity condition, and added explicit double-zero clauses for the Section 4 public `a`/`b` statements.
