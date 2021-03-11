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
time trend variable that they interact with treatment.  Their results are 
presented in Table 2 in their paper, which appears below:

![GO Table 2](https://pjakiela.github.io/ECON379/exercises/E6-DD3/GO-Tab2.png)

We are primarily interested in the interaction between our treatment variable, 
`high_exposure`, and the time trend:  if this variable is statistically significant, 
it indicates that the treatment and comparison groups were on different trajectories 
prior to the program.  

To replicate these results, we need to generate a time trend variable.  The data set 
contains the variable `time`; it indicates the the month and year in which a birth 
took place. However, `time` is formatted in Stata's date-time format, which even 
economics professors can never remember how to use.  Fortunately, we can use 
the `egen` command to create a trend variable after we sort the data by date:

```
sort time
egen trend = group(time) if post==0
```

The `egen` option `group` creates a variable indicating the different groups (or values) 
of the `time` variable.  So, in this data set, the `egen` command will generate a group variable as 
follows:

time|trend
----|----
Jul05|1
Jul05|1
Jul05|1
Aug05|2
Aug05|2
Oct05|3
Oct05|3

Notice that `egen` is just counting off the groups:  there are no observations 
from September of 2005, so October 2005 is the third group (ie the `egen` command 
is **not** telling us how many months have passed since the start of the data set). In this case, 
you can tab `time` and see that there aren't any missing months, so the `trend` variable 
_does_ also tell us how many months an observation is from the earliest observations in 
the data set - but that is because of the particular structure of this data set.  (Also, 
remember that you have to sort your data before using the `egen` command with the group 
option.)

Once you've generated the `trend` variable, you need to interact it with `high_exposure` 
(the treatment dummy).  Then you can regress an outcome like `tba` on the `high_exposure` 
variable, the `trend` variable, and the interaction between them.  The table notes 
above also indicate that Professor Godlonton and Dr. Okeke include district fixed effects; 
you can add these by adding `i.district` to your regression command.

Do you get the same results as the authors?  Specifically, do the coefficient and 
standard error on the variable `highxtrend` match up?

<br>

#### Implementing an Event Study

Adding the following code 
to your do file will use the `time` variable to generate a variable indicating how 
many years before or after Malawi's ban on TBAs a birth took place.  

```
tostring time, gen(test)
destring test, replace
gen monthdiff = (test - 546)-29 // months after ban
gen yeardiff = ceil(diff/12)
```

Tabulate the `yeardiff` variable.  What do you see?  How many years before/after the ban 
on TBAs appear in the data set?

To implement an event study, you'll need to do two things.  First, create dummies for 
births that occurred two years before the ban, one years before the ban, in the year 
after the ban, in the second year after the ban, or in the third year after the ban. 
I suggest calling these variables `minus2`, `minus1`, `plus1`, `plus2`, and `plus3`. 
Second, you need to interact these dummies with the treatment variable, `high_exposure`. 
So, you need to create a new set of varaibels `hxminus2`, `hxminus1`, `hxplus1`, `hxplus2`, 
and `hxplus3.`

Now you are ready to implement an event study!

#### Empirical Exercise

To implement our event study design, we need to replace or treatment-post interaction 
variable `highxpost` with our time-period specific interactions, `hxminus2`, `hxminus1`, 
`hxplus1`, etc.  

Extend your do file to answer the following questions.

1. What fraction of the births in the data set occur in the year after treatment?  In othe words, what is the mean of the variable `plus1`?
2. What is the mean of the variable `hxminus1`?
3. Now implement your event study design to estimate the impact of Malawi's TBA ban on the use of TBAs.  Don't forget to include fixed effects for the birth month and district!  So you want to tun the regression:  `reg tba i.district i.time high_exp hxminus2 hxminus1 hxplus1 hxplus2 hxplus3, cluster(district)`.  What is the estimated coefficient on hxplus1?
4. Consider the three different coefficients estimating the treatment effect of the ban:  `hxplus1`, `hxplus2`, `hxplus3`.  How many of those coefficients are statistically significant in the sense of having p-values<0.05?
5. How large was the impact of Malawi's ban on TBAs after three years?  (In other words, what is the estimated coefficient on `hxplus3`?)
6. Now test the hypothesis that the imapct of the ban was the same in the first year after treatment and the third year after treatment using the test command.  Does the impact of the ban change over time?  What is the resulting p-value?
7. How would you test common trends in this setting (using the regression above)?  Implement such a test.  What is the resulting p-value reported after the test command?
8. Now think about how you would implement a placebo test, looking for a treatment effect on a variable (in the data set) that should not be impacted by treatment (hint:  look at Table 4 in the paper).  What variable in the data set would you use ot implement such a test?
9. Implement a placebo test by using your event study specification to look at the "treatment effect" on a variable that should not be impacted by treatment (the variable you stated above).  Then test the (joint) hypothesis that the coefficients on `hxplus1`, `hxplus2`, and `hxplus3` are equal to zero.  What is the p-value associated with this hypothesis test?


