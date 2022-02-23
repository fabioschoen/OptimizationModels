set REQUESTS ordered;               # requests to be covered
set SHIFTS;                 # legal shifts

param A{SHIFTS,REQUESTS};  #Shifts in rows, periods in cols
param cost{SHIFTS} >= 0, default 1;
param req{REQUESTS} default 1;

var num{SHIFTS} integer, >= 0;

minimize Total_Cost:
    sum {j in SHIFTS} cost[j] * num[j];

subject to Covering{i in REQUESTS}: 
     sum {j in SHIFTS : A[j,i]==1} num[j] >= req[i];
