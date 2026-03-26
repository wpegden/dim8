# Formalization Plan

## Scope And Source Policy
- Default target: formalize the 2016 paper faithfully, with no axioms and no silent import of later results.
- Paper-faithful core:
  - the `E_8` lattice setup in dimension `8`,
  - the Cohn-Elkies-to-packing implication needed by the paper,
  - the construction of `a`, `b`, and `g`,
  - the theorem that `g` satisfies `g1`--`g3`,
  - the final packing theorem for dimension `8`.
- Explicitly excluded from the paper-faithful core:
  - the stronger exact-zero / nonvanishing clause for `g` on `0 < r < sqrt 2`,
  - the uniqueness of the densest periodic packing.
- Optional later-source extensions:
  - replace the undocumented interval-arithmetic step in Section 5 with Romik 2023 or Lee 2024,
  - import a later exact-root theorem (for example Zubrilina 2019) before exposing the stronger nonvanishing statement.

## Public Lean Surface
- `Dim8/PaperDefinitions.lean`
  - re-export the paper-facing definitions needed to state theorems cleanly.
  - keep statements close to the paper, but allow internal helper modules to use more convenient encodings.
- `Dim8/PaperTheorems.lean`
  - re-export only the proved paper-faithful theorem statements by default.
  - put later-source strengthening behind separate theorem names or a separate extension module.

## Proposed Internal Module Layout
- `Dim8/E8Lattice.lean`
  - ambient space `R8 := Fin 8 → ℝ`,
  - internal definition of the `E_8` lattice,
  - equivalence with the paper's coordinate description,
  - norm, parity, minimal norm, covolume, self-duality facts.
- `Dim8/PackingBounds.lean`
  - density notions, admissible/radial/optimal predicates,
  - the specialized Cohn-Elkies bound used at the end.
- `Dim8/FourierAux.lean`
  - reusable Schwartz/Fourier/scaling/radial lemmas,
  - Gaussian Fourier transform and lattice Poisson lemmas specialized to `R8`.
- `Dim8/ModularFormsAux.lean`
  - the explicit upper-half-plane functions actually used later:
    `phi_{-4}`, `phi_{-2}`, `phi_0`, `psi_I`, `psi_T`, `psi_S`.
  - transformation formulas, q-expansions, and coefficient-growth bounds only as needed.
- `Dim8/AuxiliaryFunctions.lean`
  - definitions of `a`, `b`, `g`,
  - Fourier eigenvalue lemmas, double-zero formulas, special values.
- `Dim8/Section5Signs.lean`
  - named obligations `A_neg` and `B_pos`,
  - source-tagged proof route for the sign inequalities.
- `Dim8/PaperDefinitions.lean`
  - light re-export layer over the internal modules.
- `Dim8/PaperTheorems.lean`
  - light re-export layer for the final theorem statements.

## Mathlib Reuse Plan
- Euclidean / finite-dimensional linear algebra:
  - `Mathlib.Geometry.Euclidean.Basic`
  - `Mathlib.Analysis.InnerProductSpace.EuclideanDist`
- Lattices and covolume:
  - `Mathlib.Algebra.Module.ZLattice.Basic`
  - `Mathlib.Algebra.Module.ZLattice.Covolume`
- Schwartz functions, Fourier transform, Poisson summation:
  - `Mathlib.Analysis.Distribution.SchwartzSpace.Basic`
  - `Mathlib.Analysis.Distribution.SchwartzSpace.Fourier`
  - `Mathlib.Analysis.Fourier.PoissonSummation`
  - `Mathlib.Analysis.SpecialFunctions.Gaussian.FourierTransform`
- Modular forms / upper half-plane:
  - `Mathlib.Analysis.Complex.UpperHalfPlane.Basic`
  - `Mathlib.NumberTheory.ModularForms.EisensteinSeries.E2.Defs`
  - `Mathlib.NumberTheory.ModularForms.EisensteinSeries.E2.Transform`
  - `Mathlib.NumberTheory.ModularForms.JacobiTheta.OneVariable`
- Expected local wrappers despite mathlib support:
  - convenient names for the specific level-one Eisenstein series used as `E4` and `E6`,
  - the paper's theta-constant combinations and weakly holomorphic combinations,
  - the paper's exact q-expansion lemmas with the needed coefficients.

## Reusable Definitions To Introduce Early
- Ambient space and norms:
  - `R8 := Fin 8 → ℝ`
  - helper lemmas for `‖x‖^2`, inner products, and radial functions.
- Lattice-level definitions:
  - internal `E8Lattice : Submodule ℤ R8`,
  - scaled lattice for sphere centers,
  - paper-facing membership characterization matching the TeX definition.
- Analytic predicates:
  - `Radial`, if mathlib's existing style is not sufficient for clean statements,
  - `Admissible` in the paper's decay sense,
  - `OptimalPackingFunction` or a similarly named predicate for the Cohn-Elkies endgame.
- Explicit functions:
  - the modular-form combinations,
  - `a`, `b`, `g`,
  - the scalar kernels `A(t)` and `B(t)` used in Section 5.

