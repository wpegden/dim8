import PaperDefinitions

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

/-- Section 4 public output for the function `a`. -/
def theoremAStatement : Prop :=
  ∃ a : SchwartzR8,
    IsPaperFunctionA a ∧
      HasSphericalValue a 0 paperAValueAtZero ∧
      HasSphericalValue a (Real.sqrt 2) 0 ∧
      HasRadialDerivativeAt a (Real.sqrt 2) paperADerivativeAtSqrtTwo

/-- Section 4 public output for the function `b`. -/
def theoremBStatement : Prop :=
  ∃ b : SchwartzR8,
    IsPaperFunctionB b ∧
      HasSphericalValue b 0 0 ∧
      HasSphericalValue b (Real.sqrt 2) 0 ∧
      HasRadialDerivativeAt b (Real.sqrt 2) paperBDerivativeAtSqrtTwo

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
