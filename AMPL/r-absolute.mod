# linear reression with optimal absolute error 

set LABEL ordered;

param Xdata{LABEL};
param Ydata {LABEL};

var a;
var b;

# model Y = a X + b

var zeta{LABEL};

minimize minimax_abs: sum{i in LABEL} zeta[i];

subject to def_left {i in LABEL}:
  Ydata[i] - (a * Xdata[i] +b) >= -zeta[i]; 

subject to def_right {i in LABEL}:
  Ydata[i] - (a * Xdata[i] +b) <= zeta[i]; 
