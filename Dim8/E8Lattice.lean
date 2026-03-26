import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Group.Int.Even
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Analysis.InnerProductSpace.EuclideanDist
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic

open scoped BigOperators

noncomputable section

namespace Dim8

/-- The ambient Euclidean space used throughout the paper. -/
abbrev R8 := EuclideanSpace ℝ (Fin 8)

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

/-- `sqNorm` written in coordinates. -/
lemma sqNorm_eq_sum_sq (x : R8) : sqNorm x = ∑ i : Fin 8, (x i) ^ 2 := by
  simp [sqNorm, EuclideanSpace.norm_sq_eq, sq_abs]

lemma even_sq_iff_even (z : ℤ) : Even (z ^ 2) ↔ Even z := by
  rw [pow_two, Int.even_mul]
  simp

lemma even_sum_sq_iff_even_sum (z : Fin 8 → ℤ) :
    Even (∑ i : Fin 8, z i ^ 2) ↔ Even (∑ i : Fin 8, z i) := by
  classical
  refine Finset.induction ?_ ?_ (s := Finset.univ)
  · simp
  · intro a s ha hs
    simp [ha, even_sq_iff_even, hs, Int.even_add]

lemma sum_sq_eq_zero_iff (z : Fin 8 → ℤ) :
    (∑ i : Fin 8, z i ^ 2) = 0 ↔ ∀ i, z i = 0 := by
  constructor
  · intro h
    have hz : (fun i : Fin 8 => z i ^ 2) = 0 := by
      simpa using (Fintype.sum_eq_zero_iff_of_nonneg fun i => sq_nonneg (z i)).1 h
    intro i
    exact eq_zero_of_pow_eq_zero (congrFun hz i)
  · intro h
    simp [h]

lemma even_sum_of_even_terms (f : Fin 8 → ℤ) (hf : ∀ i, Even (f i)) :
    Even (∑ i : Fin 8, f i) := by
  classical
  refine Finset.induction ?_ ?_ (s := Finset.univ)
  · simp
  · intro a s ha hs
    simp [ha, hf, hs, Int.even_add]

lemma int_sq_add_self_nonneg (z : ℤ) : 0 ≤ z ^ 2 + z := by
  nlinarith [sq_nonneg z, sq_nonneg (z + 1)]

lemma even_sq_add_self (z : ℤ) : Even (z ^ 2 + z) := by
  rw [Int.even_add, even_sq_iff_even]

lemma sub_even_sum (x y : R8) (hx : HasEvenCoordinateSum x) (hy : HasEvenCoordinateSum y) :
    HasEvenCoordinateSum (x - y) := by
  rcases hx with ⟨kx, hkx⟩
  rcases hy with ⟨ky, hky⟩
  refine ⟨kx - ky, ?_⟩
  calc
    ∑ i : Fin 8, (x - y) i = ∑ i : Fin 8, x i - ∑ i : Fin 8, y i := by
      simp [sub_eq_add_neg, Finset.sum_add_distrib]
    _ = (((2 * kx : ℤ) : ℝ)) - (((2 * ky : ℤ) : ℝ)) := by simp [hkx, hky]
    _ = (2 : ℝ) * kx - (2 : ℝ) * ky := by norm_num
    _ = (((2 * (kx - ky) : ℤ)) : ℝ) := by
      push_cast
      ring

