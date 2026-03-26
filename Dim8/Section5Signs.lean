import Dim8.ModularFormsAux
import Mathlib.Data.Real.Basic

noncomputable section

namespace Dim8

/-- The paper's complex-valued kernel `A(t)` from Section 5. Outside `(0, ∞)` we set it to `0`,
since all sign targets are stated only for positive `t`. -/
def paperAComplexKernel (t : ℝ) : ℂ :=
  if ht : 0 < t then
    -((t : ℂ) ^ 2) * phi0OnImag t⁻¹ (inv_pos.mpr ht) -
      (((36 : ℝ) / Real.pi ^ 2 : ℝ) : ℂ) * psiIOnImag t ht
  else 0

/-- The paper's complex-valued kernel `B(t)` from Section 5. Outside `(0, ∞)` we set it to `0`,
since all sign targets are stated only for positive `t`. -/
def paperBComplexKernel (t : ℝ) : ℂ :=
  if ht : 0 < t then
    -((t : ℂ) ^ 2) * phi0OnImag t⁻¹ (inv_pos.mpr ht) +
      (((36 : ℝ) / Real.pi ^ 2 : ℝ) : ℂ) * psiIOnImag t ht
  else 0

/-- Real-valued proxy for the paper's `A(t)`. -/
def paperAKernel (t : ℝ) : ℝ := (paperAComplexKernel t).re

/-- Real-valued proxy for the paper's `B(t)`. -/
def paperBKernel (t : ℝ) : ℝ := (paperBComplexKernel t).re

/-- Section 5 sign target for the kernel `A(t)`. -/
def ANeg (A : ℝ → ℝ) : Prop :=
  ∀ t, 0 < t → A t < 0

/-- Section 5 sign target for the kernel `B(t)`. -/
def BPos (B : ℝ → ℝ) : Prop :=
  ∀ t, 0 < t → 0 < B t

/-- The paper's concrete Section 5 sign target for `A(t)`. -/
abbrev PaperANeg : Prop := ANeg paperAKernel

/-- The paper's concrete Section 5 sign target for `B(t)`. -/
abbrev PaperBPos : Prop := BPos paperBKernel

end Dim8
