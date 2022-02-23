set NODES ordered;
set ARCS within (NODES cross NODES);
param Cost{ARCS};
param Cost2{ARCS};
param S symbolic in NODES;
param T symbolic in (NODES diff {S});

param beta{1..2} default Infinity;  # used for objectives turned into constraints
param lambda{1..2};# used for  linear combination of objectives

var f{ARCS} >= 0;

minimize cost1: sum{(i,j) in ARCS} Cost[i,j] * f[i,j];
minimize cost2: sum{(i,j) in ARCS} Cost2[i,j] * f[i,j];

subject to Conservation {n in NODES}:
	sum{(n,j) in ARCS} f[n,j] 
	- sum{(i,n) in ARCS} f[i,n] =
	if (n = S) then +1 
        else if (n = T) then -1
        else 0;

s.t. obj1AsConstraint:
	sum{(i,j) in ARCS} Cost[i,j] * f[i,j] <= beta[1];


s.t. obj2AsConstraint:
	sum{(i,j) in ARCS} Cost2[i,j] * f[i,j] <= beta[2];
