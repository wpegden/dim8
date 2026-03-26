import Dim8.ModularFormsAux
import Dim8.PackingBounds
import Mathlib.MeasureTheory.Integral.Bochner.Set

noncomputable section

namespace Dim8

/-- The tail integrand appearing in the paper's second integral formula for `b(r)`. We use the
same expression on all real `t`, with the modular term truncated to `0` outside `(0, ∞)`. -/
def rawBProfileTailIntegrand (r t : ℝ) : ℂ :=
  let psiTerm : ℂ := if ht : 0 < t then psiIOnImag t ht else 0
  (psiTerm - (144 : ℂ) - ((Real.exp (2 * Real.pi * t) : ℝ) : ℂ)) *
    (((Real.exp (-Real.pi * r ^ 2 * t) : ℝ) : ℂ))

/-- The raw Section 4 profile formula for `b(r)` from the paper's one-variable integral
representation. This is the unregularized formula, prior to proving the analytic extension at
`r = 0` and `r = sqrt 2`. -/
def rawBProfileFormula (r : ℝ) : ℂ :=
  ((4 : ℂ) * Complex.I) * (((Real.sin (Real.pi * r ^ 2 / 2)) : ℂ) ^ 2) *
    ((((144 / (Real.pi * r ^ 2 : ℝ) + 1 / (Real.pi * (r ^ 2 - 2 : ℝ))) : ℝ) : ℂ) +
      ∫ t in Set.Ioi (0 : ℝ), rawBProfileTailIntegrand r t)

/-- The corresponding raw radial function on `R8`. -/
def rawBFunctionFormula (x : R8) : ℂ := rawBProfileFormula ‖x‖

/-- The raw `b` formula is radial by construction. -/
theorem rawBFunctionFormula_radial : IsRadial rawBFunctionFormula := by
  intro x y hxy
  simp [rawBFunctionFormula, hxy]

end Dim8
