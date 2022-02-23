#------------------------------------------------------#
#     optimal scrap bleding problem                    #
#------------------------------------------------------#


set MATERIALS;
set ELEMENTS;

param required; # required quantity
param minReq{ELEMENTS};
param maxReq{ELEMENTS};

param compos{ELEMENTS,MATERIALS};
param cost{MATERIALS};
param avail{MATERIALS};

# -----------------------------------------------------#
# variable declaration and bounding
# -----------------------------------------------------#

var Buy{m in MATERIALS} >=0, <= avail[m];
var Chem{el in ELEMENTS} >= minReq[el], <= maxReq[el];

# -----------------------------------------------------#
# objective function
# -----------------------------------------------------#

minimize totalcost: sum {m in MATERIALS} cost[m] * Buy[m];

# -----------------------------------------------------#
# constraints
# -----------------------------------------------------#

s.t. chem_def{el in ELEMENTS}:
	Chem[el] = sum{m in MATERIALS} compos[el,m] * Buy[m] / required;

s.t. total:
	sum{m in MATERIALS} Buy[m] == required;
