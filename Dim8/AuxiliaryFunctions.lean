import Dim8.PackingBounds
import Dim8.Section5Signs

noncomputable section

namespace Dim8

/-- Paper-facing statement that `fHat` is the Fourier transform of `f` with eigenvalue `+1`. -/
def IsFourierFixed (f fHat : R8 → ℂ) : Prop :=
  ∀ x, fHat x = f x

/-- Paper-facing statement that `fHat` is the Fourier transform of `f` with eigenvalue `-1`. -/
def IsFourierNegFixed (f fHat : R8 → ℂ) : Prop :=
  ∀ x, fHat x = -f x

/-- Paper-facing zero condition at lattice points of squared norm strictly greater than `2`. -/
def VanishesOnE8OutsideMinimalShell (f : R8 → ℂ) : Prop :=
  ∀ x, x ∈ E8Lattice → 2 < sqNorm x → f x = 0

/-- High-level Section 4 interface for the paper's function `a`. -/
def ACoreInterface (a aHat : R8 → ℂ) : Prop :=
  IsRadial a ∧ IsFourierFixed a aHat ∧ VanishesOnE8OutsideMinimalShell a

/-- High-level Section 4 interface for the paper's function `b`. -/
def BCoreInterface (b bHat : R8 → ℂ) : Prop :=
  IsRadial b ∧ IsFourierNegFixed b bHat ∧ VanishesOnE8OutsideMinimalShell b

/-- Paper condition `(g1)`. -/
def GCondition1 (g : R8 → ℝ) : Prop :=
  ∀ x, Real.sqrt 2 ≤ ‖x‖ → g x ≤ 0

/-- Paper condition `(g2)`. -/
def GCondition2 (gHat : R8 → ℝ) : Prop :=
  ∀ x, 0 ≤ gHat x

/-- Paper condition `(g3)`. -/
def GCondition3 (g gHat : R8 → ℝ) : Prop :=
  g 0 = 1 ∧ gHat 0 = 1

/-- The paper-faithful core content of Theorem `g`, excluding the stronger later-source
nonvanishing clause. -/
def GCoreProperties (g gHat : R8 → ℝ) : Prop :=
  IsRadial g ∧ GCondition1 g ∧ GCondition2 gHat ∧ GCondition3 g gHat

/-- The squared norms excluded by the paper's stronger "moreover" clause. -/
def IsPositiveEvenSquaredNorm (r : ℝ) : Prop :=
  ∃ n : ℕ, 0 < n ∧ r = ((2 * n : ℕ) : ℝ)

/-- Later-source strengthening of the paper's Theorem `g`. -/
def GNonvanishingOffPositiveEvenSquaredNorm (g gHat : R8 → ℝ) : Prop :=
  ∀ x, ¬ IsPositiveEvenSquaredNorm (sqNorm x) → g x ≠ 0 ∧ gHat x ≠ 0

end Dim8
