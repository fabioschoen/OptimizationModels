param T;
param p{1..T};
param q{1..T};
param h{1..T};
param s0;
param d{1..T};
param MaxProd;  # used for finit capacity

var x{t in 1..T,u in t..T} >=0;
var s{t in 0..T-1, s in t+1..T} >=0;
var delta{1..T} >=0, <=1;

minimize cost: sum{i in 1..T} (
                  sum{t in i..T} p[t]*x[i,t] +
                  sum{t in i+1..T} h[t]*s[i,t] +
	          q[i]*delta[i] );

s.t. balance{i in 1..T, t in i..T}:
	s[i-1,t] + x[i,t] =
	(if (i==t) then 0 else s[i,t]) +
        (if (i==t) then d[t] else 0);

s.t. fix0: s[0,1] = s0;
s.t. fixT{t in 2..T}: s[0,t] = 0;

s.t. logical{i in 1..T, t in i..T}:
     x[i,t] <= delta[i] * 
     	    if t == 1 then d[1] - s0
	    else d[t];

s.t. MaxCap{i in 1..T}: sum{t in i..T} x[i,t] <= MaxProd;
