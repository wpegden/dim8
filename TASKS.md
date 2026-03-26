# Tasks

<!-- SUPERVISOR_TASKS:START -->
## Supervisor Tasks
- [ ] Read `repo/paper/arxiv-1603.04246.tex` carefully from start to finish.
- [ ] Verify the mathematics of each proof, not just the statements.
- [ ] Record corrections, clarifications, and dependencies in `PAPERNOTES.md`.
- [ ] Report `STUCK` only for a genuine gap or incorrect statement after serious repair attempts.
<!-- SUPERVISOR_TASKS:END -->

## Worker Tasks
- [ ] Decide whether the formalization will replace Section 5's undocumented interval-arithmetic step with a later direct proof (Romik 2023 / Lee 2024) or with a new reproducible certificate.
- [ ] Split the paper-level theorem statements so the density theorem depends only on `g1`--`g3`, unless we explicitly import a later proof of the exact-zero/nonvanishing statement.
- [ ] Extract the exact definitions, hypotheses, and dependencies needed for `PaperDefinitions.lean` and `PaperTheorems.lean`.

## Completed
- [x] Read `repo/paper/arxiv-1603.04246.tex` from start to finish and performed a first mathematical audit.
- [x] Recorded initial corrections, proof dependencies, and open questions in `repo/PAPERNOTES.md`.
- [x] Checked the Section 5 frontier against later primary sources and confirmed that the interval-arithmetic step is replaceable, but the extra nonvanishing clause for `g` is not proved by the 2016 manuscript itself.
