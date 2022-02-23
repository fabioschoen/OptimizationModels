param T;  # time periods
set PROD;  # products
param p{1..T,PROD};
param q{1..T,PROD};
param h{1..T,PROD};
param s0{PROD} default 0;
param d{1..T,PROD};

set RESOURCE;

param Avail{1..T,RESOURCE};
param Consume{PROD,RESOURCE};
param Setup{PROD,RESOURCE};

var x{1..T,PROD} >=0;  
var s{0..T,PROD} >=0;
var delta{1..T,PROD} binary;

minimize cost: sum{t in 1..T, i in PROD} (p[t,i]*x[t,i] + q[t,i]*delta[t,i]
                                            + h[t,i]*s[t,i]);

s.t. balance{t in 1..T, i in PROD}:
     s[t-1,i] + x[t,i] = d[t,i] + s[t,i];

s.t. fix0{i in PROD}:
	s[0,i] = s0[i];

s.t. logical{t in 1..T, i in PROD}:
	x[t,i] <= delta[t,i] * sum{k in t..T} d[k,i];

s.t. resource_avail{t in 1..T, k in RESOURCE}:
	sum{i in PROD} Consume[i,k] * x[t,i] +
        sum{i in PROD} Setup[i,k] * delta[t,i] <= Avail[t,k];


