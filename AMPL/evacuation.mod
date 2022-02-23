set DynNODES;
param MaxT;
set DynARCS within  DynNODES cross DynNODES;
param DynS symbolic in DynNODES;
param DynT symbolic in DynNODES;

param DynFmax{DynARCS};
param DynTime{DynARCS};


param S symbolic  := 'S' ;
param T symbolic := 'T';

set NODES := {i in (DynNODES union {S}), t in 1..MaxT} union {i in {T}, t in {MaxT}}; # union {S,1..MaxT} union {T,MaxT};

set ARCS := {(i,t,j,u) in (DynNODES union {S,T}) cross 1..MaxT cross (DynNODES union {S,T}) cross 1..MaxT:
	( (i,j) in DynARCS and u == t + DynTime[i,j] )
        or
        ( i == j and u = t+1 )}
union {(S,1,DynS,1)}
union {(i,t,j,u) in  DynNODES cross 1..MaxT cross {T} cross 1..MaxT: i == DynT and u == MaxT};

param Fmax{(i,t,j,u) in ARCS} := if i != j and i != S and j != T then DynFmax[i,j] else Infinity;


var Flow{(i,t,j,u) in ARCS} >=0, <= Fmax[i,t,j,u];
var v;

maximize TotalFLow: v;

s.t. balance {(i,t) in NODES}:
	sum {(j,u) in NODES: (i,t,j,u) in ARCS} Flow[i,t,j,u] -
        sum {(j,u) in NODES: (j,u,i,t) in ARCS} Flow[j,u,i,t] =
	if i == S and t == 1 then v
        else if i == T and t == MaxT then -v
        else 0;