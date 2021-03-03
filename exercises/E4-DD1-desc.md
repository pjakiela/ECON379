# Empirical Exercise 4  

This is the empirical exercise associated with our [first module on difference-in-differences estimation](https://pjakiela.github.io/ECON379/M4-DD1.html). 
In this exercise, we're going to analyze data from Ignaz Semmelweis' handwashing 
intervention in the maternity hospital in Vienna.  The data come from 
Semmelweis' (1861) book, and some helpful person put them on Wikipedia.  

### Getting Started  

To get started, create a directory for this exercise, and then save 
[Semmelweis data](https://pjakiela.github.io/ECON379/exercises/E4-DD1/E4-Semmelweis1861-data.xlsx) to your directory. 
The data set is in excel, so we'll be using Stata's `import excel` command to read them into Stata. 
To make sure that you have downloaded the data correctly, open Stata, change the directory to the 
new folder you created for this excercise (using the `cd` command), and then use the `ls` command to 
list the contents of the directory.  You should see the excel file containing Semmelweis' data on maternal mortality 
listed in your directory.  

We'll be making graphs in this exercise.  Before doing this, you should install Stata's `blindschemes` 
package if you have not already.  Type the command `findit blindschemes` to look for the package on the web. 
You should see a window that looks like this (minus the red arrow):  

![stata-blindschemes](https://pjakiela.github.io/ECON379/exercises/E4-DD1/blindschemes.png)  

Click the first link (where the arrow is pointing) and follow the instructions to install the 
`blindschemes` package. This will allow you to access the colors of the 
[Okabe-Ito colorblind-friendly palette](https://jfly.uni-koeln.de/color/) to make 
elegant data visualizations.  

### Warm-Up Activity  

In this activity, we'll look at data from Vienna's two clinics:  the Doctor's Wing 
which was staffed by doctors and trainee doctors (who handled cadavers as part of their training) 
and the Midwive's Wing which was staffed by (unsurprisingly) midwives (who did not 
handle cadavers).  Use the following Stata code to read in and prep your data:  

```
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
```

We start with the usual preliminaries (setting the seed, etc.), 
the we use the `import excel` command to read in the data.  Notice 
that we use the `sheet()` option to specify which sheet we want to use 
and the `first` option to tell Stata that the first row in our data set 
is variable names rather than data values.  The last thing we do is 
use the `label var` command to assign each variable a descriptive label 
(that would appear, for example, if we listed the variables and their 
descriptions using the `desc` command).  

