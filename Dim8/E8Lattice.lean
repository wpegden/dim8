import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Analysis.InnerProductSpace.EuclideanDist
import Mathlib.Data.Real.Sqrt

open scoped BigOperators

noncomputable section

namespace Dim8

/-- The ambient Euclidean space used throughout the paper. -/
abbrev R8 := Fin 8 → ℝ

/-- Squared Euclidean norm on `R8`. -/
def sqNorm (x : R8) : ℝ := ‖x‖ ^ 2

/-- Every coordinate is an integer. -/
def IsIntegerValued (x : R8) : Prop :=
  ∀ i, ∃ z : ℤ, x i = (z : ℝ)

/-- Every coordinate is an integer plus `1 / 2`. -/
def IsHalfIntegerValued (x : R8) : Prop :=
  ∀ i, ∃ z : ℤ, x i = (z : ℝ) + (1 / 2 : ℝ)

/-- The sum of the coordinates is even. -/
def HasEvenCoordinateSum (x : R8) : Prop :=
  ∃ z : ℤ, (∑ i, x i) = (((2 : ℤ) * z : ℤ) : ℝ)

/-- Paper-faithful coordinate description of membership in the `E_8` lattice. -/
def InE8CoordinateDescription (x : R8) : Prop :=
  (IsIntegerValued x ∨ IsHalfIntegerValued x) ∧ HasEvenCoordinateSum x

/-- The `E_8` lattice, stated exactly as in the paper's coordinate description. -/
def E8Lattice : Set R8 := {x | InE8CoordinateDescription x}

/-- The paper's sphere centers are `(1 / sqrt 2) Λ_8`. -/
def e8PackingCenters : Set R8 := {x | (Real.sqrt 2 : ℝ) • x ∈ E8Lattice}

/-- The density of the `E_8` lattice packing of unit balls. -/
def e8PackingDensity : ℝ := Real.pi ^ 4 / 384

end Dim8
