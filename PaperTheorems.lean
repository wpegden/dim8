import Dim8.Section4Support

noncomputable section

namespace Dim8

/-- Every `E_8` lattice vector has squared norm in `2ℕ`. -/
def e8SquaredNormStatement : Prop :=
  ∀ x : R8, x ∈ Lambda8 → HasEvenSquaredNorm (sqNorm x)

/-- Every nonzero `E_8` lattice vector has positive even squared norm. -/
def e8PositiveSquaredNormStatement : Prop :=
  ∀ x : R8, x ∈ Lambda8 → x ≠ 0 → HasPositiveEvenSquaredNorm (sqNorm x)

/-- The minimal distance between distinct `E_8` lattice points is `sqrt 2`. -/
def e8MinimalDistanceStatement : Prop :=
  ∀ x y : R8, x ∈ Lambda8 → y ∈ Lambda8 → x ≠ y → Real.sqrt 2 ≤ ‖x - y‖

/-- Paper Section 2: every `E_8` lattice vector has squared norm in `2ℕ`. -/
theorem e8SquaredNorm : e8SquaredNormStatement := by
  intro x hx
  simpa [e8SquaredNormStatement, HasEvenSquaredNorm] using sqNorm_eq_two_mul_nat x hx

/-- Paper Section 2: every nonzero `E_8` lattice vector has positive even squared norm. -/
theorem e8PositiveSquaredNorm : e8PositiveSquaredNormStatement := by
  intro x hx hx0
  simpa [e8PositiveSquaredNormStatement, HasPositiveEvenSquaredNorm] using
    sqNorm_eq_two_mul_nat_of_ne_zero x hx hx0

/-- Paper Section 2: distinct `E_8` lattice points are separated by distance at least `sqrt 2`. -/
theorem e8MinimalDistance : e8MinimalDistanceStatement := by
  intro x y hx hy hxy
  exact sqrt_two_le_norm_sub_of_ne x y hx hy hxy

/-- Section 4 public output for the function `a`. -/
def theoremAStatement : Prop :=
  ∃ a : SchwartzR8,
    IsPaperFunctionA a ∧
      HasDoubleZerosOnE8OutsideMinimalShell a ∧
      HasSphericalValue a 0 paperAValueAtZero ∧
      HasSphericalValue a (Real.sqrt 2) 0 ∧
      HasRadialDerivativeAt a (Real.sqrt 2) paperADerivativeAtSqrtTwo

/-- A thin paper-facing wrapper: an internal Section 4 witness for `a` yields the public theorem
statement. -/
theorem theoremAStatement_of_paperAWitness (w : PaperAWitness) : theoremAStatement := by
  refine ⟨w.a, w.isPaperFunctionA, w.doubleZeros, w.valueAtZero, w.valueAtSqrtTwo,
    w.derivAtSqrtTwo⟩

/-- Section 4 public output for the function `b`. -/
def theoremBStatement : Prop :=
  ∃ b : SchwartzR8,
    IsPaperFunctionB b ∧
      HasDoubleZerosOnE8OutsideMinimalShell b ∧
      HasSphericalValue b 0 0 ∧
      HasSphericalValue b (Real.sqrt 2) 0 ∧
      HasRadialDerivativeAt b (Real.sqrt 2) paperBDerivativeAtSqrtTwo

/-- A thin paper-facing wrapper: an internal Section 4 witness for `b` yields the public theorem
statement. -/
theorem theoremBStatement_of_paperBWitness (w : PaperBWitness) : theoremBStatement := by
  refine ⟨w.b, w.isPaperFunctionB, w.doubleZeros, w.valueAtZero, w.valueAtSqrtTwo,
    w.derivAtSqrtTwo⟩

/-- Paper-faithful core statement of Theorem `g`, with `g` tied to the stated linear combination
of `a` and `b`. -/
def theoremGCoreStatement : Prop :=
  ∃ a b g : SchwartzR8,
    IsPaperFunctionA a ∧
      IsPaperFunctionB b ∧
      g = paperFunctionG a b ∧
      GCoreProperties g

/-- Optional later-source strengthening of Theorem `g`. -/
def theoremGNonvanishingExtensionStatement : Prop :=
  ∃ a b g : SchwartzR8,
    IsPaperFunctionA a ∧
      IsPaperFunctionB b ∧
      g = paperFunctionG a b ∧
      GCoreProperties g ∧
      GNonvanishingExtension g

/-- Final paper theorem statement, parameterized by the eventual formal definition of packing
density on sets of centers in `R8`. -/
def theoremMainStatement (packingDensity : Set R8 → ℝ) : Prop :=
  packingDensity scaledLambda8 = e8PackingDensity ∧
    ∀ centers, IsUnitBallPacking centers → packingDensity centers ≤ packingDensity scaledLambda8

end Dim8
