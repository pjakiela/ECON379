// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 1234

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L6-DD3\do"

// generate data 

local units = 100
local periods = 10

set obs `units'
gen id = _n
gen x = rnormal() // individual characteristic

expand 10
sort id
bys id:  gen time = _n

xtset id time

gen tempshock = rnormal() if id==1 // period-specific shock
bys time:  egen shock = max(tempshock)
drop tempshock


** when does treatent start in each unit?
** everything so far is random, so we don't need to randomize

gen group = ceil(id/20)
*en group = ceil((id+15)/23)
gen treatment = (time>2*(group - 1)) & group>1

** homogenous treatment effects
gen delta=2
*gen delta = cond(group==2 & treatment==1,10,0)
*gen delta = 2*(12-2*group)
*gen delta = cond(group==2,10*(time-2)*treatment,0)
*gen delta = 1 + time - 2*(group-1)

gen y = x + shock + delta*treatment + 2*rnormal()

gen effect = delta*treatment
replace effect = . if treatment==0
bys id:  egen evertreat = max(treatment)
bys id:  egen ind_effect = mean(effect)

reg y i.id i.time treatment, cluster(id)

** by hand
egen mean_y = mean(y)
egen mean_treatment = mean(treatment)

bys time:  egen time_y = mean(y)
bys time:  egen time_treat = mean(treatment)

bys id:  egen unit_y = mean(y)
bys id:  egen unit_treat = mean(treatment)
gen unit_norm_y = unit_y - mean_y
gen unit_norm_treat = unit_treat - mean_treat

gen tilde_y = y - time_y - unit_y + mean_y
gen tilde_treat = treat - time_treat - unit_treat + mean_treat

reg y i.id i.time treatment
reg tilde_y tilde_treat


*sum effect if evertreat==1
*sum ind_effect if evertreat==1