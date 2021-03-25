

// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 1234

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L6-DD3\fig"

// locals, etc 

set obs 3

local color1 "sea"
local color2 "vermillion"
local color3 "vermillion"
local color4 "gs10"

local DbarA = 0.5
local DbarB = 0.2

local A0 = 20
local B0 = 16
local C0 = 12

local slope = 0.8

local effectA = 20
local effectB = 6

local periods = 40
local errorscale = 0.01

** generate one observation per individual/unit (N)

gen id = _n
gen group = "A" if id==1
replace group = "B" if id==2
replace group = "C" if id==3

** expand to create NT observations

expand `periods'
bys id:  gen time = _n

** treatment variable

gen dA = (group=="A" & time>(1-`DbarA')*`periods')
sum dA if group=="A"
assert r(mean)==`DbarA'

gen dB = (group=="B" & time>(1-`DbarB')*`periods')
sum dB if group=="B"
assert r(mean)==`DbarB'

gen D = dA + dB

** outcome variable

gen y 		= `A0' + `slope'*time + `effectA'*dA 	+ `errorscale'*rnormal() if group=="A"
replace y 	= `B0' + `slope'*time + `effectB'*dB 	+ `errorscale'*rnormal()	if group=="B"
replace y 	= `C0' + `slope'*time 					+ `errorscale'*rnormal()  if group=="C"

** coordinates for the arrows
gen arrow_y1 = 1 in 1
gen arrow_y2 = 1 in 1
gen arrow_x1 = 1 in 1
gen arrow_x2 = 16 in 1


// make figures

sum y
local ymax = r(max) + 5

twoway ///
	(connected y time if group=="A", color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)), ///
	legend(cols(1) label(1 "Treatment") label(2 "Control") size(small) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' " ", angle(0) noticks) ytitle("Dependent variable" " ") xline(20.5, lcolor("`color4'") lwidth(medthin)) ///
	text(2 10.5 "PRE") text(2 30.5 "POST")
graph export plainDD1.pdf, replace
	
sum y if group=="A" & (time<=(1-`DbarA')*`periods')
local tempmean = r(mean)
gen Ax = 4 in 1
replace Ax = 17 in 2
gen Ay = `tempmean' in 1/2

sum y if group=="A" & (time>(1-`DbarA')*`periods')
local tempmean = r(mean)
gen Bx = 24 in 1
replace Bx = 37 in 2
gen By = `tempmean' in 1/2

sum y if group=="C" & (time<=(1-`DbarA')*`periods')
local tempmean = r(mean)
gen Cx = 4 in 1
replace Cx = 17 in 2
gen Cy = `tempmean' in 1/2

sum y if group=="C" & (time>(1-`DbarA')*`periods')
local tempmean = r(mean)
gen Dx = 24 in 1
replace Dx = 37 in 2
gen Dy = `tempmean' in 1/2

twoway ///
	(connected y time if group=="A", color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected Ay Ax, color("`color1'") msymbol(i) lwidth(thin) lpattern(solid)) ///
	(connected By Bx, color("`color1'") msymbol(i) lwidth(thin) lpattern(solid)) ///
	(connected Cy Cx, color("`color2'") msymbol(i) lwidth(thin) lpattern(solid)) ///
	(connected Dy Dx, color("`color2'") msymbol(i) lwidth(thin) lpattern(solid)), ///
	legend(cols(1) label(1 "Treatment") label(2 "Control") size(small) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' " ", angle(0) noticks) ytitle("Dependent variable" " ") xline(20.5, lcolor("`color4'") lwidth(medthin)) ///
	text(2 10.5 "PRE") text(2 30.5 "POST")
graph export plainDD1-means.pdf, replace
	

exit

** with post-treatment trend

local effectA = 1
gen timeA = cond(time<=20 | group!="A",0,time - 20)
local slopeA = 1.2

replace y 		= `A0' + `slope'*time + `effectA'*dA  +`slopeA'*timeA*dA	+ `errorscale'*rnormal() if group=="A"

twoway ///
	(connected y time if group=="A", color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)), ///
	legend(cols(1) label(1 "Treatment") label(2 "Control") size(small) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' "y", angle(0) noticks) ytitle(" ") xline(20.5, lcolor("`color4'") lwidth(medthin)) ///
	text(2 10.5 "PRE") text(2 30.5 "POST")
graph export plainDD2.pdf, replace