lemma sub_mem (x y : R8) (hx : x ∈ E8Lattice) (hy : y ∈ E8Lattice) : x - y ∈ E8Lattice := by
  rcases hx with ⟨hx | hx, hsx⟩ <;> rcases hy with ⟨hy | hy, hsy⟩
  · refine ⟨Or.inl ?_, sub_even_sum x y hsx hsy⟩
    intro i
    rcases hx i with ⟨zx, hzx⟩
    rcases hy i with ⟨zy, hzy⟩
    refine ⟨zx - zy, by simp [hzx, hzy]⟩
  · refine ⟨Or.inr ?_, sub_even_sum x y hsx hsy⟩
    intro i
    rcases hx i with ⟨zx, hzx⟩
    rcases hy i with ⟨zy, hzy⟩
    refine ⟨zx - zy - 1, ?_⟩
    calc
      (x - y) i = (zx : ℝ) - ((zy : ℝ) + (1 / 2 : ℝ)) := by simp [hzx, hzy]
      _ = (zx : ℝ) - (zy : ℝ) - (1 / 2 : ℝ) := by ring
      _ = ((zx - zy - 1 : ℤ) : ℝ) + (1 / 2 : ℝ) := by
        norm_num
        ring
  · refine ⟨Or.inr ?_, sub_even_sum x y hsx hsy⟩
    intro i
    rcases hx i with ⟨zx, hzx⟩
    rcases hy i with ⟨zy, hzy⟩
    refine ⟨zx - zy, ?_⟩
    calc
      (x - y) i = ((zx : ℝ) + (1 / 2 : ℝ)) - (zy : ℝ) := by simp [hzx, hzy]
      _ = (zx : ℝ) - (zy : ℝ) + (1 / 2 : ℝ) := by ring
      _ = ((zx - zy : ℤ) : ℝ) + (1 / 2 : ℝ) := by
        norm_num
  · refine ⟨Or.inl ?_, sub_even_sum x y hsx hsy⟩
    intro i
    rcases hx i with ⟨zx, hzx⟩
    rcases hy i with ⟨zy, hzy⟩
    refine ⟨zx - zy, ?_⟩
    calc
      (x - y) i = ((zx : ℝ) + (1 / 2 : ℝ)) - ((zy : ℝ) + (1 / 2 : ℝ)) := by simp [hzx, hzy]
      _ = (zx : ℝ) - (zy : ℝ) := by ring
      _ = ((zx - zy : ℤ) : ℝ) := by
        norm_num

/-- Integral-coordinate case of the `E_8` squared-norm calculation. -/
theorem sqNorm_eq_two_mul_nat_of_integer (x : R8) (hx : IsIntegerValued x)
    (hsum : HasEvenCoordinateSum x) (hx0 : x ≠ 0) :
    ∃ n : ℕ, 0 < n ∧ sqNorm x = ((2 * n : ℕ) : ℝ) := by
  choose z hz using hx
  have hsq : sqNorm x = ((∑ i : Fin 8, z i ^ 2 : ℤ) : ℝ) := by
    calc
      sqNorm x = ∑ i : Fin 8, (x i) ^ 2 := sqNorm_eq_sum_sq x
      _ = ∑ i : Fin 8, (((z i : ℤ) : ℝ) ^ 2) := by simp [hz]
      _ = ((∑ i : Fin 8, z i ^ 2 : ℤ) : ℝ) := by simp [Int.cast_sum]
  have hzsum_even : Even (∑ i : Fin 8, z i) := by
    rcases hsum with ⟨k, hk⟩
    refine ⟨k, ?_⟩
    apply Int.cast_injective (α := ℝ)
    calc
      (((∑ i : Fin 8, z i : ℤ)) : ℝ) = ∑ i : Fin 8, x i := by simp [hz, Int.cast_sum]
      _ = (((2 : ℤ) * k : ℤ) : ℝ) := hk
      _ = ((k + k : ℤ) : ℝ) := by simp [two_mul]
  have hsumsq_even : Even (∑ i : Fin 8, z i ^ 2) := (even_sum_sq_iff_even_sum z).2 hzsum_even
  rcases hsumsq_even with ⟨m, hm⟩
  have hsumsq_nonneg : 0 ≤ ∑ i : Fin 8, z i ^ 2 := by
    exact Finset.sum_nonneg (fun i _ => sq_nonneg (z i))
  have hsumsq_ne_zero : (∑ i : Fin 8, z i ^ 2) ≠ 0 := by
    intro hzero
    apply hx0
    ext i
    have hz0 : z i = 0 := (sum_sq_eq_zero_iff z).1 hzero i
    simp [hz, hz0]
  have hm_pos : 0 < m := by
    omega
  have hm_real : ((∑ i : Fin 8, z i ^ 2 : ℤ) : ℝ) = 2 * (m : ℝ) := by
    simpa [two_mul] using
      (show ((∑ i : Fin 8, z i ^ 2 : ℤ) : ℝ) = ((m + m : ℤ) : ℝ) by
        exact_mod_cast hm)
  have hm_nat_real : (m : ℝ) = ((Int.toNat m : ℕ) : ℝ) := by
    exact_mod_cast (Int.toNat_of_nonneg (le_of_lt hm_pos)).symm
  have hnat_pos : 0 < Int.toNat m := by
    apply Nat.pos_of_ne_zero
    intro hzero
    have : m ≤ 0 := (Int.toNat_eq_zero).1 hzero
    omega
  refine ⟨Int.toNat m, hnat_pos, ?_⟩
  calc
    sqNorm x = 2 * (m : ℝ) := by simpa [hsq] using hm_real
    _ = 2 * ((Int.toNat m : ℕ) : ℝ) := by rw [hm_nat_real]
    _ = ((2 * Int.toNat m : ℕ) : ℝ) := by norm_num

