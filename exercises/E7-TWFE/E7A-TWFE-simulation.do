
** generate a min data set
clear
set seed 54321
set obs 8 
gen id = 1 in 1/4
replace id = 2 in 5/8
gen time = mod(_n,4) + 1
sort id time

** create a treatment variable
gen d = 0 
replace d = 1 if id==1 & t!=1
replace d = 1 if id==2 & t==4

** create an outcome variable
gen y = 4*d // homogeneous treatment effect
*replace y = 100 if id==1 & t==4 // effects increase

** add a bit of noise
replace y = y+0.01*rnormal()

** two-way fixed effects
reg y i.id i.time d