## Statement Split For PaperTheorems
- Paper-faithful theorem set:
  - `e8_lattice_characterization`
  - `e8_minimal_sq_norm`
  - `a_fourier`, `a_double_zero_formula`, `a_special_values`
  - `b_fourier`, `b_double_zero_formula`, `b_special_values`
  - `g_core_properties`:
    - `g(x) <= 0` for `‖x‖ >= sqrt 2`,
    - `𝓕 g(x) >= 0` for all `x`,
    - `g(0) = 1` and `𝓕 g(0) = 1`
  - `sphere_packing_bound_dim8`
- Separate optional theorem set:
  - `g_nonvanishing_off_even_norm_sq`
  - uniqueness / periodic-packing corollaries

## Dependency-Driven Proof Roadmap
- Track 0: ambient space and `E_8`
  - Choose a proof-friendly internal definition of `E_8` first.
  - Preferred default: define `E_8` from an explicit root basis or explicit `ℤ`-basis matrix, then prove equivalence with the paper's parity-and-half-integral description.
  - Reason: covolume, unimodularity, and minimal-norm proofs are cleaner from a basis than directly from the set description.
- Track 1: packing-bound infrastructure
  - Isolate the exact Cohn-Elkies theorem needed by the paper in a dedicated module.
  - Do not bury this dependency inside the final theorem; the paper cites it rather than proving it, so the Lean development must track it explicitly.
  - End product: a theorem that turns the existence of `g` with `g1`--`g3` into the dimension-8 density bound.
- Track 2: Fourier/Schwartz helper library
  - Build the finite-dimensional Fourier API actually used in the paper:
    scaling,
    Fourier of Gaussians,
    radial evaluation conventions,
    Poisson summation over `E_8` or an equivalent pullback to `ℤ^8`.
  - Prove the "double zero from sign plus equality in Poisson summation" lemma once and reuse it.
- Track 3: modular-form support actually needed
  - Do not formalize all of Section 3 wholesale.
  - Formalize only the explicit identities later invoked in Section 4:
    `E2` transform,
    theta transforms,
    Jacobi identity,
    q-expansions,
    coefficient-growth bounds.
  - Use mathlib's `UpperHalfPlane`, `E2`, and Jacobi theta machinery where possible; add local wrappers for the paper's exact formulas.
  - Current state:
    the `E4`/`E6`/`varphi`/`phi` layer and the theta-based `h`, `psi_I`, `psi_T`, `psi_S` layer are now defined in `Dim8/ModularFormsAux.lean`; a first raw `b` profile now lives in `Dim8/Section4B.lean`, and the next missing step is to promote it into a witness package while proving the Lee-style sign lemmas for the concrete kernels.
- Track 4: definitions and properties of `a` and `b`
  - Decide the implementation-level definition carefully.
  - Preferred default:
    - expose paper-facing definitions close to the contour-integral formulas,
    - but prove most analytic facts using the equivalent vertical/Laplace-integral formulas when that reduces contour bookkeeping.
  - Required outputs:
    - `a` and `b` are Schwartz,
    - Fourier eigenvalue relations,
    - double-zero formulas,
    - special values at `0` and `sqrt 2`.
- Track 5: Section 5 sign inequalities
  - Introduce two named theorem targets:
    - `A_neg : ∀ t > 0, A t < 0`
    - `B_pos : ∀ t > 0, 0 < B t`
  - Keep the proof source explicit:
    - paper-faithful note: original manuscript uses undocumented interval arithmetic,
    - default implementation route: Lee 2024's algebraic proof, with Romik 2023 as a fallback cross-check,
    - fallback route: a checked in-repo certificate if later sources are intentionally avoided.
- Track 6: final assembly
  - combine `a` and `b` into `g`,
  - prove `g_core_properties`,
  - feed these into the Cohn-Elkies track to prove the final packing theorem.

## Suggested Implementation Order
- First milestone:
  - replace `hello := "world"` with a real module skeleton,
  - create `PaperDefinitions.lean` and `PaperTheorems.lean`,
  - add empty/internal support modules with imports only.
- Second milestone:
  - complete `E8Lattice.lean` and `FourierAux.lean`,
  - state the final theorem skeletons.
- Third milestone:
  - complete the modular-form and auxiliary-function definitions,
  - prove the structural lemmas for `a` and `b`.
- Fourth milestone:
  - discharge the Section 5 sign lemmas via the chosen source route,
  - finish `g_core_properties` and the packing theorem.
- Fifth milestone:
  - add optional extension modules for exact roots / nonvanishing and uniqueness if desired.

## Known Risks And Default Choices
- Risk: the paper's contour-integral definitions may be expensive to formalize directly.
  - Default choice: keep paper-facing statements, but allow proofs to pivot to the equivalent Laplace-integral formulas.
- Risk: the coordinate description of `E_8` is elegant but not the easiest internal representation.
  - Default choice: basis-first internally, equivalence-to-paper externally.
- Risk: the paper's Section 5 proof is not fully reproducible as written.
  - Default choice: use Lee 2024 for the sign inequalities, not undocumented interval arithmetic.
- Risk: the theorem-level exact-zero/nonvanishing clause is not proved by the 2016 manuscript.
  - Default choice: exclude it from the paper-faithful core and record it as an optional later-source extension.

## Current Exit Criteria For The Planning Phase
- `PLAN.md` names the core theorem split and source policy.
- `PLAN.md` identifies reusable definitions, supporting modules, and mathlib imports.
- `PLAN.md` records the default implementation order and the optional later-source extensions.