/-- Half-integral-coordinate case of the `E_8` squared-norm calculation. -/
theorem sqNorm_eq_two_mul_nat_of_half_integer (x : R8) (hx : IsHalfIntegerValued x) :
    ∃ n : ℕ, 0 < n ∧ sqNorm x = ((2 * n : ℕ) : ℝ) := by
  choose z hz using hx
  have hsq : sqNorm x = ((∑ i : Fin 8, (z i ^ 2 + z i) : ℤ) : ℝ) + 2 := by
    calc
      sqNorm x = ((∑ i : Fin 8, z i ^ 2 : ℤ) : ℝ) + ((∑ i : Fin 8, z i : ℤ) : ℝ) + 2 := by
        calc
          sqNorm x = ∑ i : Fin 8, (x i) ^ 2 := sqNorm_eq_sum_sq x
          _ = ∑ i : Fin 8, (((z i : ℝ) + (1 / 2 : ℝ)) ^ 2) := by simp [hz]
          _ = ∑ i : Fin 8, (((z i : ℝ)) ^ 2 + (z i : ℝ) + (1 / 4 : ℝ)) := by
            congr with i
            ring
          _ = (∑ i : Fin 8, ((z i : ℤ) : ℝ) ^ 2) + (∑ i : Fin 8, (z i : ℤ)) +
                ∑ i : Fin 8, (1 / 4 : ℝ) := by
            simp [Finset.sum_add_distrib]
          _ = ((∑ i : Fin 8, z i ^ 2 : ℤ) : ℝ) + ((∑ i : Fin 8, z i : ℤ) : ℝ) + 2 := by
            simp [Int.cast_sum]
            norm_num
      _ = ((∑ i : Fin 8, (z i ^ 2 + z i) : ℤ) : ℝ) + 2 := by
        simp [Int.cast_sum, Finset.sum_add_distrib]
  have hsum_even : Even (∑ i : Fin 8, (z i ^ 2 + z i : ℤ)) :=
    even_sum_of_even_terms (fun i => z i ^ 2 + z i) (fun i => even_sq_add_self (z i))
  rcases hsum_even with ⟨m, hm⟩
  have hsum_nonneg : 0 ≤ ∑ i : Fin 8, (z i ^ 2 + z i : ℤ) := by
    exact Finset.sum_nonneg (fun i _ => int_sq_add_self_nonneg (z i))
  have hm_nonneg : 0 ≤ m := by
    omega
  have hm1_pos : 0 < m + 1 := by
    omega
  have hm_real : ((∑ i : Fin 8, (z i ^ 2 + z i : ℤ)) : ℝ) = 2 * (m : ℝ) := by
    simpa [two_mul] using
      (show ((∑ i : Fin 8, (z i ^ 2 + z i : ℤ)) : ℝ) = ((m + m : ℤ) : ℝ) by
        exact_mod_cast hm)
  have hm1_nat_real : ((m + 1 : ℤ) : ℝ) = ((Int.toNat (m + 1) : ℕ) : ℝ) := by
    exact_mod_cast (Int.toNat_of_nonneg (le_of_lt hm1_pos)).symm
  have hnat_pos : 0 < Int.toNat (m + 1) := by
    apply Nat.pos_of_ne_zero
    intro hzero
    have : m + 1 ≤ 0 := (Int.toNat_eq_zero).1 hzero
    omega
  refine ⟨Int.toNat (m + 1), hnat_pos, ?_⟩
  calc
    sqNorm x = 2 * (m : ℝ) + 2 := by
      simpa [hsq] using congrArg (fun t : ℝ => t + 2) hm_real
    _ = 2 * ((m + 1 : ℤ) : ℝ) := by
      push_cast
      ring
    _ = 2 * ((Int.toNat (m + 1) : ℕ) : ℝ) := by rw [hm1_nat_real]
    _ = ((2 * Int.toNat (m + 1) : ℕ) : ℝ) := by norm_num

