#------------------------------------------------------#
#     aggregate production planning                    #
#------------------------------------------------------#

param T; # Planning Period
set PRODTYPE;

param ProdCost{PRODTYPE};
param MaxProd{PRODTYPE} default Infinity;

param RegularCost;
# regular workforce cost (Euro) for a single product 

param InvCost;    # inventory cost per product per period

param HireCost;   # hiring cost (Euro) 
param LayoffCost; # cost for laying off

param InitialInv;
param FinalInv; 

param Demand{1..T}; # demand per period

# initial workforce level
param InitialStaff;

# final required  workforce level
param FinalStaff;

var Prod{1..T, PRODTYPE} >=0, integer;
var Inv{0..T}, >=0;
var Hire{1..T} >=0, integer;
var Layoff{1..T} >=0, integer;
var Staff{0..T} >= 0;

minimize TotalCost :
	sum{t in 1..T, p in PRODTYPE diff {"Regular"}} (ProdCost[p] * Prod[t,p])
     +  sum{t in 1..T} (RegularCost * Staff[t] * MaxProd["Regular"] + InvCost * Inv[t]
                        + HireCost * Hire[t] + LayoffCost * Layoff[t] ) ;

s.t. inventory_balance{t in 1..T}:
	Inv[t] + Demand[t] = Inv[t-1] + sum {p in PRODTYPE} Prod[t,p];

s.t. initialInv:
	Inv[0] = InitialInv;

s.t. workforce{t in 1..T}:
	Staff[t-1] + Hire[t] = Staff[t] + Layoff[t];

s.t. initialWorkforce:
	Staff[0] = InitialStaff;

s.t. productionLimit{t in 1..T, p in PRODTYPE: p != "Regular"}:
	Prod[t,p] <= MaxProd[p];

s.t. regularProdutionLimit{t in 1..T}:
	Prod[t,"Regular"] <= Staff[t]*MaxProd["Regular"];

#======= additional constraints for level and chase, only for teaching purpose =======

s.t. Level{t in 2..T}:  #additional constraint to impose a level staff plan
       Staff[t] = Staff[t-1];


s.t. Chase{t in 1..T}:    #additional alternative constraint to impose a chase strategy
      Staff[t] = ceil(Demand[t] /  MaxProd["Regular"]);

# the above constraints are initialy not imposed:

drop Level;
drop Chase;
