using JuMP
using Cbc

model = Model(Cbc.Optimizer)

include("Al_blend_mod.jl")

blend_model(model,"Al6061.dat")

optimize!(model)

println("\n===============   optimal solution =============\n")
for m in MATERIALS
   println("$(m) : $(JuMP.value(model[:Buy][m]))")
end

println("\n===============   chemical composition  =============\n")
for el in ELEMENTS
   println("$(el): $(bounds[el,"minReq"]) <= $(JuMP.value(model[:Chem][el])) <= $(bounds[el,"maxReq"]))")
end

