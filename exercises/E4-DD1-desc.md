# Empirical Exercise 4  

This is the empirical exercise associated with our [first module on difference-in-differences estimation](https://pjakiela.github.io/ECON379/M4-DD1.html). 
In this exercise, we're going to analyze data from Ignaz Semmelweis' handwashing 
intervention in the maternity hospital in Vienna.  The data come from 
Semmelweis' (1861) book, and some helpful person put them on Wikipedia.  

<br>

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

<br>

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

Make sure you understand every line in the code above before proceeding to 
the next part of the activity.  

Now use the code below to plot the maternal mortality rate in the two wings 
of Vienna's maternity hospital between 1833 and 1858.  We're using Stata's 
`twoway` command, which allows you to visualize the relationship between two 
variables in a number of different ways (eg as a bar graph, a scatter plot, etc).  


```
twoway (connected Rate1 Year, color(vermillion) msymbol(o) msize(small) lw(thin)) /// 
	(connected Rate2 Year, color(sea) msymbol(t) msize(small) lw(thin)), ///
	ylabel(0(5)20) ytitle("Maternal Mortality (Percent)" " ") ///
	xlabel(1830(5)1860) xtitle(" ") ///
	legend(label(1 "Doctors' Wing") label(2 "Midwives' Wing") col(1) ring(0) pos(2))
graph export vienna-by-wing-fig1.png, replace
```

There are several things to notice about this code.  First, we are breaking a long command 
into multiple lines using `///` at the end of each line.  Second, we're graphing 
two different dependent variables:  the maternal mortality rate in the doctors' wing and 
the maternal mortality rate in the midwives' wing.  
The `twoway` command allows you to overlay multiple plots on a single graph using the syntax 
``` 
twoway (type1 y1 x1, options) (type2 y2 x2, options)
```
where `type1` is the type of twoway graph (eg a scatter plot), `y1` is your first 
dependent variable, `x1` is your first independent variable, etc.  When we overlay plots 
in this way, we _usually_ use the same `x` variable in both plots - but not always.  

Finally, we use the `graph export` command to save our graph as a `.png` file.  You can 
also save your graph as a `pdf`.  Your graph should look like this:  

#### Warm-Up Activity Questions

1. Use the `list` command to list the the notes contained in the data set by year: ```list Year Note```.  In what year did the Vienna Hospital move to the system where only midwives worked in the second clinic? Drop the observations (years) before this happened using the `drop` command.
2. Now make a new version of your graph that plots this restricted data set.  You'd want to modify the `xlabel(1830(5)1860` part of your code so that you only show a narrow window around the data you are plotting.  Add a line showing when the hospital instituted the handwashing policy by inserting the text `xline(1847)` somewhere _after_ the comma in your `twoway` command.  Now you've made a graph of the first ever diff-in-diff.  

// QUESTION 3

// Generate a "post" variable equal to one for years after the handwashing policy 
//		wash implemented (and zero otherwise).  What is the mean maternal mortality 
//		rate in the doctors' wing prior to the implementation of the handwashing policy?

// 		Remember that you can always use the "return list" command after a command 
//		like "summarize" to see what statistics the summarize command stored in 
// 		Stata's short-term memory as locals.  

gen post = Year>=1847
sum Rate1 if post==0
di "r(mean)"

