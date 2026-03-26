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

/-- Paper Section 5: on the positive half-line, `A(t)` is given by the explicit modular formula. -/
theorem paperAComplexKernel_of_pos {t : ℝ} (ht : 0 < t) :
    paperAComplexKernel t =
      -((t : ℂ) ^ 2) * phi0OnImag t⁻¹ (inv_pos.mpr ht) -
        (((36 : ℝ) / Real.pi ^ 2 : ℝ) : ℂ) * psiIOnImag t ht := by
  simp [paperAComplexKernel, ht]

/-- Paper Section 5: on the positive half-line, `B(t)` is given by the explicit modular formula. -/
theorem paperBComplexKernel_of_pos {t : ℝ} (ht : 0 < t) :
    paperBComplexKernel t =
      -((t : ℂ) ^ 2) * phi0OnImag t⁻¹ (inv_pos.mpr ht) +
        (((36 : ℝ) / Real.pi ^ 2 : ℝ) : ℂ) * psiIOnImag t ht := by
  simp [paperBComplexKernel, ht]

/-- Outside the positive half-line, the concrete kernel `A(t)` is definitionally zero. -/
theorem paperAComplexKernel_of_nonpos {t : ℝ} (ht : t ≤ 0) :
    paperAComplexKernel t = 0 := by
  simp [paperAComplexKernel, not_lt.mpr ht]

/-- Outside the positive half-line, the concrete kernel `B(t)` is definitionally zero. -/
theorem paperBComplexKernel_of_nonpos {t : ℝ} (ht : t ≤ 0) :
    paperBComplexKernel t = 0 := by
  simp [paperBComplexKernel, not_lt.mpr ht]

/-- Real-part simplification for the paper's concrete `A(t)` on `t > 0`. -/
theorem paperAKernel_of_pos {t : ℝ} (ht : 0 < t) :
    paperAKernel t =
      (-((t : ℂ) ^ 2) * phi0OnImag t⁻¹ (inv_pos.mpr ht) -
        (((36 : ℝ) / Real.pi ^ 2 : ℝ) : ℂ) * psiIOnImag t ht).re := by
  simp [paperAKernel, paperAComplexKernel_of_pos, ht]

/-- Real-part simplification for the paper's concrete `B(t)` on `t > 0`. -/
theorem paperBKernel_of_pos {t : ℝ} (ht : 0 < t) :
    paperBKernel t =
      (-((t : ℂ) ^ 2) * phi0OnImag t⁻¹ (inv_pos.mpr ht) +
        (((36 : ℝ) / Real.pi ^ 2 : ℝ) : ℂ) * psiIOnImag t ht).re := by
  simp [paperBKernel, paperBComplexKernel_of_pos, ht]

/-- Outside the positive half-line, the real-valued Section 5 kernel `A(t)` vanishes. -/
theorem paperAKernel_of_nonpos {t : ℝ} (ht : t ≤ 0) : paperAKernel t = 0 := by
  simp [paperAKernel, paperAComplexKernel_of_nonpos ht]

/-- Outside the positive half-line, the real-valued Section 5 kernel `B(t)` vanishes. -/
theorem paperBKernel_of_nonpos {t : ℝ} (ht : t ≤ 0) : paperBKernel t = 0 := by
  simp [paperBKernel, paperBComplexKernel_of_nonpos ht]

/-- In particular, the Section 5 kernel `A(t)` vanishes at `t = 0`. -/
theorem paperAKernel_zero : paperAKernel 0 = 0 := by
  simpa using paperAKernel_of_nonpos (t := 0) le_rfl

/-- In particular, the Section 5 kernel `B(t)` vanishes at `t = 0`. -/
theorem paperBKernel_zero : paperBKernel 0 = 0 := by
  simpa using paperBKernel_of_nonpos (t := 0) le_rfl

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
