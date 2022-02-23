set NODES;

set RESISTORS within NODES cross NODES;
set GENERATORS within NODES cross NODES;

param R{RESISTORS} default 0;
param V{GENERATORS} default 0;

param Ground symbolic within NODES;

set ARCS := RESISTORS union GENERATORS;

var v{ARCS};
var u{NODES};

minimize Energy: 0.5 * sum{(i,j) in RESISTORS} (v[i,j] * v[i,j] / R[i,j]) ;

s.t. BalanceR{(i,j) in RESISTORS}:
	u[j] - u[i] = v[i,j];

s.t. BalanceG{(i,j) in GENERATORS}:
	u[j] - u[i] = V[i,j];

s.t. FixGround:
	u[Ground] = 0;
