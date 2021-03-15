## Empirical Exercise 7, Part 1  

This is the first of two exercises on difference-in-differences estimation using two-way fixed effects (TWFE).  In this exercise, 
we'll deepen our understanding of the mechanics of TWFE through a simple simulation exercise.  We'll create a small data 
set containing two units that are observed over four periods, and we'll calculate the TWFE estimator of a treatment effect 
of interest using both Excel and Stata.

<br>

## Getting Started

We are going to create a data set that has the following structure:

_Unit_|Period 1|Period 2|Period 3|Period 4
----|--------|--------|--------|--------
1| 0 | 1 | 1 | 1 
2| 0 | 0 | 0 | 1

We observe each of two **units** in each of four **time periods**.  Unit 1 
is treated in periods 2, 3, and 3, while Unit 2 is only treated in the last period.  Hence, this 
data set is identical to the one describe in lecture.

However, instead of organizing this data in **wide** form, as above, we're going to organize the 
data in **long** form so that every unit x time period is an individual obesrvation.  So, our data set will look like 
this:

Unit|Period|Treatment
----|------|---------
1|1|0
1|2|1
1|3|1
1|4|1
2|1|0
2|2|0
2|3|0
2|4|1

Open up Excel or google sheets and create a spreadsheet that looks like this, with 8 rows containing information 
on the treatment status of two units over four time periods.
