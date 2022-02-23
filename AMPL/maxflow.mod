set NODES;
param S symbolic in NODES;
param T symbolic in NODES, != S;

set ARCS within NODES  cross NODES;

param Fmin{ARCS} >= 0, default 0;
param Fmax{(i,j) in ARCS} >= Fmin[i,j];

node balance {k in NODES}: net_in = 0;

arc Flow {(i,j) in ARCS} >= Fmin[i,j], <= Fmax[i,j],
    from balance[i], to balance[j];

arc In >= 0, to balance[S];

arc Out >= 0, from balance[T];

maximize FlussoTotale: In;

