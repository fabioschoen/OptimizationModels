set NODES ordered;
set ARCS within NODES cross NODES;
param Cost{ARCS} default 1;

param s symbolic in NODES;
param t symbolic in NODES;

var f{(i,j) in NODES cross NODES: (i,j) in ARCS or (j,i) in ARCS} >= 0;

minimize total_cost : sum{(i,j) in ARCS} Cost[i,j] * (f[i,j] + f[j,i]);

s.t. balance{v in NODES}:
	sum{j in NODES: (v,j) in ARCS or (j,v) in ARCS} f[v,j] -
        sum{j in NODES: (v,j) in ARCS or (j,v) in ARCS} f[j,v]  =
	if v == s then 1 else if v == t then -1 else 0;