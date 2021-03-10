## Empirical Exercise 6  

In this exercise, we'll (once again) be working with data from 
[Does a ban on informal health providers save lives? Evidence from Malawi](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4677333/) 
by Professor Susan Godlonton and Dr. Edward Okeke.  The paper estimates the impact of Malawi's 2007 ban on the use of 
traditional birth attendants (TBAs) on birth outcomes, including both the use of formal sector providers and neonatal mortality.

<br>

#### Getting Started

The data set E5-GodlontonOkeke-data.dta is available on glow.  It contains information (from the 
[2010 Malawi Demographic and Health Survey](https://dhsprogram.com/methodology/survey/survey-display-333.cfm)) 
on 19,680 live births between July 2005 and September 2010.  Each observartion represents a birth.  Download the data, and then create 
a do file that opens the data set in Stata.  Our standard code for starting a do file will look something like:

``` 
/* Do file to replicate Table 5 
 from Godlonton & Okeke (2015) */

// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 123456

cd "C:\myfolder"
use "C:\mydatapath\E5-GodlontonOkeke-data.dta"
```

Next we need to generate our treatment dummy, as we did in [the last exercise](https://pjakiela.github.io/ECON379/exercises/E5-DD2) (an 
indicator for DHS clusters that are above the 75th percentile of pre-ban TBA use) and 
an interaction between our treatment dummy and the `post` variable that is already present in 
the data set.  We can do this using the following code:

```
recode m3g (9=.), gen(tba)
bys dhsclust:  egen tempvar = mean(tba) if post==0
bys dhsclust:  egen meantba = max(tempvar)
drop tempvar

sum meantba, d
local cutoff = r(p75)
gen high_exposure = meantba>=`cutoff' if tba!=. 
gen highxpost = high_exposure*post
```

The code generates a dummy variable `high_exposure` that idenitifies DHS clusters in the 
treatment group.

<br>

#### Testing Common Trends  

Professor Godlonton and Dr. Okeke test common trends directly by generating a 
time trend variable that they interact with treatment.  
