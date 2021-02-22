
* preliminaries

clear all
set more off
set seed 8675309
set scheme s1mono
version 16.1

* set directory path
cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L1-why-evaluate\

// AID DATA

* import excel file containing the data
import excel using data\OWiD-aid-per-capita-2021-02-10.xlsx, first

drop if code=="" | code=="OWID_WRL" // restrict attention to countries
drop if year==2016
bys code:  egen totalaid = sum(aid)
*replace totalaid = totalaid/1000000
label var totalaid "Aid received 1960-2015 (millions of US dollars)"
gen lnaid = ln(totalaid)
label var lnaid "Aid received 1960-2015 (millions of US dollars, log scale)"
keep if year==2015
drop year

sort code
save data\aid-received-1960-to-2015.dta, replace
clear

// GDP data
import excel using data\OWiD-gdp-per-capita-worldbank-2021-02-11.xlsx, first
drop if code=="" // restrict attention to countries
keep if year==2015
drop year
sort code

// MERGE DATA
merge 1:1 code using data\aid-received-1960-to-2015.dta
drop if _m!=3

// MAKE SCATTER PLOT

*drop if totalaid>4000 // small island nations
gen lngdp = ln(percap)

gen label = ent
replace label = "" if ent!="China" & ent!="India" & ent!="Iran" & ent!="Brazil" & ent!="Jordan" & ent!="Haiti" & ent!="Niger" & ent!="Sri Lanka" & ent!="Palau" & ent!="Kiribati"
gen pos = 12
replace pos = 3 if label=="Iran"
replace pos = 6 if label=="China"
replace pos = 2 if label=="Haiti"
replace pos = 6 if label=="Kiribati"

tw (lpolyci lngdp lnaid, color(sea%20) bw(0.52)) ///
	(scatter lngdp lnaid, msymbol(o) mcolor(reddish) msize(small) mlab(label) mlabsize(small) mlabc(reddish) mlabv(pos)) ///
	(lpoly lngdp lnaid, color(sea) bw(0.52)), ///
	plotregion(margin(small)) /// 
	xlabel(none, noticks grid glw(thin) glc(gs10)) ylabel(none, noticks glw(thin) glc(gs10)) ///
	xtitle(" " "Foreign Aid Received Per Capita 1960-2015 (in millions of dollars, log scale)", size(small)) ///
	ytitle("GDP Per Capita in 2015 (log scale)" " ", size(small))legend(off)
graph export fig/aid-vs-gdp.pdf, replace