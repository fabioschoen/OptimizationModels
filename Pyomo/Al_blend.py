from pyomo.environ import *

#------------------------------------------------------#
#     optimal scrap bleding problem                    #
#------------------------------------------------------#

# ADDED THIS LINE

Infinity = float('inf')

model = AbstractModel()

model.MATERIALS = Set()
model.ELEMENTS = Set()

model.required = Param() # required quantity
model.minReq = Param(model.ELEMENTS,default=0.0)
model.maxReq = Param(model.ELEMENTS,default=Infinity)

model.compos = Param(model.ELEMENTS, model.MATERIALS)
model.cost = Param(model.MATERIALS)
model.avail = Param(model.MATERIALS)

# -----------------------------------------------------#
# variable declaration and bounding
# -----------------------------------------------------#

def chem_bnds(model, i):
   return (model.minReq[i], model.maxReq[i])

def qty_bnds(model, i):
   return (0.0, model.avail[i])

model.Buy = Var(model.MATERIALS,bounds=qty_bnds)
model.Chem = Var(model.ELEMENTS, bounds=chem_bnds)

# -----------------------------------------------------#
# objective function
# -----------------------------------------------------#

def totalcost_rule(model):
    return sum (model.cost[m] * model.Buy[m] for m in model.MATERIALS)
model.totalcost = Objective(rule=totalcost_rule)

# -----------------------------------------------------#
# constraints
# -----------------------------------------------------#

def chem_rule(model,el):
	return model.Chem[el] == sum(model.compos[el,m] * model.Buy[m] for m in model.MATERIALS) / model.required
model.chem = Constraint(model.ELEMENTS,rule=chem_rule)

def total_rule(model):
	return sum(model.Buy[m] for m in model.MATERIALS) == model.required
model.total = Constraint(rule=total_rule)