/-- Every `E_8` lattice vector has squared norm in `2ℕ`. -/
theorem sqNorm_eq_two_mul_nat (x : R8) (hx : x ∈ E8Lattice) :
    ∃ n : ℕ, sqNorm x = ((2 * n : ℕ) : ℝ) := by
  rcases hx with ⟨hx | hx, hsum⟩
  · by_cases hzero : x = 0
    · refine ⟨0, ?_⟩
      simp [sqNorm, hzero]
    · rcases sqNorm_eq_two_mul_nat_of_integer x hx hsum hzero with ⟨n, _, hn⟩
      exact ⟨n, hn⟩
  · rcases sqNorm_eq_two_mul_nat_of_half_integer x hx with ⟨n, _, hn⟩
    exact ⟨n, hn⟩

/-- Every nonzero `E_8` lattice vector has positive even squared norm. -/
theorem sqNorm_eq_two_mul_nat_of_ne_zero (x : R8) (hx : x ∈ E8Lattice) (hx0 : x ≠ 0) :
    ∃ n : ℕ, 0 < n ∧ sqNorm x = ((2 * n : ℕ) : ℝ) := by
  rcases hx with ⟨hx | hx, hsum⟩
  · exact sqNorm_eq_two_mul_nat_of_integer x hx hsum hx0
  · exact sqNorm_eq_two_mul_nat_of_half_integer x hx

/-- Distinct `E_8` lattice points are separated by distance at least `sqrt 2`. -/
theorem sqrt_two_le_norm_sub_of_ne (x y : R8) (hx : x ∈ E8Lattice) (hy : y ∈ E8Lattice)
    (hxy : x ≠ y) : Real.sqrt 2 ≤ ‖x - y‖ := by
  have hsub : x - y ∈ E8Lattice := sub_mem x y hx hy
  have hsub0 : x - y ≠ 0 := by
    intro h
    apply hxy
    exact sub_eq_zero.mp h
  rcases sqNorm_eq_two_mul_nat_of_ne_zero (x - y) hsub hsub0 with ⟨n, hn, hsq⟩
  have hsq' : ‖x - y‖ ^ 2 = ((2 * n : ℕ) : ℝ) := by
    simpa [sqNorm] using hsq
  have htwo' : (2 : ℝ) ≤ ((2 * n : ℕ) : ℝ) := by
    exact_mod_cast Nat.mul_le_mul_left 2 (Nat.succ_le_of_lt hn)
  have htwo : (2 : ℝ) ≤ ‖x - y‖ ^ 2 := by
    simpa [hsq'] using htwo'
  have hsqrt := Real.sqrt_le_sqrt htwo
  rw [Real.sqrt_sq_eq_abs, abs_of_nonneg (norm_nonneg (x - y))] at hsqrt
  simpa using hsqrt

end Dim8
