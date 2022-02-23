#------------------------------------------------------#
#     optimal food bleding problem                     #
#------------------------------------------------------#


set FOODS;
set ELEMENTS;

param minQual{ELEMENTS}, default 0.;
param maxQual{ELEMENTS}, default Infinity;

param compos{ELEMENTS,FOODS};
param cost{FOODS};
param minReq{FOODS}, default 0.;
param maxReq{FOODS}, default Infinity;

# -----------------------------------------------------#
# variable declaration and bounding
# -----------------------------------------------------#

var Buy{f in FOODS} >= minReq[f], <= maxReq[f], integer;
var Content{el in ELEMENTS} >= minQual[el], <= maxQual[el];

# -----------------------------------------------------#
# objective function
# -----------------------------------------------------#

minimize totalcost: sum {f in FOODS} cost[f] * Buy[f];

# -----------------------------------------------------#
# constraints
# -----------------------------------------------------#

s.t. qual_def{el in ELEMENTS}:
	Content[el] = sum{f in FOODS} compos[el,f] * Buy[f];

