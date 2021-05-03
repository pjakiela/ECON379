## Empirical Exercise 11, Part C

In this exercise, we'll learn how to determine the appropriate sample size for cluster-randomized 
trials.  As discussed in _Running Randomized Evaluations_, researchers often assign treatment 
at the cluster level (e.g. at the school, community, or market level) when we are worried about 
potential spillovers across individuals within a cluster.

#### Getting Started

The `do` file below generates (i.e. simulates) a data set that is **clustered**:  observations 
are grouped into clusters, and outcomes (even in the absence of treatment) are correlated 
within each cluster.  So, for example, this could be a data set of student test scores where 
the individual unit of observation is the student and the cluster is the classroom; students 
within a classroom are in the same grade and the same school, have the same teacher, and talk to each other - so 
we might expect their scores to be correlated.  The local macro `numclusters` indicates the number of 
clusters in the similuated data set, and the local macro `obspercluster` indicates the number 
of observations per cluster.  As you can see, the current values of those macros create a data set 
with only one observation per cluster (so this is a clustered data set in name only at this point - though 
you will fix that shortly).  

```
clear all
set seed 24601

local numclusters = 1000
local obspercluster = 1
local effect = 0

// create an empty matrix to save results

local loopmax=100
matrix pval=J(`loopmax',1,.)

// create data sets w/ clusters

forvalues i  =1/`loopmax' {
    display "Loop iteration `i'"
	set obs `numclusters'
	gen clustid = _n
	gen treatment=cond(_n>`numclusters'/2,1,0)
	gen clusteffect = rnormal()
	gen y = clusteffect + `effect'*treatment + rnormal()
	reg y treatment
	mat V = r(table)
	matrix pval[`i',1]=V[4,1]
	drop clustid treatment clusteffect y
}

svmat pval
summarize
gen significant = pval<0.05
tab significant
```

The line 
```
matrix pval=J(`loopmax',1,.)
```
is new.  The `matrix` command allows you to create (unsuprisingly) a matrix 
where you can store results.  Using the `matrix` command with the function `J` 
defines a repeating matrix:  for example `matrix X = J(10,8,1)` would define a 
matrix one ones with 10 rows and 8 columns.  Here we define an empty matrix with 
`loopmax` rows and one column (so, really, it is a vector).  We can use this to 
record the p-values that we calculate in our simulations.  

We use the `matrix` command again inside the loop.  The command `mat V = r(table)` 
saves the results of a regression in the matrix `V`.  For example, suppose you ran the command 
`reg y x1 x2` and saw the Stata output below.  

![reg-output](https://pjakiela.github.io/ECON379/exercises/E11-power/reg-output.png)

If you ran the command `mat V = r(table)` and then used the command `mat list V` 
to display the matrix, you'd see this:  

![mat-list](https://pjakiela.github.io/ECON379/exercises/E11-power/mat-list.png)

You can see that Stata has now created a 9x3 matrix that contains all the estimated 
coefficients, standard errors, t-statistics, p-values, etc. from the regression.  The 
columns of the matrix represent the independent variables in the regression, in the 
order that you entered them.  The last column reports the estimated constant term, its 
standard error, etc.  

In our loop, we save our regression results in the matrix `V` and then immediately 
save the p-value associated with the `treatment` variable (the only independent variable 
in our regression) as one term in the `pval` vector that we defined prior to running the loop.  This 
means that, once our loop has run through all 100 iterations, we'll have a vector containing 
all 100 resulting p-values, which we can then save as a variable using the `svmat` command.  

##### Question 1

Look carefully at the program.  Make sure you understand what is happening in every line 
(and if you do not, come ask me to explain anything that is confusing!).  What is the 
mean of the `treatment` variable (in each iteration of the loop)?  You should be able 
to figure this out without running the code.

##### Question 2

Looking at the current values of the local macros, would you say that the null hypothesis is 
true or false?

##### Question 3

When you run the code and it tabulates the `significant` variable at the end, 
what is the **expected** number of times that you will reject the null hypothesis?  

##### Question 4

Now run the code.  How many times do you actually reject the null hypothesis?

##### Question 5

Change the number of iterations (the number of times the loop runs) to 1,000, 
and then run the code again.  How many times do you reject the null hypothesis now?




