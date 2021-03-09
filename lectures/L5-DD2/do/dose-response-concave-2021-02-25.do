
// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 123456

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L5-DD2\fig"

// generate continuous treatment variable x

set obs 500
gen x = runiform()

// concave dose response 

gen y_linear = cond(x<0.1,10*x,1) + rnormal()/10

** continuous treatment variable

tw ///
	(scatter y_linear x, mcolor(vermillion%24) msymbol(o)), ///
	legend(off) ///
	xlabel(0(0.25)1, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	xtitle(" " "Independent variable") ///
	ylabel(-0.5(0.5)1.5, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	ytitle("Change in dependent variable pre vs. post" " ") 
graph export concave-resp1.pdf, replace
	
** binary treatment variable

tw ///
	(scatter y_linear x, mcolor(vermillion%24) msymbol(o)) ///
	(lfit y_linear x, lcolor(sea) lwidth(thin)) , ///
	legend(off) ///
	xlabel(0(0.25)1, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	xtitle(" " "Independent variable") ///
	ylabel(-0.5(0.5)1.5, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	ytitle("Change in dependent variable pre vs. post" " ")  ///
	xline(0.5, lcolor(reddish)) ///
	text(-0.4 0.25 "comparison", color(reddish) place(n) size(large)) ///
	text(-0.4 0.75 "treatment", color(reddish) place(n) size(large)) 
graph export concave-resp2.pdf, replace

** binary treatment variable showing means/coefficients

egen c_mean = mean(y) if x<=0.5
egen t_mean = mean(y) if x>0.5

tw ///
	(scatter y_linear x if x<=0.5, mcolor(vermillion%24) msymbol(o)) ///
	(scatter y_linear x if x>0.5, mcolor(sea%24) msymbol(o)) ///
	(lfit c_mean x if x<=0.5, lcolor(vermillion) lwidth(thin)) ///
	(lfit t_mean x if x>0.5, lcolor(sea) lwidth(thin)) , ///
	legend(off) ///
	xlabel(0(0.25)1, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	xtitle(" " "Independent variable") ///
	ylabel(-0.5(0.5)1.5, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	ytitle("Change in dependent variable pre vs. post" " ")  ///
	xline(0.5, lcolor(reddish)) ///
	text(-0.4 0.25 "comparison", color(vermillion) place(n) size(large)) ///
	text(-0.4 0.75 "treatment", color(sea) place(n) size(large)) 
graph export concave-resp3.pdf, replace


** binary treatment variable showing mean points

gen mean_x = .
replace mean_x = 0.25 in 1
replace mean_x = 0.75 in 2
sum c_mean
gen mean_y = r(mean) in 1
sum t_mean
replace mean_y = r(mean) in 2 

tw ///
	(scatter y_linear x if x<=0.5, mcolor(vermillion%12) msymbol(o)) ///
	(scatter y_linear x if x>0.5, mcolor(sea%12) msymbol(o)) ///
	(lfit c_mean x if x<=0.5, lcolor(vermillion*0.5) lwidth(thin)) ///
	(lfit t_mean x if x>0.5, lcolor(sea*0.5) lwidth(thin))  ///
	(connected mean_y mean_x, msymbol(o) msize(large) mlcolor(red*1.2) mfcolor(red*0.6) lcolor(red*1.2) lwidth(medium) lpattern(solid)) , ///
	legend(off) ///
	xlabel(0(0.25)1, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	xtitle(" " "Independent variable") ///
	ylabel(-0.5(0.5)1.5, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	ytitle("Change in dependent variable pre vs. post" " ")  ///
	xline(0.5, lcolor(reddish*0.5)) ///
	text(-0.4 0.25 "comparison", color(vermillion) place(n) size(large)) ///
	text(-0.4 0.75 "treatment", color(sea) place(n) size(large)) 
graph export concave-resp4.pdf, replace


** binary treatment variable showing means at 0,1

gen alt_x = .
replace alt_x = 0 in 1
replace alt_x = 1 in 2

tw ///
	(scatter y_linear x if x<=0.5, mcolor(vermillion%12) msymbol(o)) ///
	(scatter y_linear x if x>0.5, mcolor(sea%12) msymbol(o)) ///
	(lfit c_mean x if x<=0.5, lcolor(vermillion*0.5) lwidth(thin)) ///
	(lfit t_mean x if x>0.5, lcolor(sea*0.5) lwidth(thin))  ///
	(connected mean_y mean_x, msymbol(o) msize(large) mlcolor(gs12) mfcolor(gs12*0.4) lcolor(gs12) lwidth(medium) lpattern(solid))  ///
	(connected mean_y alt_x, msymbol(o) msize(large) mlcolor(red*1.2) mfcolor(red*0.6) lcolor(red*1.2) lwidth(medium) lpattern(solid)) , ///
	legend(off) ///
	xlabel(0(0.25)1, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	xtitle(" " "Independent variable") ///
	ylabel(-0.5(0.5)1.5, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	ytitle("Change in dependent variable pre vs. post" " ")  ///
	xline(0.5, lcolor(reddish*0.5)) ///
	text(-0.4 0.25 "comparison", color(vermillion) place(n) size(large)) ///
	text(-0.4 0.75 "treatment", color(sea) place(n) size(large)) 
graph export concave-resp5.pdf, replace


** explanatory graph

gen z = y/x
sum z
local meanz = string(r(mean),"%03.2f")
reg y x 
local mybeta = string(_b[x],"%03.2f")
di `mybeta'
tw ///
	(lpolyci z x if x>0.1, fcolor(turquoise%20) lcolor(turquoise*1.2)  lwidth(thin)) ///
	(scatter y_linear x, mcolor(vermillion%24) msymbol(o)) ///
	(lfit y_linear x, lcolor(sea) lwidth(thin)) , ///
	legend(off) ///
	xlabel(0(0.25)1, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	xtitle(" " "Independent variable") ///
	ylabel(-2(2)10, grid gmin gmax glwidth(thin) glcolor(gs14)) ///
	ytitle("Change in dependent variable pre vs. post" " ")  ///
	xline(0.5, lcolor(reddish)) ///
	text(-0.4 0.25 "comparison", color(reddish) place(n) size(large)) ///
	text(-0.4 0.75 "treatment", color(reddish) place(n) size(large)) ///
	text(0.25 0.95 "{&beta}{subscript:TRUE} = `meanz'", color(turquoise*1.2) place(w) size(large)) ///
	text(0 0.95 "{&beta}{subscript:OLS} = `mybeta'", color(turquoise*1.2) place(w) size(large)) 
graph export concave-resp-explain.pdf, replace
 
 
