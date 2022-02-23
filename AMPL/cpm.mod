model sp.mod;
# inherit the standar shortest path model

param Duration{NODES} >= 0;  
# add a parameter associated to the duration of each activity

maximize Max_cost: sum{(i,j) in ARCS} Cost[i,j] * f[i,j];
# define the maximization objective function and declare we wish to use it

objective Max_cost;      
# choose to use this objective

