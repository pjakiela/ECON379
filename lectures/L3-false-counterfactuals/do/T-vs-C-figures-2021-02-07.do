

clear all
set seed 12345 
set scheme s1mono

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L3-False-Counterfactuals\fig"

set obs 5000

** binary treatment
gen r1 = rnormal()
sort r1
gen tempid = _n
gen t = mod(tempid,2)
drop r1 tempid

gen y = rnormal()
replace y = 3 + y + 2*t
replace y = y+0.01

** kdensity plots

local c1 "sea"
local c2 "turquoise"

gen x = _n
replace x = x/500

kdensity y if t==0, bwidth(0.2) g(dvar0) at(x) nograph
kdensity y if t==1, bwidth(0.2) g(dvar1) at(x) nograph

gen min = 0

twoway ///
	(rarea dvar0 min x, color(sea%60)) ///
	(rarea dvar1 min x, color(vermillion%60)), ///
	plotregion(margin(tiny)) ///
	legend(cols(1) label(1 "Treatment") label(2 "Control") ring(0) pos(2)) ///
	ylabel(0(0.1)0.6) ytitle("Density" " ") ///
	xlabel(0(1)10) xtitle(" " "Observed Outcome")
graph export TvsC-density.pdf, replace

** graph of regression with binary treatment (lower N for graph)
clear
set obs 100

gen r1 = rnormal()
sort r1
gen tempid = _n
gen t = mod(tempid,2)
drop r1 tempid

gen y = rnormal()
replace y = 4 + y + 1.5*t
replace y = y+0.01
	
twoway ///
	(lfit y t, lcolor(gs4) lwidth(thin) lpattern(solid)) ///
	(scatter y t if t==0, mcolor(sea%40)  mlwidth(thin) msymbol(o)) ///
	(scatter y t if t==1, mcolor(vermillion%64) mlwidth(thin) msymbol(o)), ///
	xlabel(0(1)1, grid) xtitle(" " "Treatment Status") ///
	ylabel(0(1)8, nogrid) ytitle("Dependent Variable" " ") ///
	xsc(lcolor(gs8) lwidth(thin)) ysc(lcolor(gs8) lwidth(thin)) ///
	plotregion(margin(medium) lcolor(gs8) lwidth(thin)) ///
	legend(off) 
graph export TvsCreg.pdf, replace

exit


** graph of regression with binary treatment (lower N for graph), similar means
clear
set obs 200

gen r1 = rnormal()
sort r1
gen tempid = _n
gen t = mod(tempid,2)
drop r1 tempid

gen y = rnormal()
replace y = 4 + y + 0.25*t
replace y = y+0.01
	
twoway ///
	(lfit y t, lcolor(gs4) lwidth(thin) lpattern(solid)) ///
	(scatter y t if t==0, mcolor(sea%40)  mlwidth(thin) msymbol(o)) ///
	(scatter y t if t==1, mcolor(vermillion%64) mlwidth(thin) msymbol(o)), ///
	xlabel(0(1)1, grid) xtitle(" " "Treatment Status") ///
	ylabel(0(1)8, nogrid) ytitle("Dependent Variable" " ") ///
	xsc(lcolor(gs8) lwidth(thin)) ysc(lcolor(gs8) lwidth(thin)) ///
	plotregion(margin(medium) lcolor(gs8) lwidth(thin)) ///
	legend(off) 
graph export TvsCreg2.pdf, replace

gen x = _n
replace x = x/20

kdensity y if t==0, bwidth(0.2) g(dvar0) at(x) nograph
kdensity y if t==1, bwidth(0.2) g(dvar1) at(x) nograph

gen min = 0

twoway ///
	(rarea dvar0 min x, color(sea%60)) ///
	(rarea dvar1 min x, color(vermillion%60)), ///
	plotregion(margin(tiny)) ///
	legend(cols(1) label(1 "Treatment") label(2 "Control") ring(0) pos(2)) ///
	ylabel(0(0.1)0.6) ytitle("Density" " ") ///
	xlabel(0(1)8) xtitle(" " "Observed Outcome")
*graph export TvsC-density2.pdf, replace



