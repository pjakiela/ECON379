## Empirical Exercise 5  

In this exercise, we're going to be replicating the first difference-in-differences specification reported Table 5 
of [Does a ban on informal health providers save lives? Evidence from Malawi](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4677333/) 
by Professor Susan Godlonton and Dr. Edward Okeke.  The table summarizes the impact of Malawi's 2007 ban on the use of 
traditional birth attendants (TBAs) on birth outcomes, including both the use of formal sector providers and neonatal mortality.

<br>

#### Getting Started

The data set E5-GodlontonOkeke-data.dta is available on glow.  It contains information (from the 
[2010 Malawi Demographic and Health Survey](https://dhsprogram.com/methodology/survey/survey-display-333.cfm)) 
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

<br>

#### Generating the Variables Needed for Analysis

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

Next we need to define an indicator for the treatment group.  Professor Godlonton and Dr. Okeke 
define the treatment group as DHS clusters (ie communities) that were at or above the 
75th percentile in terms of use of TBAs prior to the ban.  Data 
on use of TBAs comes from responses to the question below:

![dhs](https://pjakiela.github.io/ECON379/exercises/E5-DD2/DHS-question.png)

Responses have been converted into a set of different variables representing the different 
types of attendants who might have been present at the birth.  Tabulate (using the `tab` command) 
the `m3g` variable, which indicates whether a woman indicated that a TBA was present at a birth.  
What pattern of responses do you observe?

We want to generate a dummy variable that is equal to one if a TBA was present at a particular birth, 
equal to zero if a TBA was not present, and equal to "." (ie is missing) if a woman did not 
answer the question about TBAs.  There are several different ways to do this in Stata.  One 
is to use the `recode` command:  `recode m3g (9=.), gen(tba)`.  This generates a new variable, 
`tba` that is the same as the `m3g` variable except that `tba` is equal to missing for all 
observations where `m3g` is equal to 9.  (It is always better to generate a new variable 
instead of modifying the variables in your raw data set, because you don't want to make 
mistakes that you cannot undo.)  Confirm that your new variable, `tba`, is a dummy variable.  
Use the command `tab tba, m` to tabulate the observed values of `tba` (the `, m` option tells 
Stata to tabulate the number of missing values in addition to the other values).

We want generate a treatment dummy - an indicator for DHS clusters where use of TBAs was at or above 
the 75th percentile prior to the ban.  How should we do it?  the variable `dhsclust` is an ID number 
for each DHS cluster.  How many clusters are there in the data set?  Remember that we can use the `egen` command 
to generate a variable equal to the mean of another variable, and we can use `egen` with the `bysort` option 
to generate a variable equal to the mean within different groups:

```
bysort dhsclust:  egen meantba = mean(tba)
```

However, this tells us the mean use of TBAs within a DHS cluster over the entire sample period, 
but we only want a measure of the mean in  the pre-ban period.  How could you modify the code above 
to calculate the level of TBA use prior to the ban?  

Now summarize your `meantba` variable using the `, detail` or `, d` option after the `sum` command 
so that you can calculate the 75th percentil of TBA use in the pre-ban period.  As we've seen in earlier 
exercises, you can use the `return list` command after summarize to see which locals are saved when 
you run the `summarize` command in Stata:

``` 
sum meantba, d
return list
local cutoff = r(p75)
```

The last line in the code above (when implemented immediately after the `sum meantba, d` command, 
stores a local macro equal to the 75th percentile of the variable `meantba`.  Now we need to create a new variable `high_exposure` that is an 
indicator for DHS clusters where the level of TBA use prior to the ban exceeded the cutoff we just 
calculated.  How might you go about doing this?  

At this point, you may be encountering a small problem:  you've successfully defined a `high_exposure` 
variable that is an indicator for DHS clusters where the level of TBA use was at or above the 
75th percentile in the pre-ban period, but your `treatment` variable is missing for all births 
in the post-ban period.  Why might this be the case?  This issue comes up a lot.  Here are three lines of 
code that will fix it:

``` 
bys dhsclust:  egen maxtreat = max(high_exposure)
replace high_exposure = 1 if high_exposure==. & maxtreat==1 & tba!=.
drop maxtreat
```

Tabulate your `high_exposure` variable to make sure that it is only missing for observations 
with the `tba` variable missing.  What is the mean of `high_exposure`?

The last variable we need to conduct difference-in-differences analysis is an interaction between 
our treatment variable, `high_exposure`, and the post variable.  Generate such a variable.  
I suggest calling it `postxhighexp`.  Now you are ready to run a regression.

<br>

#### Replicating One Coefficient

Now you have the variables you need to run a 2x2 difference-in-differences analysis 
on the impact of Malawi's ban on TBAs on their use.  Do this.  How does the coefficient of interest 
(on the interaction between `post` and `high_exposure`) compare to the results reported in 
Panel A of Table 5 in Godlonton and Okeke (2015), shown below?

![table](https://pjakiela.github.io/ECON379/exercises/E5-DD2/GO-Tab5.png)

