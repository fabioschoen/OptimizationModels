set LOCATIONS;
set FACILITIES;

param Dist{LOCATIONS, LOCATIONS};
param Flow{FACILITIES, FACILITIES};

var delta{FACILITIES, LOCATIONS} binary;  # assign facility i to location j


minimize TotalCost : sum{i in FACILITIES, j in FACILITIES, k in LOCATIONS, h in LOCATIONS}
     delta[i,k]*delta[j,h] * Dist[h,k]*Flow[i,j];

s.t. OneLocation{i in FACILITIES}:
	sum{j in LOCATIONS} delta[i,j] = 1;

s.t. OneFacility{j in LOCATIONS}:
	sum{i in FACILITIES} delta[i,j] = 1; 