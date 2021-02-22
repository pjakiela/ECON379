
* preliminaries

clear all
set more off
set seed 8675309
set scheme s1mono
version 16.1

* set directory path
cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L1-why-evaluate\

* import excel file containing the data
import excel using data\OWiD-net-official-development-assistance-and-aid-received.xlsx, first

* keep only data for entire world
keep if code=="OWID_WRL"
drop if year==2016


replace aid = aid/1000000000

* graph
twoway (bar aid year, barw(0.72) color(sea)), ///
	ytitle("Aid (billions of 2013 dolllars)" " ") ylab(0(50)200) ///
	xtitle(" " "Year") xlab(1960(5)2015)
	
cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L1-why-evaluate\fig
graph export aid-by-year.pdf, replace