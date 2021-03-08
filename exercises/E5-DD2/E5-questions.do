
// ECON 379:  PROGRAM EVALUATION FOR INTERNATIONAL DEVELOPMENT
// PROFESSOR PAMELA JAKIELA
// EMPIRICAL EXERCISE 5 (IN-CLASS WARM-UP ACTIVITY)

/*****************************************************************************
In this exercise, we're going to analyze data from  we're going to be 
replicating the first difference-in-differences specification reported Table 5 
of "["Does a ban on informal health providers save lives? Evidence from Malawi"  
by Professor Susan Godlonton and Dr. Edward Okeke.  The table summarizes the 
impact of Malawi's 2007 ban on the use of traditional birth attendants (TBAs) 
on birth outcomes, including both the use of formal sector providers and 
neonatal mortality.

The data set E5-GodlontonOkeke-data.dta is available on glow.  It contains 
information (from the 2010 Malawi Demographic and Health Survey) on 19,680 live 
births between July 2005 and September 2010.  Each observartion represents a 
birth.
******************************************************************************/

// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 123456

cd "C:\Users\pj\Dropbox\econ379-2021\exercises\E5-DD2\"
use "C:\Users\pj\Dropbox\econ379-2021\exercises\E5-DD2\data\E5-GodlontonOkeke-data.dta"


// VARIABLES NEEDED FOR ANALYSIS

// ...fill in your code here...


// DIFF-IN-DIFF REGRESSIONS

// QUESTION 1

// What fraction of women in Malawi give birth in the presence of a skilled 
//		birth attendant? In other words, what is the mean of the sba variable?


// QUESTION 2

// Test the hypothesis that the proportion of women giving birth in the presence 
//		of a skilled birth attendant increased after Malawi introduced the ban 
//		on TBAs. What is the t-statistic associated with this hypothesis test?


// QUESTION 3

// Estimate a simple 2x2 difference-in-differences specification to measure 
//		the impact of Malawi's TBA ban on the use of SBAs.  What is the 
//		estimated coefficient of interest (ie the coefficient on highxpost)?


// QUESTION 4

// What is the coefficient on high_exposure?  


// QUESTION 5

// Now re-run your diff-in-diff estimation replacing the post variable with 
//		time fixed effects.  What is the estimated coefficient on high_exposure now?


// QUESTION 6

// As we saw above, Professor Godlonton and Dr. Okeke also include district 
//		fixed effects.  Re-run your diff-in-diff estimation including these 
//		as well.  What is the estimated coefficient on high_exp now?



