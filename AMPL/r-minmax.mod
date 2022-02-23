# linear reression with optimal minimax error 

set LABEL ordered;

param Xdata{LABEL};
param Ydata {LABEL};

var a;
var b;

# model Y = a X + b

var zeta;

minimize minimax_regr: zeta;

subject to def_minimax_left {i in LABEL}:
  Ydata[i] - (a * Xdata[i] +b) >= -zeta; 

subject to def_minimax_right {i in LABEL}:
  Ydata[i] - (a * Xdata[i] +b) <= -zeta; 
