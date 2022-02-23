set ASSETS;

param r{ASSETS};
param Q{ASSETS,ASSETS};

param rmin;

var x{ASSETS} >= 0;

minimize risk: sum{a1 in ASSETS, a2 in ASSETS} x[a1]*x[a2]*Q[a1,a2];

s.t. return:
	sum {a in ASSETS} r[a]*x[a]  >= rmin;

s.t. total:
	sum{a in ASSETS} x[a] = 1;