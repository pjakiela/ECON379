// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 123456

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L5-DD2\fig"

// generate data where FEs matter

set obs 300
gen id = _n

gen group1 = (id<=100)
gen group3 = (id>=201)
gen group2 = (group1==0 & group3==0)

gen x = rnormal() - group1 + 2*group3 + 4

gen y = 2*x + 6*group1 - 8*group3 + 2*rnormal() + 4

sum x if group2==1
replace x = x-`r(mean)'
sum y if group2==1
replace y = y-`r(mean)'

** plot w/o identifying groups

reg y x
local mybeta = string(_b[x],"%03.2f")

tw ///
	(scatter y x if group1==1, msymbol(o) mcolor(turquoise%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(turquoise%32)) ///	
	(scatter y x if group3==1, msymbol(o) mcolor(turquoise%32)) ///
	(lfit y x, lcolor(turquoise)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	text(12 6.5 "{&beta}{subscript:OLS} = `mybeta'", color(turquoise*1.2) place(w) size(large))
graph export scatter1.pdf, replace


** plot w identifying groups
tw ///
	(scatter y x if group1==1, msymbol(o) mcolor(vermillion%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(sea%32)) ///	
	(scatter y x if group3==1, msymbol(o) mcolor(reddish%32)) ///
	(lfit y x, lcolor(turquoise)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	text(12 6.5 "{&beta}{subscript:OLS} = `mybeta'", color(turquoise*1.2) place(w) size(large))
graph export scatter2.pdf, replace


** plot w identifying groups & group-level regressions

reg y x if group1==1
local mybeta1 = string(_b[x],"%03.2f")
reg y x if group2==1
local mybeta2 = string(_b[x],"%03.2f")
reg y x if group3==1
local mybeta3 = string(_b[x],"%03.2f")

tw ///
	(scatter y x if group1==1, msymbol(o) mcolor(vermillion%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(sea%32)) ///	
	(scatter y x if group3==1, msymbol(o) mcolor(reddish%32)) ///
	(lfit y x if group1==1, lpattern(solid) lcolor(vermillion)) ///
	(lfit y x if group2==1, lpattern(solid) lcolor(sea)) ///	
	(lfit y x if group3==1, lpattern(solid) lcolor(reddish)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	text(12.5 6.5 "{&beta}{subscript:OLS} = `mybeta1'", color(vermillion) place(w) size(large)) ///
	text(10 6.5 "{&beta}{subscript:OLS} = `mybeta2'", color(sea) place(w) size(large)) ///
	text(7.5 6.5 "{&beta}{subscript:OLS} = `mybeta3'", color(reddish) place(w) size(large)) ///
	
graph export scatter3.pdf, replace


** plot mean for group 1

sum x if group1==1
local xmean1 = r(mean)
sum y if group1==1
local ymean1 = r(mean)

sum x if group2==1
local xmean2 = r(mean)
sum y if group2==1
local ymean2 = r(mean)

sum x if group3==1
local xmean3 = r(mean)
sum y if group3==1
local ymean3 = r(mean)

di "`xmean1' `ymean1' `xmean3' `ymean3'"

tw ///
	(scatter y x if group1==1, msymbol(o) mcolor(vermillion%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(sea%32)) ///	
	(scatter y x if group3==1, msymbol(o) mcolor(reddish%32)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	xline(`xmean1' , lcolor(vermillion) lwidth(thin)) ///
	yline(`ymean1' , lcolor(vermillion) lwidth(thin)) ///
	xline(`xmean2' , lcolor(sea) lwidth(thin)) ///
	yline(`ymean2' , lcolor(sea) lwidth(thin)) 
	
graph export scatter4.pdf, replace


** de-mean group 1

gen normx1 = x - `xmean1' if group1==1
gen normy1 = y - `ymean1' if group1==1

tw ///
	(scatter normy1 normx1 if group1==1, msymbol(o) mcolor(vermillion%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(sea%32)) ///	
	(scatter y x if group3==1, msymbol(o) mcolor(reddish%32)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	xline(`xmean1' , lcolor(gs10) lwidth(thin) lpattern(longdash)) ///
	yline(`ymean1' , lcolor(gs10) lwidth(thin) lpattern(longdash)) ///
	xline(`xmean2' , lcolor(vermillion) lwidth(thin)) ///
	yline(`ymean2' , lcolor(vermillion) lwidth(thin)) 
	
graph export scatter5.pdf, replace


** plot mean for group 3

tw ///
	(scatter normy1 normx1 if group1==1, msymbol(o) mcolor(vermillion%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(sea%32)) ///	
	(scatter y x if group3==1, msymbol(o) mcolor(reddish%32)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	xline(`xmean3' , lcolor(reddish) lwidth(thin)) ///
	yline(`ymean3' , lcolor(reddish) lwidth(thin)) ///
	xline(`xmean2' , lcolor(sea) lwidth(thin)) ///
	yline(`ymean2' , lcolor(sea) lwidth(thin)) 
	
graph export scatter6.pdf, replace



** de-mean group 3

gen normx3 = x - `xmean3' if group3==1
gen normy3 = y - `ymean3' if group3==1

tw ///
	(scatter normy1 normx1 if group1==1, msymbol(o) mcolor(vermillion%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(sea%32)) ///	
	(scatter normy3 normx3 if group3==1, msymbol(o) mcolor(reddish%32)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	xline(`xmean3' , lcolor(gs10) lwidth(thin) lpattern(longdash)) ///
	yline(`ymean3' , lcolor(gs10) lwidth(thin) lpattern(longdash)) ///
	xline(`xmean2' , lcolor(reddish) lwidth(thin)) ///
	yline(`ymean2' , lcolor(reddish) lwidth(thin)) 
	
graph export scatter7.pdf, replace



** regression with fixed effects

gen xnorm = cond(group1==1,normx1,cond(group3==1,normx3,x))
gen ynorm = cond(group1==1,normy1,cond(group3==1,normy3,y))

reg ynorm xnorm 
local mybeta = string(_b[x],"%03.2f")

tw ///
	(scatter normy1 normx1 if group1==1, msymbol(o) mcolor(vermillion%32)) ///
	(scatter y x if group2==1, msymbol(o) mcolor(sea%32)) ///	
	(scatter normy3 normx3 if group3==1, msymbol(o) mcolor(reddish%32)) ///
	(lfit ynorm xnorm, lcolor(turquoise)), ///
	legend(off) ///
	xlabel(-5 " " -2 " " 1 " " 4 " " 7 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	xtitle("Treatment variable") ///
	ylabel(-15 " " -7.5 " " 0 " " 7.5 " " 15 " ", noticks grid gmin gmax glcolor(gs14) glwidth(vthin)) ///
	ytitle("Dependent variable") ///
	xline(`xmean2' , lcolor(sea) lwidth(thin)) ///
	yline(`ymean2' , lcolor(sea) lwidth(thin)) ///
	text(12 6.5 "{&beta}{subscript:OLS} = `mybeta'", color(turquoise*1.2) place(w) size(large))
	
graph export scatter8.pdf, replace






