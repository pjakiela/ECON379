// preliminaries 

set more off 
set scheme s1mono
	
if c(username)=="pj" {
	global datapath "C:/Users/pj/Dropbox/JDETrends"
	global dbpath "C:\Users\pj\Dropbox\econ379-2021\lectures\L2-Selection-Bias\fig"
}

cd "$dbpath"

// load data with all JDE abstracts
use "$datapath/data/JDE_Articles.dta", clear
drop if year==2019

// collapse into 5-year bins
gen bin = floor(year/5)
replace bin = 395 if bin==394 // 13 papers from 1974
replace bin = bin - 394
egen bintag = tag(bin)

// create variables of interest 

gen any_rct = regexm(abstract,"random")==1 & regexm(abstract,"evaluation")==1
replace any_rct = 1 if regexm(abstract,"random")==1 & regexm(abstract,"trial")==1
replace any_rct = 1 if regexm(abstract,"random")==1 & regexm(abstract,"experiment")==1
replace any_rct = 1 if regexm(abstract,"random")==1 & regexm(abstract,"assignment")==1
replace any_rct = 1 if regexm(abstract,"RCT")==1

gen any_quasi = regexm(abstract,"difference-in-difference")==1 
replace any_quasi = 1 if regexm(abstract,"regression discontinuity")==1 
replace any_quasi = 1 if regexm(abstract,"instrumental variables")==1
replace any_quasi = 1 if regexm(abstract,"2SLS")==1 
replace any_quasi = 1 if regexm(abstract,"stage lesat squares")==1 
replace any_quasi = 1 if regexm(abstract,"selection on observables")==1 

gen any_macro = regexm(abstract,"macroeconomic")==1

bys bin:  egen mean_macro = mean(any_macro)
bys bin:  egen mean_rct = mean(any_rct)
bys bin:  egen mean_quasi = mean(any_quasi)

gen xmacro = 3*bin - 1.5
gen xrct = 3*bin - 0.5

// make figure

twoway ///
	(bar mean_macro xmacro if bintag==1, barw(0.8) color(gs10)) ///
	(bar mean_rct xrct if bintag==1,  barw(0.8) color(turquoise)), ///
	plotregion(style(none)) xscale(lcolor(gs12)) yscale(lcolor(gs12)) ///
	xlabel(2 "1975" 5 "1980" 8 "1985" 11 "1990" 14 "1995" 17 "2000" 20 "2005" 23 "2010" 26 "2015", labgap(*2) noticks labsize(medium)) ///
	xtitle(" ") ylabel(0 "0" 0.02 "2" 0.04 "4" 0.06 "6" 0.08 "8" 0.1 "10", angle(0) labsize(medsmall)) ytitle("Percent of JDE Articles" " ") ///
	legend(cols(1) label(1 "Articles about macroeconomics") label(2 "Articles about randomized evaluations") ring(0) bplacement(nw) region(lstyle(none)))
graph export jde-hist1.pdf, replace	
	





