#------------------------------------------------------#
#     optimal scrap bleding problem                    #
#------------------------------------------------------#

function blend_model(model::Model, datafile::String)
    include(datafile)

# -----------------------------------------------------#
# variable declaration and bounding
# -----------------------------------------------------#

    @variable(model, 0 <= Buy[m in MATERIALS]  <= scrapdata[m,"avail"])
    @variable(model,bounds[el,"minReq"] <= Chem[el in ELEMENTS] <= bounds[el,"maxReq"])


# -----------------------------------------------------#
# objective function
# -----------------------------------------------------#

    @objective(model,Min,sum(scrapdata[m,"cost"] * Buy[m] for m in MATERIALS))


# -----------------------------------------------------#
# constraints
# -----------------------------------------------------#

    @constraint(model, chem_def[el in ELEMENTS], Chem[el] == sum(compos[el,m] * Buy[m] for m in MATERIALS)/required)

    @constraint(model, total, sum(Buy[m] for m  in MATERIALS) == required)

end
