

clear all
set seed 12345 
set scheme s1mono

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L2-Selection-Bias\fig"

set obs 500

** binary treatment
gen r1 = rnormal()
sort r1
gen tempid = _n
gen t = mod(tempid,2)
drop r1 tempid

gen y = rnormal()
replace y = 3 + y + t
replace y = y+0.01

** kdensity plots

local c1 "sea"
local c2 "turquoise"

gen x = _n
replace x = x/20

kdensity y if t==0, bwidth(0.2) g(dvar0) at(x) nograph
kdensity y if t==1, bwidth(0.2) g(dvar1) at(x) nograph

gen min = 0

twoway ///
	(hist y if t==0, color(sea%60)) ///
	(hist y if t==1, color(vermillion%40)), ///
	plotregion(margin(tiny)) ///
	legend(cols(1) label(1 "Treatment") label(2 "Control") ring(0) pos(2)) ///
	ylabel(0(0.1)0.6) ytitle("Fraction" " ") ///
	xlabel(0(1)8) xtitle(" " "Observed Outcome")
graph export TvsC-hist.pdf, replace

** reg on a dummy variable
keep in 1/100
twoway ///
	(lfit y t, lcolor(gs4) lwidth(thin) lpattern(solid)) ///
	(scatter y t if t==0, mcolor(sea%40)  mlwidth(thin) msymbol(o)) ///
	(scatter y t if t==1, mcolor(vermillion%64) mlwidth(thin) msymbol(o)), ///
	xlabel(0(1)1, grid) xtitle(" " "Treatment Status") ///
	ylabel(0(1)6, nogrid) ytitle("Dependent Variable" " ") ///
	xsc(lcolor(gs8) lwidth(thin)) ysc(lcolor(gs8) lwidth(thin)) ///
	plotregion(margin(medium) lcolor(gs8) lwidth(thin)) ///
	legend(off) 
graph export TvsCreg.pdf, replace

** reg with many values of X
expand 10, gen(newdata)
replace t = runiform() if newdata==1
reg y t if newdata==0
predict yhat, xb
replace yhat = yhat+rnormal()
replace yhat=6 if yhat>6
twoway ///
	(lfit y t if newdata==0, lcolor(gs4) lwidth(thin) lpattern(solid)) ///
	(scatter yhat t, mcolor(reddish%40) mlwidth(thin) msymbol(o)), ///
	xlabel(0(0.2)1, grid) xtitle(" " "Independent Variable") ///
	ylabel(0(1)6, grid) ytitle("Dependent Variable" " ") ///
	xsc(lcolor(gs8) lwidth(thin)) ysc(lcolor(gs8) lwidth(thin)) ///
	plotregion(margin(medium) lcolor(gs8) lwidth(thin)) ///
	legend(off) 
graph export reg-w-continuous-x.pdf, replace


