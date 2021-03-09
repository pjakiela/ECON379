
// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 123456

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L5-DD2\fig"
use "C:\Users\pj\Dropbox\econ379-2021\exercises\E5-DD2\data\GodlontonOkekeData.dta"

// VARIABLES FOR TBA USE PRE AND POST BAN

recode m3g (9=.), gen(tba)

bys dhsclust:  egen tempvar = mean(tba) if post==0
bys dhsclust:  egen pre_mean = max(tempvar)
drop tempvar

bys dhsclust:  egen tempvar = mean(tba) if post==1
bys dhsclust:  egen post_mean = max(tempvar)
drop tempvar

gen delta_tba = post_mean - pre_mean

bys dhsclust:  egen tempvar = mean(neomort) if post==0
bys dhsclust:  egen pre_mort = max(tempvar)
drop tempvar

bys dhsclust:  egen tempvar = mean(neomort) if post==1
bys dhsclust:  egen post_mort = max(tempvar)
drop tempvar

gen delta_mort = post_mort - pre_mort

// OTHER VARIABLES

egen ctag = tag(dhsclust)

foreach letter in x y z {
    gen `letter' = .
	replace `letter' = 0 in 1	
}

replace x = 0.8 in 2
replace y = -0.8 in 2
replace z = 0 in 2

// MAKE GRAPHS



tw ///
	(lpolyci delta_mort pre_mean if ctag==1 & pre_mean<=0.81, color(sea%32)) ///
	(lpoly delta_mort pre_mean if ctag==1 & pre_mean<=0.81, color(sea)), ///
	aspect(1.5) legend(off) ///
	xline(0.2857143, lcolor(vermillion) lwidth(thin)) ///
	xlabel(0(0.2)0.8, grid gmin gmax glwidth(vthin) glcolor(gs12)) ///
	xtitle(" " "Percent of births with TBAs prior to ban", size(small)) ///
	ylabel(-0.1(0.05)0.1, grid gmin gmax glwidth(vthin) glcolor(gs12)) ///
	ytitle("Change in use of TBA after the ban (percent of births)" " ", size(small)) 
graph export mort-change-scatter.pdf, replace




