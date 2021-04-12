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
create treatment and comparison groups that are similar in terms of there 
