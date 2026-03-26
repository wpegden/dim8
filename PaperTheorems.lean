import PaperDefinitions

noncomputable section

namespace Dim8

/-- Every `E_8` lattice vector has squared norm in `2ℕ`. -/
def e8SquaredNormStatement : Prop :=
  ∀ x : R8, x ∈ Lambda8 → HasPositiveEvenSquaredNorm (sqNorm x)

/-- The minimal distance between distinct `E_8` lattice points is `sqrt 2`. -/
def e8MinimalDistanceStatement : Prop :=
  ∀ x y : R8, x ∈ Lambda8 → y ∈ Lambda8 → x ≠ y → Real.sqrt 2 ≤ ‖x - y‖

/-- High-level Section 4 statement for the function `a`. -/
def theoremAStatement : Prop :=
  ∃ a : SchwartzR8, IsPaperFunctionA a

/-- High-level Section 4 statement for the function `b`. -/
def theoremBStatement : Prop :=
  ∃ b : SchwartzR8, IsPaperFunctionB b

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

/-- Final paper theorem statement, parameterized by the eventual formal definition of the sphere
packing constant. -/
def theoremMainStatement (spherePackingConstant : ℕ → ℝ) : Prop :=
  spherePackingConstant 8 ≤ e8PackingDensity

end Dim8
