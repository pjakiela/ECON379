## Empirical Exercise 11, Part C

In this exercise, we'll learn how to determine the appropriate sample size for cluster-randomized 
trials.  As discussed in _Running Randomized Evaluations_, researchers often assign treatment 
at the cluster level (e.g. at the school, community, or market level) when we are worried about 
potential spillovers across individuals within a cluster.

```
clear all
set seed 24601

local numclusters = 1000
local obspercluster = 1
local effect = 0.25

// create an empty matrix to save results
local loopmax=1000
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
