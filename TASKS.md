# Tasks

<!-- SUPERVISOR_TASKS:START -->
## Supervisor Tasks
- [ ] Use `repo/paper/arxiv-1603.04246.tex`, `PAPERNOTES.md`, and the current repo state to build `PLAN.md`.
- [ ] Produce a comprehensive roadmap for definitions, theorem statements, and proof dependencies.
- [ ] Identify what can come from mathlib versus what must be formalized here.
- [ ] Use `NEED_INPUT` for external-result or design-choice questions that need a human decision.
<!-- SUPERVISOR_TASKS:END -->

## Worker Tasks
- [ ] Create `PaperDefinitions.lean` and internal support modules following `PLAN.md`.
- [ ] Choose and implement the internal definition of the `E_8` lattice, then prove equivalence with the paper's coordinate description.
- [ ] Decide the source route for the Section 5 sign lemmas (`Romik/Lee` replacement proof versus an in-repo certificate) before deep proof work starts.

## Completed
- [x] Read `repo/paper/arxiv-1603.04246.tex` from start to finish and performed a first mathematical audit.
- [x] Recorded initial corrections, proof dependencies, and open questions in `repo/PAPERNOTES.md`.
- [x] Checked the Section 5 frontier against later primary sources and confirmed that the interval-arithmetic step is replaceable, but the extra nonvanishing clause for `g` is not proved by the 2016 manuscript itself.
- [x] Wrote a comprehensive `PLAN.md` that separates the paper-faithful core from optional later-source extensions.
