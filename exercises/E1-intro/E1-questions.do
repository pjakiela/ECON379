
/***************************************************************************
This exercise makes use of the data set E1-CohenEtAl-data.dta, 
a subset of the data used in the paper "Price Subsidies, 
Diagnostic Tests, and Targeting of Malaria Treatment: Evidence from a 
Randomized Controlled Trial" by Jessica Cohen, Pascaline Dupas, and Simone 
Schaner, published in the American Economic Review in 2015.  

The authors examine behavioral responses to various discounts (""subsidies) 
for malaria treatment, called "artemisinin combination therapy" 
or "ACT."
******************************************************************************/

/* This is an example of a Stata do file comment */

// LOAD DATA

// This is another example of a Stata do file comment

clear all 
set scheme s1mono 
set more off
set seed 12345
version 16.1

** a third type of Stata do file comment

** change working directory as appropriate to where you want to save
cd "C:\Users\ME\Dropbox\MYCLASS\exercises\E1-why-evaluate-etc"

** load the data from the course website
webuse set https://pjakiela.github.io/ECON379/exercises/E1-intro/
webuse E1-CohenEtAl-data.dta


** save the raw data so that you have a local copy
save E1-CohenEtAl-data-my-raw-data-copy, replace

/* As you answer the following questions, write your commands in the do file,
	so that you could run the whole file and (re)generate all of your answers. */

// 1. How many observations are in the data set?

// 2. What is the mean of the variable act_any (to three decimal places)?

** The variable act_any is a dummy for assignment to any treatment (positive subsidy)

// 3. How many people received a positive subsidy?

// 4. What is the standard deviation of the variable c_act?

** The variable c_act is a dummy for using ACT treatment during a malaria episode

// 5. How many respondents report using ACT treatment for malaria?

// 6. Regress c_act on act_any.  What is the R-squared?

// 7. What is the coefficient associated with the act_any variable?

// 8. What is the associated standard error?

// 9. What do you get when you divide the coefficient by the standard error?

// 10. What is the t-statistic associated with the act_any variable?




