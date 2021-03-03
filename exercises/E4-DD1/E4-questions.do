
// ECON 379:  PROGRAM EVALUATION FOR INTERNATIONAL DEVELOPMENT
// PROFESSOR PAMELA JAKIELA
// EMPIRICAL EXERCISE 4 

/*****************************************************************************
In this exercise, we're going to analyze data from Ignaz Semmelweis' handwashing
intervention in the maternity hospital in Vienna.  The data come from 
Semmelweis' (1861) book, and some helpful person put them on Wikipedia.
We'll be reading them in from excel using the import excel command.

Before starting the exercise, you should have installed the blindschemes package 
and downloaded and saved the data set E4-Semmelweis1861-data.xlsx.

We're going to look at the data from the main maternity hospitals in Vienna 
(treatment) and Dublin (control).  We've already examined Ignaz Semmelweis' 
handwashing intervention.  Now, we will test whether the *introduction* of the 
pathological anatomy program in Vienna (which used cadavers to train med students)
had an impact on the rate of postpartum mortality.
******************************************************************************/

// PRELIMINARIES

clear all 
set scheme s1mono 
set more off
set seed 314159
version 16.1

cd "C:\Users\pj\Dropbox\econ379-2021\exercises\E4-DD1"


// IMPORT RAW DATA FROM EXCEL 

import excel using E4-Semmelweis1861-data.xlsx, sheet("ViennaTotals") first
sort Year
save ViennaData.dta, replace

clear
import excel using E4-Semmelweis1861-data.xlsx, sheet("DublinTotals") first
sort Year
save DublinData.dta, replace


// MERGE DATA SETS

clear
use ViennaData.dta
merge 1:1 Year using DublinData.dta

// QUESTION 1

// Use the command "list Year V_Note" to list the comments about what was happening 
// 		at the Vienna Hospital in every year.  In what year did the "pathological anatomy"
//		program (ie the use of cadavers in anatomy class) begin?

// QUESTION 2

// Since we want to look at the *impact* of the pathological anatomy program, 
//		we want to drop observations from 1847 on (after Semmelweis' handwashing 
//		intervention was implemented in Vienna).  What is the mean rate of postpartum 
//		mortality at the *Dublin* hospital after dropping those observations?

// QUESTION 3

// Adapt your code from the in-class activity to make a figure showing the evolution 
//		of postpartum mortality rates in Vienna and Dublin.  You'll want to change the 
//		names of the dependent variables being plotted, the starting and ending years, 
//		and the labels on the two lines being graphed.  You are also welcome to make 
//		additional changes to the code to further modify your graph.


// QUESTION 4

// Generate a variable "post" that is equal to one for years when the pathological 
//		anatomy program was active in Vienna.  What is the mean of this variable?


// QUESTION 5

// What is the mean rate of postpartum mortality in Vienna before the introduction  
//		of the pathological anatomy program?


// QUESTION 6

// What is the mean rate of postpartum mortality in Vienna after the introduction  
//		of the pathological anatomy program?


// QUESTION 7

// What is the mean rate of postpartum mortality in Dublin before the introduction  
//		of the pathological anatomy program?


// QUESTION 8

// What is the mean rate of postpartum mortality in Dublin before the introduction  
//		of the pathological anatomy program?


// QUESTION 9

// Use these four means to calculate the difference-in-differences estimate 
//		of the impact of Vienna's pathological anatomy training on postpartum 
//		mortality.  What is the estimated treatment effect?


// QUESTION 10 

// We can also calculate the difference-in-differences estimate of the impact 
//		of the pathological anatomy training by first calculating the difference 
//		in the mortality rate between the Vienna Hospital and the Dublin  
//		Hospital and then testing whether this difference declines after the 
//		start of the anatomy training curriculum.  Do this, and estimate the 
//		treatment effect using a univariate linear regression.  What is the 
//		estimated regression coefficient associated with the post variable?


// QUESTION 11

// What is the standard error associated with the post variable in the regression 
//		above?  


// QUESTION 12

// Did the introduction of an anatomy training program have a statistically significant 
//		impact on postpartum mortality in Vienna?  What is the t-statistic associated 
//		with the post variable in your difference-in-differences specification?










