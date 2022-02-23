set NODES ordered;
set ARCS within (NODES cross NODES);
param Cost{ARCS};
param Time{ARCS};
param Tmax;

param S symbolic in NODES;
param T symbolic in (NODES diff {S});

var f{ARCS} >= 0;

minimize cost: sum{(i,j) in ARCS} Cost[i,j] * f[i,j];

subject to Conservation {n in NODES}:
	sum{(n,j) in ARCS} f[n,j] 
	- sum{(i,n) in ARCS} f[i,n] =
	if (n = S) then +1 
        else if (n = T) then -1
        else 0;

s.t. time: sum{(i,j) in ARCS} Time[i,j] * f[i,j] <= Tmax;