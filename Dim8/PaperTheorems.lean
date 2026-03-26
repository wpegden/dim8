import Dim8.PaperDefinitions

namespace Dim8

/-- Paper definition/theorem interface for the coordinate description of `Λ_8`. -/
def e8LatticeCharacterizationStatement : Prop :=
  ∀ x : R8, x ∈ E8Lattice ↔ InE8CoordinateDescription x

/-- Paper-facing minimal squared norm statement for `Λ_8`. -/
def e8MinimalSquaredNormStatement : Prop :=
  ∀ x : R8, x ∈ E8Lattice → x ≠ 0 → 2 ≤ sqNorm x

/-- High-level Section 4 theorem interface for the function `a`. -/
def aCoreStatement : Prop :=
  ∃ a aHat : R8 → ℂ, ACoreInterface a aHat

/-- High-level Section 4 theorem interface for the function `b`. -/
def bCoreStatement : Prop :=
  ∃ b bHat : R8 → ℂ, BCoreInterface b bHat

/-- Paper-faithful core statement of Theorem `g`, split off from the stronger later-source
nonvanishing clause. -/
def theoremGCoreStatement : Prop :=
  ∃ g gHat : R8 → ℝ, GCoreProperties g gHat

/-- Optional later-source strengthening of Theorem `g`. -/
def theoremGNonvanishingExtensionStatement : Prop :=
  ∃ g gHat : R8 → ℝ,
    GCoreProperties g gHat ∧ GNonvanishingOffPositiveEvenSquaredNorm g gHat

/-- Final paper theorem statement, parameterized by the eventual formal definition of the sphere
packing constant. -/
def theoremMainStatement (spherePackingConstant : ℕ → ℝ) : Prop :=
  spherePackingMainTheorem spherePackingConstant

end Dim8
