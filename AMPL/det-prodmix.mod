set RESOURCES;
set PRODUCTS;
set SCENARIOS;

param Gain {PRODUCTS} >= 0;
param Avail{RESOURCES} >= 0;
param PenIns;
param PenEcc;
param Demand{PRODUCTS,SCENARIOS};
param Prob{SCENARIOS} >=0, <=1;
param ExpDemand{p in PRODUCTS} := sum{s in SCENARIOS} Demand[p,s]*Prob[s];
param MinQty{PRODUCTS} default 0;
param MaxQty{p in PRODUCTS} >= MinQty[p], default Infinity;

param Consumption {RESOURCES,PRODUCTS} >= 0;
#     consumo di risorse per unita di prodotto

var Qty{p in PRODUCTS} >= MinQty[p], <= MaxQty[p]; 
var Slack {PRODUCTS} >= 0;

maximize expeced_gain:  
    sum {p in PRODUCTS, s in SCENARIOS} Gain[p] * Qty[p]
    - sum{p in PRODUCTS} Slack[p]*PenIns;


subject to max_consumption {r in RESOURCES}:
   sum {p in PRODUCTS} Consumption[r,p] * Qty[p] <= Avail[r];

subject to def_slack{p in PRODUCTS}:
	Slack[p] = ExpDemand[p]- Qty[p];

