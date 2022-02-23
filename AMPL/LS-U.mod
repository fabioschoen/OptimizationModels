param T;
param p{1..T};
param q{1..T};
param h{1..T};
param s0;
param d{1..T};
param MaxProd;

var x{1..T} >=0;  
var s{0..T} >=0;
var delta{1..T} binary;

minimize cost: sum{t in 1..T} (p[t]*x[t] + q[t]*delta[t] + h[t]*s[t]);

s.t. balance{t in 1..T}:
     s[t-1] + x[t] = d[t] + s[t];

s.t. fix0: s[0] = s0;

s.t. logical{t in 1..T}:
     x[t] <= delta[t] * min(MaxProd,sum{k in t..T} d[k]);
