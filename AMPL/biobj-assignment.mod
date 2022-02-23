set ORIGINS;
set DESTINATIONS;

set ARCS := ORIGINS cross DESTINATIONS;

param Cost1 {ARCS};
param Cost2 {ARCS};

var Assign{ARCS} binary;

param beta{1..2} default Infinity;  # used for objectives turned into constraints
param lambda{1..2};# used for  linear combination of objectives


minimize cost1:
	sum{(i,j) in ARCS} Cost1[i,j] * Assign[i,j];  

minimize cost2:
	sum{(i,j) in ARCS} Cost2[i,j] * Assign[i,j];  

minimize cost3: 
	sum{(i,j) in ARCS} (lambda[1]*Cost1[i,j] + lambda[2] *Cost2[i,j]) * Assign[i,j];

s.t. Out{i in ORIGINS}:
	sum{j in DESTINATIONS: (i,j) in ARCS} Assign[i,j] = 1;

s.t. In{j in DESTINATIONS}:
	sum{i in ORIGINS: (i,j) in ARCS} Assign[i,j] = 1;




s.t. obj1AsConstraint:
	sum{(i,j) in ARCS} Cost1[i,j] * Assign[i,j] <= beta[1];


s.t. obj2AsConstraint:
	sum{(i,j) in ARCS} Cost2[i,j] * Assign[i,j] <= beta[2];
