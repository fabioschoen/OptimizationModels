set OBJECTS;
param weight{OBJECTS};
param value{OBJECTS};
param cap;

var delta{OBJECTS}, binary;

maximize total_value: sum {j in OBJECTS} value[j] * delta[j];

s.t. knapsack:
   sum{j in OBJECTS} weight[j] * delta[j] <= cap; 