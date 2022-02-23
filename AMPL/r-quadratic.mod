# linear regression with optimal squared error 

set LABEL ordered;

param Xdata{LABEL};
param Ydata {LABEL};

var a;
var b;

# model Y = a X + b


minimize min_squared: sum{i in LABEL}   (Ydata[i] - (a * Xdata[i] +b))**2.;
