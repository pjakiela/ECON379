## Empirical Exercise 10

In this exercise, we'll be learning how to randomly assign treatment status in a way 
that is transparent and reproducible.  In practice, we'll typically want to 
**stratify** treatment assignments to insure balance on important covariates.  After 
assigning treatments, we'll check whether we've succeeded in creating treatment 
and comparison groups that are comparable in terms of their observable characteristics.

<br>

#### Getting Started

Start by creating a new do file that runs the following Stata code:

```
clear
set obs 4
gen id = _n 
gen randnum = runiform()
sort randnum
egen treatment = seq(), from(0) to(1)
```

What happens when you run the code?  Use Stata's data editor (the button that looks like 
a spreadsheet with a magnifying glass over it) to view the (very small) data set you 
created.  Which ID numbers are assigned to treatment?  Run the code several times:  are 
the same ID numbers assigned to treatment each time?  

The code above contains the three key parts of every randomization do file:  

1. A command that generates a pseudo-random number 
2. A command that sorts the data based on that random number
3. A command that assigns treatment based on that random sort order

However, we failed to set the seed, so each time we run our code, we get a 
completely new random treatment assignment.  Insert the command 

```
set seed 8675309 
```

between `clear` and `set obs 4`.  This will guarantee that Stata uses the 
same sequence of pseudo-random numbers every time you run the file.  Convince 
yourself of this by running the file a few times.  Even better, you and 
everyone else should be able to assign the exact same set of IDs to 
treatment.  

Now, modify the code so that you assign each of **9** observations to one of **3** 
treatment groups.  Do not change the seed, but re-run the code instead of adding to 
it.  Which ID numbers get assigned to treatment group 1 (of 3)?

<br>

#### Why We Stratify

Here is another simple program that randomly assigns treatment, but in this case
we also generate a single covariate, `x`.  The goal of randomization is to 
create treatment and comparison groups that are similar in terms of their 
observable characteristics.  Create a do file that runs the code below, 
and then check whether the treatment and comparison groups have similar 
values of `x` using the `ttest` command.

```
clear all
version 16.1
set seed 12345

set obs 100
gen id = _n 

gen x = rnormal()
gen randnum = runiform()
sort randnum
egen treatment = seq(), from(0) to(1)
```

What is the estimated difference in `x` between the treatment and the comparison 
group?  What is the p-value associated with the test of the hypothesis that 
the treatment and comparison groups have the same mean?

Now insert this line of code immediately afer the line where you generate `x`:

```
replace x = x+100 in 1/4
```

We've created a situation where our sample contains four outliers with very large 
values of `x`.  Test whether the mean of `x` is the same in the treatment and 
comparison groups.  What do you find?  Tabulate the `x` variable using the command `tab x treatment` 
so that you can see how many of the observations with large values of `x` happen to be 
in the treatment group.

To address this issue, we want to create a dummy variable indicating which observations 
have very large values of `x`, and then **stratify** our treatment assignments.    We 
can generate a dummy variable `largex` as follows:

```
gen largex = x>99
```

Now you want to stratify your treatment assignments.  To do this, we'll sort 
our data by `largex` and `randnum` before we assign treatment.  Run a t-test 
to confirm that this procedure generates treatment and comparison groups 
that are comparable in terms of `x`.

<br>

#### Empirical Exercise

Create a new do file similar to the one we used above:

```
clear all
version 16.1
set seed 12345

set obs 100
gen id = _n 

forvalues i = 1/20 {
	gen x`i' = rnormal()
}

gen randnum = runiform()
sort randnum
egen treatment = seq(), from(0) to(1)
```

The only difference between this code and the code we used earlier is that 
here we generate 20 different covariates using a loop.  The line `forvalues  i = 1/20` 
tells Stata to loop through the numbers 1 through 20.  For each value of `i` between 1 and 20, 
Stata generates a variable xi (ie variables `x1` through `x20`).  Each of these variables is a 
normally-distributed random variable.  

###### Question 1

Add an additional loop to the code that tests whether each variables (`x1` through `x20`) is 
balanced (ie you cannot reject the hypothesis that the treatment and comparison groups are 
drawn from populations with the same means).  First, generate a variable `pvalue` that is missing 
for all observations using the command `gen pvalue = .`  Then write a loop that first tests whether 
each covariate differs across the treatment and comparison groups.  You can save your p-values 
as the values of the p-value variable using the following code (I'm showing you the example for the variable `x1`):

```
ttest x1, by(treatment)
replace pvalue = r(p) in 1
```

How many of your 20 covariates are imbalanced (at the 5% level of statistical significance)?

###### Question 2

Now increase your sample size to 100,000 and re-run your code.  How many of the covariates are imbalanced now?

###### Question 3

Reduce the sample size to 10,000 observations and re-run your code.  Which covariates are imbalanced?  (One way 
to see this quickly is to use the command `list pvalue if pvalue!=.` - this will show you the p-values and 
the line numbers where they appear.)  Confirm that you've identified the imbalanced covariates using the 
t-test command.  

For each of the three imbalanced p-values, generate a dummy variable for observations with above the median 
value of that variable.  So, for example, if `x1` were imbalanced, you could generate a variable equal 
to one for observations with above-median values of `x1` using the following commands:

```
sum x1, detail
gen highx1 = (x1>=r(p50))
```

Now, modify your code so that you stratify your randomization by your three `highx*` variables.  What 
two lines of code would you use to sort the data and assign treatments?

###### Question 4

How many covariates are imbalanced now, after stratifying on the three that were initially imbalanced?


