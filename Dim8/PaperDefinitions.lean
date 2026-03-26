import Dim8.E8Lattice
import Dim8.PackingBounds
import Dim8.FourierAux
import Dim8.ModularFormsAux
import Dim8.Section5Signs
import Dim8.AuxiliaryFunctions

namespace Dim8

/-- Paper-facing notation for the `E_8` lattice. -/
abbrev Lambda8 := E8Lattice

/-- Paper-facing notation for the sphere centers `(1 / sqrt 2) Λ_8`. -/
abbrev scaledLambda8 := e8PackingCenters

end Dim8
