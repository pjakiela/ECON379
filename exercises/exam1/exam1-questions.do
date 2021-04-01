
// EXAM 1 do file
// NAME:  


// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 314159

cd "C:\Users\pj\Dropbox\econ379-2021\exam1"

webuse set https://pjakiela.github.io/ECON379/exercises/exam1/

// YOURIDHERE with your Williams ID, the part of your email address before @
webuse ECON379-exam1-data-YOURIDHERE

// Question 26

// Test the hypothesis that the means of the variables q26_x1 and q26_x2 are equal 
//		using a t-test.  What is the resulting p-value?

// Question 27

// Use a t-test to test the hypothesis that the mean of the variable q27_x is 
//		different in the treatment and comparison groups defined by the 
//		variable q27_treatment.  What is the resulting p-value?

// Question 28A 

//	Use a regression to test the hypothesis that the mean of the variable q28_y 
//		is different in the treatment and comparison groups defined by the 
//		variable q28_treatment.  What is the estimated coefficient on the variable 
//		q28_treatment?

// Question 28B 

//	What is the standard error associated with the variable q28_treatment in the 
//		regression above?

// Question 29 

//	Use the variables q29_evertreated and q29_post to construct a 
//		difference-in-differences estimate of the impact of treatment on the 
//		outcome q29_y.  The units receiving treatment are those with 
//		q29_evertreated==1, and they post treatment period is defined by the 
//		q29_post variable.  What is the difference-in-difference estimate of  
//		the treatment effect?

// Question 30 

//	In this question, we'll use a panel data set.  The variable q30_time 
//		indicates the time period (time periods 1 thought 20), and those periods 
//		with q30_post=1 are the periods in which ever treated units receive 
//		treatment (time periods 8, 9, and 10).  The variable q30_evertreated 
//		is a dummy variable indicating units that are ever treated.  

//	Use this data set to calculate the difference-in-difference estimate of 
//		the treatment effect controling for time period fixed effects (but 
//		not unit-specific fixed effects).  The specification is comparable to 
//		the one you used in the replication of the paper by Professor Susan 
//		Godlonton and Dr. Edward Okeke (but there are no district fixed effects, 
//		and there is no clustering).

//		What is the estimated treatment effect?

// Question 31

//	In this question, we'll use a panel data set.  The variable q31_time 
//		indicates the time period (time periods 1 thought 20), and those periods 
//		with q31_post=1 are the periods in which ever treated units receive 
//		treatment (time periods 8, 9, and 10).  The variable q31_evertreated 
//		is a dummy variable indicating units that are ever treated. The 
//		variable q31_y is the outcome variable of interest.

//		Test the common trends assumption directly by testing the hypothesis 
//		that the pre-treatment trend in the outcome variable was the same 
//		for the treatment group and the comparison group.  What is the 
//		estimated coefficient of interest in this test of common trends? 

// Question 32 

// In this question, we'll use another panel data set.  The variable q32_time 
//		indicates the time period (time periods 1 thought 20), and the variables
//		q32_unit indicates the unit of observation.  The variable q32_treatment 
//		is a treatment dummy indicated whether unit i is treated in time 
//		period t.  All units are eventually treated.  

//	Estimate the impact of treatment (q32_treatment) on outcome q32_y using 
//		two-way fixed effects.  What is the estimated coefficient?

// Question 33

// In this question, we'll use another panel data set.  The variable q33_time 
//		indicates the time period (time periods 1 thought 20), and the variables
//		q33_unit indicates the unit of observation.  The variable q33_treatment 
//		is a treatment dummy indicated whether unit i is treated in time 
//		period t.  All units are eventually treated.  

//	Calculate the regression weights that would be used if you were to 
//		estimate the impact of treatment (q33_treatment) on outcome q33_y using 
//		two-way fixed effects.  What proportion (between 0 and 1) of 
//		treated observations receive negative weight in the estimation?