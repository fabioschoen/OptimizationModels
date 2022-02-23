#------------------------------------------------------#
#     finanical  planning                              #
#------------------------------------------------------#

function financialPlanning(model::Model, datafile::String)
    include(datafile)

@variable(model, Buy[INVEST, t in 1:T] >=0) ;

@variable(model, Cash[t in 0:T] >= MinCash) 
# cash level at the end of each period

@variable(model, Reimburse[t in 1:T] >= 0)

@objective(model, Max, sum(Buy[i,t-Int(invest_data[i,"life"])] * (invest_data[i,"nominal"] * invest_data[i,"life"] / 1200. )
        for t in 1:T, i in INVEST if invest_data[i,"life"] < t))

@constraint(model, Start, Cash[0] == StartCash)

@constraint(model, CashFlow[t in 1:T], Cash[t-1] + income[t] + Reimburse[t]
== Cash[t] + expenses[t] + sum(Buy[i,t] for i in INVEST))

@constraint(model, interestCalculation[t in 1:T],
    Reimburse[t] == sum(Buy[i,t-Int(invest_data[i,"life"])] * (1. + invest_data[i,"nominal"] * invest_data[i,"life"] / 1200. )
        for i in INVEST if invest_data[i,"life"] < t))
end

