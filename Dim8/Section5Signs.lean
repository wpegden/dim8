import Mathlib.Data.Real.Basic

noncomputable section

namespace Dim8

/-- Section 5 sign target for the kernel `A(t)`. -/
def ANeg (A : ℝ → ℝ) : Prop :=
  ∀ t, 0 < t → A t < 0

/-- Section 5 sign target for the kernel `B(t)`. -/
def BPos (B : ℝ → ℝ) : Prop :=
  ∀ t, 0 < t → 0 < B t

end Dim8
