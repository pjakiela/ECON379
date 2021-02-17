

clear all
set seed 12345
set scheme s1mono

cd "C:\Users\pj\Dropbox\econ379-2021\lectures\L2-Selection-Bias\fig"

local numdraws = 1000
local mycolor "sea"

set obs `numdraws'
gen bin = _n in 1/101
*replace bin = bin-1

// 1 observation

gen mass = 0
replace mass = 0.5 in 1
replace mass = 0.5 in 101

twoway (bar mass bin, bcolor("`mycolor'")), xtitle(" " "Proportion Heads") xlabel(1 "0" 51 "0.5" 101 "1") ///
 ytitle("Probability" " ") ylabel(0(0.1)0.5) title("N = 1" " ")
graph export coinexample1.pdf, replace 

 
// 2 observations

replace mass = 0.25 in 1
replace mass = 0.5 in 51
replace mass = 0.25 in 101

twoway (bar mass bin, bcolor("`mycolor'")), xtitle(" " "Proportion Heads") xlabel(1 "0" 51 "0.5" 101 "1") ///
 ytitle("Probability" " ") ylabel(0(0.1)0.5) title("N = 2" " ")
graph export coinexample2.pdf, replace 


// N = 10

gen mean = .
forvalues i = 1/`numdraws' {
	gen rand`i' = runiform() in 1/10
	gen heads`i' = rand`i'>=0.5 if rand`i'!=.
	sum heads`i'
	replace mean = r(mean) in `i'
	drop rand* heads*
}

drop mass
gen mass = .
count if mean==0
replace mass = r(N)/`numdraws' in 1
forvalues i = 1/100 {
	local thismin = (`i'-1)/100
	local thismax = (`i')/100
	count if mean>`thismin' & mean<=`thismax'
	local thiscount = r(N)
	local j = `i' +1
	replace mass = `thiscount'/`numdraws' in `j'
}

twoway (bar mass bin, bcolor("`mycolor'")), xtitle(" " "Proportion Heads", size(large)) xlabel(1 "0" 51 "0.5" 101 "1") ///
 ytitle("Probability" " ", size(large)) ylabel(0(0.1)0.5) title("N = 10", size(huge))
graph export coinexample10.pdf, replace 


// N = 100

drop mean
gen mean = .
forvalues i = 1/`numdraws' {
	gen rand`i' = runiform() in 1/100
	gen heads`i' = rand`i'>=0.5 if rand`i'!=.
	sum heads`i'
	replace mean = r(mean) in `i'
	drop rand* heads*
}

drop mass
gen mass = .
count if mean==0
replace mass = r(N)/`numdraws' in 1
forvalues i = 1/100 {
	local thismin = (`i'-1)/101
	local thismax = (`i')/101
	count if mean>`thismin' & mean<=`thismax'
	local thiscount = r(N)
	local j = `i' + 1
	replace mass = `thiscount'/`numdraws' in `j'
}

twoway (bar mass bin, bcolor("`mycolor'")), xtitle(" " "Proportion Heads", size(large)) xlabel(1 "0" 51 "0.5" 101 "1") ///
 ytitle("Probability" " ", size(large)) ylabel(0(0.1)0.5) title("N = 100", size(huge))
graph export coinexample100.pdf, replace 


// N = 1000

drop mean
gen mean = .
forvalues i = 1/`numdraws' {
	gen rand`i' = runiform() in 1/1000
	gen heads`i' = rand`i'>=0.5 if rand`i'!=.
	sum heads`i'
	replace mean = r(mean) in `i'
	drop rand* heads*
}

drop mass
gen mass = .
count if mean==0
replace mass = r(N)/`numdraws' in 1
forvalues i = 1/100 {
	local thismin = (`i'-1)/100
	local thismax = (`i')/100
	count if mean>`thismin' & mean<=`thismax'
	local thiscount = r(N)
	local j = `i' + 1
	replace mass = `thiscount'/`numdraws' in `j'
}

twoway (bar mass bin, bcolor("`mycolor'")), xtitle(" " "Proportion Heads", size(large)) xlabel(1 "0" 51 "0.5" 101 "1") ///
 ytitle("Probability" " ", size(large)) ylabel(0(0.1)0.5)  title("N = 1,000", size(huge))
graph export coinexample1000.pdf, replace 


// N = 1000

set obs 10000
drop mean
gen mean = .
forvalues i = 1/`numdraws' {
	gen rand`i' = runiform() in 1/10000
	gen heads`i' = rand`i'>=0.5 if rand`i'!=.
	sum heads`i'
	replace mean = r(mean) in `i'
	drop rand* heads*
}

drop mass
gen mass = .
count if mean==0
replace mass = r(N)/`numdraws' in 1
forvalues i = 1/100 {
	local thismin = (`i'-1)/100
	local thismax = (`i')/100
	count if mean>`thismin' & mean<=`thismax'
	local thiscount = r(N)
	local j = `i' + 1
	replace mass = `thiscount'/`numdraws' in `j'
}

twoway (bar mass bin, bcolor("`mycolor'")), xtitle(" " "Proportion Heads", size(large)) xlabel(1 "0" 51 "0.5" 101 "1") ///
 ytitle("Probability" " ", size(large)) ylabel(0(0.1)0.5) title("N = 10,000", size(huge))
graph export coinexample10000.pdf, replace 

