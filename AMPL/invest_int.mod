#------------------------------------------------------#
#     financial  planning                              #
#------------------------------------------------------#

set INVEST; # investment options
param T;    # time horizon
param expenses{1..T} default 0;  # payments in the period
param income{1..T} default 0;    # revenues in the period
param StartCash;                 # initial available cash
param MinCash default 0;         # minimum desired cash level

param life{INVEST};              # number of periods before capital reimbursement
param nominal{INVEST};           # nominal interest rate

param mininvest{INVEST} default 1000;

var Buy{INVEST, 1..T} >=0, integer;       # amount to invest

var Cash{0..T} >= MinCash;       # cash level at the end of each period

var Reimburse{1..T} >= 0;        # reimbursement of past investments

maximize TotalInterest: sum {t in 1..T} sum {i in INVEST: life[i] < t} (mininvest[i]*Buy[i,t-life[i]] * nominal[i] * life[i] / 1200.);

s.t. Start:
	Cash[0] = StartCash;

s.t. CashFlow{t in 1..T}:
	Cash[t-1] + income[t] + Reimburse[t]
        = Cash[t] + expenses[t] + sum{i in INVEST} mininvest[i] * Buy[i,t];

s.t. interestCalculation{t in 1..T}:
	Reimburse[t] =  sum {i in INVEST: life[i] < t} (mininvest[i] * Buy[i,t-life[i]] * (1. + nominal[i] * life[i] / 1200.));

