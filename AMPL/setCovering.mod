set REQUESTS;               # requests to be covered
set RESOURCES;              # available resources

set PAIRS within REQUESTS cross RESOURCES;

param cost{RESOURCES} >= 0, default 1;

var delta{RESOURCES} binary;minimize Total_Cost:
    sum {j in RESOURCES} cost[j] * delta[j];

subject to Covering{i in REQUESTS}: 
     sum {j in RESOURCES : (i,j) in PAIRS} delta[j] >= 1;
