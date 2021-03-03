
// ECON 379:  PROGRAM EVALUATION FOR INTERNATIONAL DEVELOPMENT
// PROFESSOR PAMELA JAKIELA
// EMPIRICAL EXERCISE 4 (IN-CLASS WARM-UP ACTIVITY)

/*****************************************************************************
In this exercise, we're going to analyze data from Ignaz Semmelweis' handwashing
intervention in the maternity hospital in Vienna.  The data come from 
Semmelweis' (1861) book, and some helpful person put them on Wikipedia.
We'll be reading them in from excel using the import excel command.
******************************************************************************/

// INSTALL BLINDSCHEMES IF YOU HAVE NOT ALREADY
* findit blindschemes // comment this out once it is installed
* exit


// IMPORT RAW DATA FROM EXCEL - ONLY NEED TO RUN THE FIRST TIME

clear all 
set scheme s1mono 
set more off
set seed 314159
version 16.1

** change working directory as appropriate to where you want to save
cd "C:\Users\pj\Dropbox\econ379-2021\exercises\E4-DD1"

** load the data from the course website
import excel using E4-Semmelweis1861-data.xlsx, sheet("ViennaBothClinics") first

** label the variables
label var Births1 "Births in Division 1 (Treatment Group)"
label var Deaths1 "Deaths in Division 1 (Treatment Group)"
label var Rate1 "Mortality Rate in Division 1 (Treatment Group)"
label var Births2 "Births in Division 2 (Comparison Group)"
label var Deaths2 "Deaths in Division 2 (Comparison Group)"
label var Rate2 "Mortality Rate in Division 2 (Comparison Group)"

** save the data locally as a stata dta file 
** this is also a good time to save your do file
save E4-semmelweis-vienna-by-wing.dta, replace


// ANALYSIS

** now we use the twoway command to make a graph comparing mortality rates 
** 	in the two wings of Vienna's maternity hospital

twoway (connected Rate1 Year, color(vermillion) msymbol(o) msize(small) lw(thin)) /// 
	(connected Rate2 Year, color(sea) msymbol(t) msize(small) lw(thin)), ///
	ylabel(0(5)20) ytitle("Maternal Mortality (Percent)" " ") ///
	xlabel(1830(5)1860) xtitle(" ") ///
	legend(label(1 "Doctors' Wing") label(2 "Midwives' Wing") col(1) ring(0) pos(2))
graph export vienna-by-wing-fig1.png, replace


// QUESTION 1
 
// Use the list command to list the the notes contained in the data set by year: 


// In what year did the Vienna Hospital move to the system where only midwives 
//		worked in the second clinic? Drop the observations (years) before 
// 		this happened using the drop command.


// QUESTION 2

// Now make a new version of your graph that plots this restricted data set. 
//		You'd want to modify the "xlabel(1830(5)1860" part of your code so that 
//		you only show a narrow window around the data you are plotting.  
//		Add a line showing when the hospital instituted the handwashing policy 
// 		by inserting the text "xline(1847)" somewhere *after* the comma in your 
///		twoway command


// Now you've made a graph of the first ever diff-in-diff.  

// QUESTION 3

// Generate a "post" variable equal to one for years after the handwashing policy 
//		wash implemented (and zero otherwise).  What is the mean postpartum mortality 
//		rate in the doctors' wing prior to the implementation of the handwashing policy?

// 		Remember that you can always use the "return list" command after a command 
//		like "summarize" to see what statistics the summarize command stored in 
// 		Stata's short-term memory as locals.  


// QUESTION 4

// We can calculate the standard error of the mean by hand by taking the standard deviation 
//		(reported by the "sum" command) and dividing it by the square root of the number of 
//		observartions.  (Hint:  you can do this more or less by hand by looking at the output 
//		from the "sum" command, but you can also use the fact that Stata saves the output 
//		of the "sum" command as local macros and use the command "display r(sd)/sqrt(r(N))" 
//		 immediately after "sum" to have Stata calculate the standard error of the mean 
//		for you from the standard deviation - saved as the local "r(sd)" - and the number of 
//		observations - saved as the local "r(N)".)  What is the standard error of the mean 
//		postpartum mortality rate in the doctors' wing prior to Semmelweis' handwashing 
//		intervention?


// QUESTION 5

//	You can also get the standard error of a mean using Stata "ci mean" command 
//		(the "ci" command gives you confidence intervals for different summary 
//		statistics, and "mean" is only one of the options).  Use the command 
//		"ci mean Rate1 if post==0" to confirm that your standard error calculation 
//		(above) is correct.  What is the upper bound of the 95 percent confidence 
//		interval for the mean of Rate1 in the years prior to the handwashing intervention? 


// QUESTION 6

// What is the mean postpartum mortality rate in the Doctors' Wing after the 
//		implementation of the handwashing intervention?


// QUESTION 7 

// What is the mean postpartum mortality rate in the Midwives' Wing before the 
//		implementation of the handwashing intervention?


// QUESTION 8 

// What is the mean postpartum mortality rate in the Midwives' Wing after the 
//		implementation of the handwashing intervention?


// QUESTION 9 

// Use these four means to calculate the difference-in-differences estimate 
//		of the impact of (doctors') handwashing after handling cadavers on postpartum 
//		mortality.  What is the estimated treatment effect?


// QUESTION 10

// If we assume that the four means are independent random variables, we can 
//		calculate the standard error associated with the difference-in-differences 
//		estimate of the treatment effect.  What is this standard error?  


// QUESTION 11

// We can also calculate the difference-in-differences estimate of the impact 
//		of Semmelweis' handwashing intervention by calculating the difference 
//		in the mortality rate between the Doctors' Wing and the Midwives' Wing, 
//		and testing whether this difference declines after the start of the 
//		intervention.  Do this, and estimate the treatment effect using a 
//		univariate linear regression.  What is the estimated coefficient on post?





