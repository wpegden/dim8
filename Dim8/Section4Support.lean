import PaperDefinitions

open scoped FourierTransform SchwartzMap

noncomputable section

namespace Dim8

/-- A double-zero statement implies the vanishing statement used in `IsPaperFunctionA` and
`IsPaperFunctionB`. -/
theorem vanishesOnE8OutsideMinimalShell_of_doubleZeros {f : SchwartzR8}
    (hf : HasDoubleZerosOnE8OutsideMinimalShell f) :
    VanishesOnE8OutsideMinimalShell f := by
  intro x hx hgt
  exact (hf x hx hgt).1 x rfl

/-- Internal Section 4 witness package for the paper's function `a`, without repeating the
vanishing consequence already encoded by the double-zero data. -/
structure PaperAWitness where
  a : SchwartzR8
  radial : IsRadialSchwartz a
  imaginary : IsImaginaryValued a
  fourier_fixed : fourierSchwartzR8 a = a
  doubleZeros : HasDoubleZerosOnE8OutsideMinimalShell a
  valueAtZero : HasSphericalValue a 0 paperAValueAtZero
  valueAtSqrtTwo : HasSphericalValue a (Real.sqrt 2) 0
  derivAtSqrtTwo : HasRadialDerivativeAt a (Real.sqrt 2) paperADerivativeAtSqrtTwo

/-- The public `IsPaperFunctionA` interface derived from the more proof-friendly witness
package. -/
theorem PaperAWitness.isPaperFunctionA (w : PaperAWitness) : IsPaperFunctionA w.a := by
  refine ⟨w.radial, w.imaginary, w.fourier_fixed, ?_⟩
  exact vanishesOnE8OutsideMinimalShell_of_doubleZeros w.doubleZeros

/-- Internal Section 4 witness package for the paper's function `b`, without repeating the
vanishing consequence already encoded by the double-zero data. -/
structure PaperBWitness where
  b : SchwartzR8
  radial : IsRadialSchwartz b
  imaginary : IsImaginaryValued b
  fourier_neg_fixed : fourierSchwartzR8 b = -b
  doubleZeros : HasDoubleZerosOnE8OutsideMinimalShell b
  valueAtZero : HasSphericalValue b 0 0
  valueAtSqrtTwo : HasSphericalValue b (Real.sqrt 2) 0
  derivAtSqrtTwo : HasRadialDerivativeAt b (Real.sqrt 2) paperBDerivativeAtSqrtTwo

/-- The public `IsPaperFunctionB` interface derived from the more proof-friendly witness
package. -/
theorem PaperBWitness.isPaperFunctionB (w : PaperBWitness) : IsPaperFunctionB w.b := by
  refine ⟨w.radial, w.imaginary, w.fourier_neg_fixed, ?_⟩
  exact vanishesOnE8OutsideMinimalShell_of_doubleZeros w.doubleZeros

/-- The explicit linear combination defining `g` preserves radiality. -/
theorem paperFunctionG_isRadial {a b : SchwartzR8}
    (ha : IsRadialSchwartz a) (hb : IsRadialSchwartz b) :
    IsRadialSchwartz (paperFunctionG a b) := by
  intro x y hxy
  simp [paperFunctionG, ha hxy, hb hxy]

/-- Fourier-transform formula for the paper's linear combination `g`, assuming the Section 4
eigenvalue relations for `a` and `b`. -/
theorem fourierSchwartzR8_paperFunctionG {a b : SchwartzR8}
    (ha : fourierSchwartzR8 a = a) (hb : fourierSchwartzR8 b = -b) :
    fourierSchwartzR8 (paperFunctionG a b) =
      ((((Real.pi / 8640 : ℝ) : ℂ) * Complex.I) • a) -
        ((Complex.I / ((((240 : ℝ) * Real.pi : ℝ)) : ℂ)) • b) := by
  simp [paperFunctionG, fourierSchwartzR8, ha, hb, sub_eq_add_neg]

end Dim8
