

// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 12345

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L6-DD3\fig"


clear all
set seed 1234
set scheme s1mono
set more off

** locals, etc 

set obs 3

local color1 "sea"
local color2 "sky"
local color3 "vermillion*0.72"
local color4 "gs14"

local DbarA = 0.6
local DbarB = 0.2

local A0 = 20
local B0 = 16
local C0 = 4

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
gen arrow_y3 = 1 in 1
gen arrow_y4 = 1 in 1
gen arrow_y5 = 1 in 1
gen arrow_y6 = 1 in 1
gen arrow_x1 = 1 in 1
gen arrow_x2 = 16 in 1
gen arrow_x3 = 17 in 1
gen arrow_x4 = 32 in 1
gen arrow_x5 = 33 in 1
gen arrow_x6 = 40 in 1

** make figures

sum y
local ymax = r(max) + 5

twoway ///
	(connected y time if group=="A", color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B", color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color3'") msymbol(d) mlwidth(medthin) lwidth(medthin) lpattern(solid)), ///
	legend(cols(1) label(1 "Early Timing Group (A)") label(2 "Late Timing Group (B)") label(3 "Never-Treated Group (C)") size(vsmall) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' "y", angle(0) noticks) ytitle(" ")
graph export GBsummary1.pdf, replace	



twoway ///
	(connected y time if group=="A", color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B", color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color3'") msymbol(d) mlwidth(medthin) lwidth(medthin) lpattern(solid)), ///
	legend(cols(1) label(1 "Early Timing Group (A)") label(2 "Late Timing Group (B)") label(3 "Never-Treated Group (C)") size(vsmall) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' "y", angle(0) noticks) ytitle(" ") ///
	xline(16.5, lcolor(gs10) lwidth(thin)) ///
	xline(32.5, lcolor(gs10) lwidth(thin)) ///
	text(2 8.25 "t=1") text(2 24.55 "t=2") text(2 36.75 "t=3")
graph export GBsummary2.pdf, replace


** DD AC

twoway ///
	(connected y time if group=="A", color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B", color("`color4'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color3'") msymbol(d) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(pcbarrow arrow_y1 arrow_x1 arrow_y2 arrow_x2, color(gs10)) ///
	(pcbarrow arrow_y3 arrow_x3 arrow_y6 arrow_x6, color(gs10)), ///
	legend(cols(1) order(1 2 3) label(1 "Early Timing Group (A)") label(2 "Late Timing Group (B)") label(3 "Never-Treated Group (C)") size(vsmall) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' "y", angle(0) noticks) ytitle(" ") ///
	xline(16.5, lcolor(gs10) lwidth(thin)) ///
	text(3.5 8.25 "pre") text(3.5 28.5 "post") title("Group A vs. Group C")
graph export GBsubAC.pdf, replace

** DD BC
twoway ///
	(connected y time if group=="A", color("`color4'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B", color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color3'") msymbol(d) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(pcbarrow arrow_y1 arrow_x1 arrow_y4 arrow_x4, color(gs10)) ///
	(pcbarrow arrow_y5 arrow_x5 arrow_y6 arrow_x6, color(gs10)), ///
	legend(cols(1) order(1 2 3) label(1 "Early Timing Group (A)") label(2 "Late Timing Group (B)") label(3 "Never-Treated Group (C)") size(vsmall) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' "y", angle(0) noticks) ytitle(" ") ///
	xline(32.5, lcolor(gs10) lwidth(thin)) ///
	text(3.5 16 "pre") text(3.5 36.5 "post")  title("Group B vs. Group C")
graph export GBsubBC.pdf, replace


** DD AB
twoway ///
	(connected y time if group=="A", color("`color4'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B", color("`color4'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color4'") msymbol(d) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="A" & time<=32, color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B" & time<=32, color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(pcbarrow arrow_y1 arrow_x1 arrow_y2 arrow_x2, color(gs10)) ///
	(pcbarrow arrow_y3 arrow_x3 arrow_y4 arrow_x4, color(gs10)), ///
	legend(cols(1) order(4 5 3) label(4 "Early Timing Group (A)") label(5 "Late Timing Group (B)") label(3 "Never-Treated Group (C)") size(vsmall) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' "y", angle(0) noticks) ytitle(" ") ///
	xline(16.5, lcolor(gs10) lwidth(thin)) ///
	xline(32.5, lcolor(gs10) lwidth(thin)) ///
	text(3.5 8.25 "pre") text(3.5 24.5 "post")  title("Group A vs. Group B")
graph export GBsubAB.pdf, replace	


** DD BA
twoway ///
	(connected y time if group=="A", color("`color4'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B", color("`color4'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="C", color("`color4'") msymbol(d) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="A" & time>=17, color("`color1'") msymbol(o) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(connected y time if group=="B" & time>=17, color("`color2'") msymbol(t) mlwidth(medthin) lwidth(medthin) lpattern(solid)) ///
	(pcbarrow arrow_y5 arrow_x5 arrow_y6 arrow_x6, color(gs10)) ///
	(pcbarrow arrow_y3 arrow_x3 arrow_y4 arrow_x4, color(gs10)), ///
	legend(cols(1) order(4 5 3) label(4 "Early Timing Group (A)") label(5 "Late Timing Group (B)") label(3 "Never-Treated Group (C)") size(vsmall) ring(0) pos(10)) ///
	xlabel(1 " " `periods' "time", noticks) xtitle(" ") ///
	ylabel(1 " " `ymax' "y", angle(0) noticks) ytitle(" ") ///
	xline(16.5, lcolor(gs10) lwidth(thin)) ///
	xline(32.5, lcolor(gs10) lwidth(thin)) ///
	text(3.5 24.5 "pre") text(3.5 36.5 "post") title("Group B vs. Group A")
graph export GBsubBA.pdf, replace











