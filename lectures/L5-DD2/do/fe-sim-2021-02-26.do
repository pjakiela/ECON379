
clear all
set seed 123
set more off

set obs 100
gen id = _n
gen ind_mean = rnormal()

expand 100
sort id
bys id:  gen time = _n
sort time
gen temp = rnormal() if id==1
bys time:  egen time_mean = max(temp)
drop temp

gen post = time>=64
gen treatment = id>=41
gen txpost = treatment*post
gen delta = 5*txpost

gen bigeffect = (id>=71 & post==1)

gen y = delta + time_mean + ind_mean + 2*bigeffect + rnormal()
