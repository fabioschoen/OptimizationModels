# adding valid inequalities
param Ineq default 0;
set cover{1..Ineq} within OBJECTS;
set amin within OBJECTS ordered;

s.t. CoverInequalities{i in 1..Ineq}:
    sum {obj in cover[i]} 
    delta[obj] <= card(cover[i]) -1 ;
    
