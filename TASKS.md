# Tasks

<!-- SUPERVISOR_TASKS:START -->
## Supervisor Tasks
- [x] Create `PaperDefinitions.lean` with the definitions needed to state the paper results.
- [x] Create `PaperTheorems.lean` with theorem statements as close to the paper as Lean allows.
- [x] Keep the files easy for a human to compare against the paper.
- [x] Make both files syntactically valid Lean.
<!-- SUPERVISOR_TASKS:END -->

## Worker Tasks
- [ ] Replace the paper-facing `E_8` predicates with an actual internal lattice object and begin proving the interface lemmas in `Dim8/E8Lattice.lean`.
- [ ] Refine the abstract statement bundles in `PaperTheorems.lean` into proved theorems, starting with the `E_8` lattice interface and the `g_core_properties` split.
- [ ] Decide the proof source for the Section 5 sign lemmas (`Romik/Lee` replacement proof versus an in-repo certificate) before committing to the endgame for `g`.

## Completed
- [x] Read `repo/paper/arxiv-1603.04246.tex` from start to finish and performed a first mathematical audit.
- [x] Recorded initial corrections, proof dependencies, and open questions in `repo/PAPERNOTES.md`.
- [x] Checked the Section 5 frontier against later primary sources and confirmed that the interval-arithmetic step is replaceable, but the extra nonvanishing clause for `g` is not proved by the 2016 manuscript itself.
- [x] Wrote a comprehensive `PLAN.md` that separates the paper-faithful core from optional later-source extensions.
- [x] Added `PaperDefinitions.lean`, `PaperTheorems.lean`, and the initial support-module skeleton with paper-facing core definitions and theorem signatures.
- [x] Tightened the root `PaperDefinitions.lean` and `PaperTheorems.lean` files so they carry the real public statement surface: typed Schwartz/Fourier data on `R8`, the explicit linear combination defining `g`, non-tautological `E_8` interface statements, and standalone Lake build targets.
