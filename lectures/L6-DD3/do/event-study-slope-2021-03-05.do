

// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 12345

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L6-DD3-Panel-Data\fig"

// locals, etc 

set obs 2

local color1 "sea*0.72"
local color2 "sea"
local color3 "vermillion"
local color4 "reddish"

local DbarA = 0.5
local DbarB = 0.2

local A0 = 20
local C0 = 12

local slope = 0.8

local effectA = 9
local effectB = 6

local periods = 40
local copies = 100
local errorscale = 10

** generate one observation per individual/unit (N)

gen id = _n
gen group = "A" if id==1
replace group = "C" if id==2

** expand to create NT observations

expand `periods'
bys id:  gen time = _n

** Expand again to make more units
expand `copies'

** treatment variable

gen dA = (group=="A" & time>(1-`DbarA')*`periods')
sum dA if group=="A"
assert r(mean)==`DbarA'

gen D = dA 

** outcome variable

gen y 		= `A0' + `slope'*time + `effectA'*dA 	+ `errorscale'*rnormal() if group=="A"
replace y 	= `C0' + `slope'*time 					+ `errorscale'*rnormal()  if group=="C"


forvalues i = 1/19 {
	local j = `i'+1
	gen minus`i' = (time==(1-`DbarA')*`periods' - `i')*(group=="A")
	gen plus`i' = (time==(1-`DbarA')*`periods' + `i')*(group=="A")
}

** restrict to small sample for figuere
drop if time<17 | time>23
replace y 		= y + `effectA'*dA  if group=="A" & time==22
replace y 		= y + 2*`effectA'*dA  if group=="A" & time==23

// event study figure

reg y minus3 minus2 minus1 plus1 plus2 plus3 i.time i.id 
mat V = r(table) 

gen x = _n-4 in 1/7
gen lower = .
gen upper = .
gen beta = .

forvalues i = 1/3 {
	replace beta = V[1,`i'] in `i'
	replace lower = V[5,`i'] in `i'
	replace upper = V[6,`i'] in `i'
}

forvalues i = 4/6 {
	local j = `i' + 1
	replace beta = V[1,`i'] in `j'
	replace lower = V[5,`i'] in `j'
	replace upper = V[6,`i'] in `j'
}


sum y
local ymax = r(max) + 5

twoway ///
	(rcap upper lower x, color("`color1'") )  ///
	(scatter beta x, mcolor("`color2'") msymbol(o)) , ///
	legend(off) ///
	xlabel(-4(1)4, noticks) xtitle(" " "Time relative to start of treatment") ///
	ylabel(-10(10)40) ytitle("Estimated treatment effect" " ") ///
	xline(0, lcolor("`color4'") lwidth(medthin)) ///
	yline(0, lcolor(gs12) lwidth(thin)) ///
	text(-7 -0.25 "PRE", place(w) size(large) color(reddish)) text(-7 0.25 "POST", place(e) size(large) color(reddish))

graph export event-study-slope.pdf, replace



