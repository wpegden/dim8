import Mathlib.NumberTheory.ModularForms.EisensteinSeries.Basic
import Mathlib.NumberTheory.ModularForms.EisensteinSeries.E2.Defs
import Mathlib.NumberTheory.ModularForms.JacobiTheta.OneVariable
import Mathlib.NumberTheory.ModularForms.JacobiTheta.TwoVariable

open UpperHalfPlane

open scoped UpperHalfPlane

noncomputable section

namespace Dim8

/-- The normalized weight-4 Eisenstein series used in the paper. -/
abbrev E4 : ℍ → ℂ := ModularForm.E (k := 4) (by decide)

/-- The normalized weight-6 Eisenstein series used in the paper. -/
abbrev E6 : ℍ → ℂ := ModularForm.E (k := 6) (by decide)

/-- The denominator `E_4^3 - E_6^2` appearing throughout Section 4. -/
def paperEisensteinDenominator (z : ℍ) : ℂ := E4 z ^ 3 - E6 z ^ 2

/-- The weakly holomorphic modular form `φ_{-2}` from Section 4. -/
def varphiNeg2 (z : ℍ) : ℂ :=
  (-1728 : ℂ) * E4 z * E6 z / paperEisensteinDenominator z

/-- The weakly holomorphic modular form `φ_{-4}` from Section 4. -/
def varphiNeg4 (z : ℍ) : ℂ :=
  (1728 : ℂ) * E4 z ^ 2 / paperEisensteinDenominator z

/-- Paper notation `φ_{-4}`. -/
abbrev phiNeg4 : ℍ → ℂ := varphiNeg4

/-- Paper notation `φ_{-2}`. -/
def phiNeg2 (z : ℍ) : ℂ :=
  varphiNeg4 z * EisensteinSeries.E2 z + varphiNeg2 z

/-- The paper's `j - 1728`, rewritten to avoid introducing a separate `j` invariant. -/
def kleinJSub1728 (z : ℍ) : ℂ :=
  (1728 : ℂ) * E6 z ^ 2 / paperEisensteinDenominator z

/-- Paper notation `φ_0`, written only in terms of `E_2`, `E_4`, and `E_6`. -/
def phi0 (z : ℍ) : ℂ :=
  varphiNeg4 z * EisensteinSeries.E2 z ^ 2 +
    (2 : ℂ) * varphiNeg2 z * EisensteinSeries.E2 z +
    kleinJSub1728 z

/-- The point `it` on the positive imaginary axis. -/
def imagAxisPoint (t : ℝ) (ht : 0 < t) : ℍ := ⟨Complex.I * t, by simpa using ht⟩

/-- `φ_{-4}` restricted to the positive imaginary axis. -/
def phiNeg4OnImag (t : ℝ) (ht : 0 < t) : ℂ := phiNeg4 (imagAxisPoint t ht)

/-- `φ_{-2}` restricted to the positive imaginary axis. -/
def phiNeg2OnImag (t : ℝ) (ht : 0 < t) : ℂ := phiNeg2 (imagAxisPoint t ht)

/-- `φ_0` restricted to the positive imaginary axis. -/
def phi0OnImag (t : ℝ) (ht : 0 < t) : ℂ := phi0 (imagAxisPoint t ht)

/-- The paper's theta function `θ_{00}`. -/
abbrev theta00 (z : ℍ) : ℂ := jacobiTheta z

/-- The paper's theta function `θ_{01}`. -/
def theta01 (z : ℍ) : ℂ := jacobiTheta ((z : ℂ) + 1)

/-- The paper's theta function `θ_{10}`. -/
def theta10 (z : ℍ) : ℂ :=
  Complex.exp (Real.pi * Complex.I * ((z : ℂ) / 4)) * jacobiTheta₂ ((z : ℂ) / 2) z

/-- The weakly holomorphic modular form `h` from Section 4. -/
def h (z : ℍ) : ℂ :=
  (128 : ℂ) * (theta00 z ^ 4 + theta01 z ^ 4) / theta10 z ^ 8

/-- The auxiliary function `ψ_I` from Section 4. -/
def psiI (z : ℍ) : ℂ :=
  (128 : ℂ) * (theta00 z ^ 4 + theta01 z ^ 4) / theta10 z ^ 8 +
    (128 : ℂ) * (theta01 z ^ 4 - theta10 z ^ 4) / theta00 z ^ 8

/-- The auxiliary function `ψ_T` from Section 4. -/
def psiT (z : ℍ) : ℂ :=
  (128 : ℂ) * (theta00 z ^ 4 + theta01 z ^ 4) / theta10 z ^ 8 +
    (128 : ℂ) * (theta00 z ^ 4 + theta10 z ^ 4) / theta01 z ^ 8

/-- The auxiliary function `ψ_S` from Section 4. -/
def psiS (z : ℍ) : ℂ :=
  -(128 : ℂ) * (theta00 z ^ 4 + theta10 z ^ 4) / theta01 z ^ 8 -
    (128 : ℂ) * (theta10 z ^ 4 - theta01 z ^ 4) / theta00 z ^ 8

/-- The function `h` restricted to the positive imaginary axis. -/
def hOnImag (t : ℝ) (ht : 0 < t) : ℂ := h (imagAxisPoint t ht)

/-- `ψ_I` restricted to the positive imaginary axis. -/
def psiIOnImag (t : ℝ) (ht : 0 < t) : ℂ := psiI (imagAxisPoint t ht)

/-- `ψ_T` restricted to the positive imaginary axis. -/
def psiTOnImag (t : ℝ) (ht : 0 < t) : ℂ := psiT (imagAxisPoint t ht)

/-- `ψ_S` restricted to the positive imaginary axis. -/
def psiSOnImag (t : ℝ) (ht : 0 < t) : ℂ := psiS (imagAxisPoint t ht)

end Dim8
