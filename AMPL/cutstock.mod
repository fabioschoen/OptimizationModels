set OBJECTS;
set CONTAINERS;

param weight{OBJECTS};
param value{OBJECTS};
param capacity{CONTAINERS};

var delta{CONTAINERS, OBJECTS}, binary;

maximize total_value:
   sum {i in CONTAINERS, j in OBJECTS} value[j] * delta[i,j];
   
s.t. OneAtMost{j in OBJECTS}:
  sum{i in CONTAINERS} delta[i,j] <= 1;

s.t. CapacityConstraints{i in CONTAINERS}:
   sum{j in OBJECTS} weight[j] * delta[i,j] <= capacity[i];
   
