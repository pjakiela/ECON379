
clear
set obs 8 
gen id = 1 in 1/4
replace id = 2 in 5/8
gen t = mod(_n,4)
replace t = 4 if t==0

gen y = 0 
replace y = 1 if id==1 & t!=1
replace y = 1 if id==2 & t==4

gen d = y

*replace y = 10 if id==1 & t==3
replace y = 100 if id==1 & t==4
replace y = y+0.001*rnormal()
reg y i.id i.t d