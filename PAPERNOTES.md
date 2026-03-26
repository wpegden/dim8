# Paper Notes

## Corrections And Clarifications
- Section 4, Proposition `a(r)` Fourier proof: the estimate
  `\int_i^{i\infty} \phi_0(z)e^{\pi i r^2 z}\,dz = C_3 e^{\pi(r^2+2)}/(r^2+2)`
  has the wrong sign in the exponent. It should decay like `e^{-\pi(r^2+2)}`.
- Section 4, Proposition `a another integral`: in the displayed elementary Laplace integral, the linear term should be
  `-(8640/\pi) t`, not `+(8640/\pi) t`; otherwise the displayed evaluation has the wrong sign.
- Section 4, Proposition `b(r)` double zeroes: in the second path-deformation identity, the first segment should run from `1` to `i`, not from `-1` to `i`.
- Section 4, Proposition `b another integral` proof: the sentence "Therefore, the identity \eqref{eqn: a another integral} holds for `r > sqrt 2`" should refer to `\eqref{eqn: b another integral}`.
- Section 2, after the Poisson-summation argument for `g`: the statement that `g` and `\hat g` have double zeroes at all lattice radii `> sqrt 2` uses an extra argument not written explicitly in the text. Once one knows `g(r) <= 0` (resp. `\hat g(r) >= 0`) on a neighborhood of such a radius and the function value is `0`, smooth radiality implies the first radial derivative also vanishes there.
- Section 4, Propositions `a another integral` and `b another integral`: the paper says both sides are analytic near `[0,\infty)` and therefore equal everywhere. For formalization, this needs to be unpacked as a cancellation statement: the explicit rational terms have poles at `r = 0` and `r = sqrt 2`, and the factor `sin(\pi r^2 / 2)^2` cancels them with the correct order.

## Proof Dependencies
- The proof of Theorem `g` reduces the sign conditions to `A(t) < 0` and `B(t) > 0`, but the decisive step is delegated to interval arithmetic with no script, no subdivision data, and no machine-checkable certificate in the paper. This is a real formalization dependency even if the claim is believable.
- The Section 5 inequality step is now known to be replaceable from later primary sources. Dan Romik, *On Viazovska's modular form inequalities* (2023), gives a fully human-checkable proof of the two required inequalities, and Seewoo Lee, *Algebraic proof of modular form inequalities for optimal sphere packings* (2024), gives another replacement proof. So this is an omission in the original manuscript, but probably not a mathematical obstruction for the overall project.
- The modular-form input actually used later is narrower than the expository Section 3: for Lean, the critical data are the explicit transformation laws, Fourier expansions, and coefficient-growth bounds for `phi_{-4}`, `phi_{-2}`, `phi_0`, `psi_I`, and `psi_S`.
- The uniqueness discussion in the introduction needs more than the packing bound itself. It depends on the stronger nonvanishing properties of `g` and `\hat g`, not just on the inequalities needed for the Cohn-Elkies argument.

## Open Questions
- The final proof of Theorem `g` does not justify the full claim that `g(x) != 0` whenever `||x||^2 \notin 2\Z_{>0}`. The argument written in the paper proves the sign of `g(r)` only for `r > sqrt 2`, while the theorem statement also covers `0 < r < sqrt 2`. I do not see a way to recover this from the paper's formulas alone without importing additional ideas, so this should be treated as a genuine proof gap in the manuscript's stronger "moreover" clause.
- Later work suggests the stronger statement is true even though it is not proved here: Nina Zubrilina, *Zeros of Optimal Functions in the Cohn-Elkies Linear Program* (2019), states that the optimal `E_8` function has roots exactly at `{sqrt(2n)}_{n >= 1}`. For formalization, this means the safe paper-faithful split is: the packing theorem uses only `g1`--`g3`, while the exact-zero/nonvanishing statement should be imported only from a later source or left out of the paper-level theorem file.
- Decide how to formalize or replace the paper's interval-arithmetic step for `A(t)` and `B(t)`. At minimum we need a reproducible certificate; alternatively, a later direct proof of these modular-form inequalities could replace the computer-assisted step.
