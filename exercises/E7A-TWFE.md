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
