## Empirical Exercise 5  

In this exercise, we're going to be replicating the first difference-in-differences specification reported Table 5 
of [Does a ban on informal health providers save lives? Evidence from Malawi](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4677333/) 
by Professor Susan Godlonton and Dr. Edward Okeke.  

The data set E5-GodlontonOkeke-data.dta is available on glow.  It contains information (from the 2010 Malawi Demographic and Health Survey) 
on 19,680 live births between July 2005 and September 2010.  Each observartion represents a birth.  Download the data, and then create 
a do file that opens the data set in Stata.  Our standard code for starting a do file will look something like:

``` 
/* Do file to replicate Table 5 from Godlonton & Okeke (2015) */

// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 123456

cd "C:\Users\pj\Dropbox\econ379-2021\exercises\E5-DD2\fig"
use "C:\Users\pj\Dropbox\econ379-2021\exercises\E5-DD2\data\E5-GodlontonOkeke-data.dta"
```

To implement difference-in-differences, we need a dummy variable for the post treatment period, 
a dummy variable for the treatment group, and an interaction between the two. The post variable is 
already present in the data set.  What is the mean of the post variable?  

The `time` variable indicates the month and year in which a birth took place. If you type the command 
`desc time` you'll see the following output:

![desc-time](https://pjakiela.github.io/ECON379/exercises/E5-DD2/stata-time-desc.png)  

Notice that the `time` variable is formatted in Stata's date format:  it is stored as a number, 
but appears as a month and year when you describe or tabulate it.  

Use the command `tab time post` to see how Professor Godlonton and Dr. Okeke define the 
post-treatment time period in their analysis.  What is the first treated month?
