set ACTIONS;

param Payoff{ACTIONS, ACTIONS};

var z;
var x{ACTIONS} >=0;

minimize RowLoss: z;

s.t. MinMax{j in ACTIONS}:
	z >= sum{i in ACTIONS} x[i] * Payoff[i,j];

s.t. Normalization:
	sum{i in ACTIONS} x[i] = 1;
