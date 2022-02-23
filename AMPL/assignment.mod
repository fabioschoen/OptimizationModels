set ORIGINS;
set DESTINATIONS;

set ARCS := ORIGINS cross DESTINATIONS;

param Cost {ARCS};

var Assign{ARCS} >= 0;

minimize minCost:
	sum{(i,j) in ARCS} Cost[i,j] * Assign[i,j];  

s.t. Out{i in ORIGINS}:
	sum{j in DESTINATIONS: (i,j) in ARCS} Assign[i,j] = 1;

s.t. In{j in DESTINATIONS}:
	sum{i in ORIGINS: (i,j) in ARCS} Assign[i,j] = 1;


