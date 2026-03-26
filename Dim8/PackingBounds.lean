import Dim8.E8Lattice
import Mathlib.Analysis.SpecialFunctions.Pow.Real

noncomputable section

namespace Dim8

/-- Radiality in the Euclidean norm. -/
def IsRadial {α : Sort*} (f : R8 → α) : Prop :=
  ∀ ⦃x y : R8⦄, ‖x‖ = ‖y‖ → f x = f y

/-- Decay condition appearing in the paper's definition of admissibility. -/
def HasDecay (f : R8 → ℝ) (δ : ℝ) : Prop :=
  ∃ C : ℝ, 0 ≤ C ∧ ∀ x, |f x| ≤ C * Real.rpow (1 + ‖x‖) (-(8 : ℝ) - δ)

/-- A paper-facing version of admissibility, phrased in terms of a function and its Fourier
partner. -/
def IsAdmissiblePair (f fHat : R8 → ℝ) : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ HasDecay f δ ∧ HasDecay fHat δ

/-- A paper-facing optimality predicate for the Cohn-Elkies argument in dimension `8`. -/
def IsOptimalPair (f fHat : R8 → ℝ) : Prop :=
  IsAdmissiblePair f fHat ∧
    (∀ x, Real.sqrt 2 ≤ ‖x‖ → f x ≤ 0) ∧
    (∀ x, 0 ≤ fHat x) ∧
    f 0 = 16 * fHat 0

/-- Final paper theorem, parameterized by the eventual formal definition of the sphere packing
constant. -/
def spherePackingMainTheorem (spherePackingConstant : ℕ → ℝ) : Prop :=
  spherePackingConstant 8 ≤ e8PackingDensity

end Dim8
