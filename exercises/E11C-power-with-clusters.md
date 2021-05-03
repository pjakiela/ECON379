## Empirical Exercise 11, Part C

In this exercise we show...

```
clear all
set seed 24601

local numclusters = 1000
local obspercluster = 1
local effect = 0.25

// create an empty matrix to save results

local loopmax=1000
matrix pval=J(`loopmax',1,.)
matrix se=J(`loopmax',1,.)

// create a data set w/ clusters

forvalues i  =1/`loopmax' {
    display "Loop iteration `i'"
	quietly set obs `numclusters'
	quietly gen clustid = _n
	quietly gen treatment=cond(_n>`numclusters'/2,1,0)
	quietly gen clusteffect = rnormal()

	*quietly expand `obspercluster'
	quietly gen y = clusteffect + `effect'*treatment + rnormal()
	quietly reg y treatment
	mat V = r(table)
	matrix se[`i',1]=V[2,1]
	matrix pval[`i',1]=V[4,1]
	drop clustid treatment clusteffect y
}

svmat pval
summarize
gen significant = pval<0.05
tab sig
```
