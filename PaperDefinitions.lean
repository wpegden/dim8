import Dim8.E8Lattice
import Dim8.PackingBounds
import Dim8.Section5Signs
import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier

open scoped FourierTransform SchwartzMap

noncomputable section

namespace Dim8

/-- Paper-facing notation for the `E_8` lattice. -/
abbrev Lambda8 := E8Lattice

/-- Paper-facing notation for the sphere centers `(1 / sqrt 2) Λ_8`. -/
abbrev scaledLambda8 := e8PackingCenters

/-- Complex-valued Schwartz functions on `R8`, the ambient function space for the paper's
auxiliary functions. -/
abbrev SchwartzR8 := SchwartzMap R8 ℂ

/-- The Fourier transform on the paper's Schwartz-space ambient type, with the codomain fixed
explicitly so theorem statements do not depend on typeclass inference heuristics. -/
abbrev fourierSchwartzR8 (f : SchwartzR8) : SchwartzR8 := (𝓕 : SchwartzR8 → SchwartzR8) f

/-- Radiality for Schwartz functions on `R8`. -/
def IsRadialSchwartz (f : SchwartzR8) : Prop :=
  ∀ ⦃x y : R8⦄, ‖x‖ = ‖y‖ → f x = f y

/-- The function takes values in `ℝ ⊂ ℂ`. -/
def IsRealValued (f : SchwartzR8) : Prop :=
  ∀ x, (f x).im = 0

/-- The function takes values in `iℝ ⊂ ℂ`. -/
def IsImaginaryValued (f : SchwartzR8) : Prop :=
  ∀ x, (f x).re = 0

/-- A paper-facing zero condition at lattice points of squared norm strictly larger than `2`. -/
def VanishesOnE8OutsideMinimalShell (f : SchwartzR8) : Prop :=
  ∀ x, x ∈ Lambda8 → 2 < sqNorm x → f x = 0

/-- The squared norms excluded by the stronger "moreover" clause in Theorem `g`. -/
def HasPositiveEvenSquaredNorm (r : ℝ) : Prop :=
  ∃ n : ℕ, 0 < n ∧ r = ((2 * n : ℕ) : ℝ)

/-- Paper-facing interface for the Section 4 function `a`. -/
def IsPaperFunctionA (a : SchwartzR8) : Prop :=
  IsRadialSchwartz a ∧
    IsImaginaryValued a ∧
    fourierSchwartzR8 a = a ∧
    VanishesOnE8OutsideMinimalShell a

/-- Paper-facing interface for the Section 4 function `b`. -/
def IsPaperFunctionB (b : SchwartzR8) : Prop :=
  IsRadialSchwartz b ∧
    IsImaginaryValued b ∧
    fourierSchwartzR8 b = -b ∧
    VanishesOnE8OutsideMinimalShell b

/-- The paper's explicit linear combination
`g = (π i / 8640) a + (i / (240 π)) b`. -/
def paperFunctionG (a b : SchwartzR8) : SchwartzR8 :=
  ((((Real.pi / 8640 : ℝ) : ℂ) * Complex.I) • a) +
    ((Complex.I / ((((240 : ℝ) * Real.pi : ℝ)) : ℂ)) • b)

/-- Implementation-friendly alias for the paper's function `g`. -/
abbrev gFromAB := paperFunctionG

/-- Paper condition `(g1)`. -/
def GCondition1 (g : SchwartzR8) : Prop :=
  ∀ x, Real.sqrt 2 ≤ ‖x‖ → (g x).re ≤ 0

/-- Paper condition `(g2)`. -/
def GCondition2 (g : SchwartzR8) : Prop :=
  ∀ x, 0 ≤ (fourierSchwartzR8 g x).re

/-- Paper condition `(g3)`. -/
def GCondition3 (g : SchwartzR8) : Prop :=
  g 0 = 1 ∧ fourierSchwartzR8 g 0 = 1

/-- The paper-faithful core content of Theorem `g`, excluding the stronger later-source
nonvanishing clause. -/
def GCoreProperties (g : SchwartzR8) : Prop :=
  IsRadialSchwartz g ∧
    IsRealValued g ∧
    GCondition1 g ∧
    GCondition2 g ∧
    GCondition3 g

/-- Later-source strengthening of the paper's Theorem `g`. -/
def GNonvanishingExtension (g : SchwartzR8) : Prop :=
  ∀ x, ¬ HasPositiveEvenSquaredNorm (sqNorm x) → g x ≠ 0 ∧ fourierSchwartzR8 g x ≠ 0

end Dim8
