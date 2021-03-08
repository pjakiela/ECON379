## Empirical Exercise 5  

In this exercise, we're going to be replicating the first difference-in-differences specification reported Table 5 
of [Does a ban on informal health providers save lives? Evidence from Malawi](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4677333/) 
by Professor Susan Godlonton and Dr. Edward Okeke.  

The data set E5-GodlontonOkeke-data.dta is available on glow.  Download the data, and then create a do file that opens the data set in Stata 16. 
Our standard code for starting a do file will look something like:

``` 
// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 123456

cd "C:\Users\pj\Dropbox\econ379-2021\exercises\E5-DD2\fig"
use "C:\Users\pj\Dropbox\econ379-2021\exercises\E5-DD2\data\E5-GodlontonOkeke-data.dta"
```
