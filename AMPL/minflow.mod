# generic min cost newtwork flow model
#
# illustration of the special network syntax available in AMPL

set NODES;
set ARCS within NODES cross NODES;

param cost {ARCS}, default 0; 
param L {ARCS} >= 0, default 0;
param U {(i,j) in ARCS} >= L[i,j], default Infinity;
param balance {NODES}, default 0;  # balance net-out minus net-in

minimize TotalCost;

node node {k in NODES}: net_out = balance[k];

arc Flow {(i,j) in ARCS} >= L[i,j], <= U[i,j],
    from node[i], to node[j], obj TotalCost cost[i,j];


