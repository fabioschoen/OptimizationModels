set INPUTS ordered;
set OUTPUTS ordered;

set IO := INPUTS union OUTPUTS ordered;

set UNITS ordered;

param u symbolic in UNITS;

param iodata{UNITS, IO};

var weight{IO} >= 0;

maximize eff: sum{o in OUTPUTS} weight[o] * iodata[u,o];

s.t. normalization:
	sum{i in INPUTS} weight[i]* iodata[u,i] == 1;

s.t. comparison{j in UNITS}:
     sum {o in OUTPUTS} weight[o] * iodata[j,o] - 
     sum {i in INPUTS} weight[i] * iodata[j,i]  <= 0;
 
