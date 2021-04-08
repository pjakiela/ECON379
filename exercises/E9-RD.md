## Empirical Exercise 9  

In this exercise, we'll be using data from the paper [Islamic Rule and the Empowerment of the Poor and Pious](https://www.jstor.org/stable/24029175?seq=1) by 
Dr. Erik Meyersson.  The paper uses a **regression discontnuity** design to estimate the impact of Islamic political parties on women's equality, comparing municipalities where the Islamic party just won the mayorial election in 1994 to those where the Islamic party just lost.  We'll be replicating Dr. Meyersson's key results using [a replication data set](https://github.com/rdpackages-replication/CIT_2019_CUP) produced by [Professor Matias Cattaneo](https://cattaneo.princeton.edu/home) (who uses this paper as an example in one of his [books on RD designs](https://cattaneo.princeton.edu/books/Cattaneo-Idrobo-Titiunik_2018_CUP-Vol2.pdf)).  

<br>

#### Getting Started

Before you get started, you need to open Stata and install the commands `rd` and `rdrobust`.  To find `rdcv`, 
type `findit rdcv`.  The pop-up window will only contain one link to a package.  Click it.  Then click 
the blue `click here to install` link.  Then, close the window.  To find the `rd` command, 
type `findit Austin Nichols` in Stata.  When the pup-up window opens, scroll throught the commands (which are listed 
alphabetically) until you get to the command `rd.`  Click the link to `rd from http://fmwww.bc.edu/RePEc/bocode/r`, and 
then click the blue `click here to install` link.  Finally, make sure that you have Dr. Meyersson's article handy, 
as you will want to look at the tables and figures as you work through this exercise.  

Now create a do file.  After the usual preliminaries, include the following code to download the replication data 
for Dr. Meyersson's paper:

```
webuse set https://pjakiela.github.io/ECON379/exercises/E9-RD/
webuse E9-Meyersson-data
```

The data set contains data on 2,629 Turkish municipalities.  Use the `summarize` and `describe` commands to familiarize 
yourself with the data set.  

The running variable is `margin1994`, the Islamic party's win margin in the 1994 elections (which is negative when the 
Islamic party didn't win).  What is the mean of this variable?  Generate a new variable `mayor1994` that is a dummy 
equal to one in municipalities where the Islamic party won the municipal election in 1994.  This is the treatment 
variable.  What is the mean of `mayor1994`.  How many of the 2,629 elections did the Islamic party win?  

<br> 

#### Empirical Exercise

##### Question 1

The loop below generates part of Table I:  

```
foreach var of varlist hs_women hs_men mayor1994 {
	    ttest `var', by(mayor)
	}

```

The `foreach var of varlist` command tells Stata that you want it to execute the command 
(or series of commands) in curly braces for each of the listed values of `var`.  

Extend the code so that Stata loops through all of the variables summarized 
in Table I.  What is the t-statistic from the test of the hypothesis 
that municipalities where the Islamic party won the election in 1994 
had the same average household size as municipalities where the 
Islamic party did not win the 1994 election?  

##### Question 2

Use the histogram command to replicate Figure 2a, the histogram of the 
Islamic win margin in 1994.  You will want to play around with the
the options, particularly the bin width, to get as close as possible 
to what is shown in Figure 2a.  

##### Question 3

What bandwidth does the author use in his RD estimation of the impact of 
Islamic mayors on women's educational attainment? (You can find this information in the text of the paper.)  

##### Question 4

The code below replicates the regression results presented in Column 1 of 
Panel A of Table II (confirm that this is the case):  

```
reg hs_women mayor, cluster(province)
```

Now add the controls described in the text to get as close as possible to the regression results presented in Column 2 of Panel A of 
Table II.  What is the t-statistic on the `mayor1994` variable in your expanded regression?  

##### Question 5

Now implement the RD specification from Column 3 (of Panel A of Table II).  Remember that this should include separate linear terms for the running variable 
above and below the discontinuity.  Do you get **exactly** the same coefficient and standard error as Dr. Meyersson?  When you set the 
`bandwidth = 0.24`, how many observations are included in the RD estimation?  

##### Question 6

Now implement the RD estimation including controls, as Dr. Meyersson does in Column 4 of Table II.  What is the estimated coefficient on the 
the `mayor1994` (ie treatment) variable?  It may not be exactly the same as the coefficient reported in the table, but it should be close.  

##### Question 7

In Columns 5 and 6, Dr. Meyersson presents RD estimation using two different alternative bandwidths.  Replicate your RD analysis with controls 
using a very narrow bandwidth:  one quarter of the optimal bandwidth used in Columns 3 and 4.  Do the results change?  What is the estimated impact 
of having a mayor from the Islamic Party?  

##### Question 8  

In Column 7, Dr. Meyersson uses a quadratic function of the running variable 
in addition to the linear function.  In other words, he generates a term 
that is equal to the Islamic win margin squared for municipalities where 
the Islamic party won the 1994 election (and equal to zero otherwise), and 
he generates another term that is equal to the Islamic win 
margin squared for municipalities where the Islamic party lost the 
election (and zero otherwise).  Generate these terms, and estimate 
an RD specification that includes them as well as the linear terms, but 
no controls (so, your specification is different than that reported in 
Column 7 of Table II).  Use the same optimal bandwidth that Dr. Meyersson 
uses in Columns 3 and 4.  What is the estimated impact of having an 
Islamic party mayor on female educational attainment?  

##### Question 9

To demonstrate the validity of an RD design, we want to show that covariates do not "jump" at the discontinuity.  Do this by replicating the simple 
specification from Question 5, but using the outcome variable `voteshare1994` (the Islamic vote share in 1994).  If having an Islamic 
party win the election predicts a covariate, it tells us that there is something wrong with ur RD design.  What is the p-value associated 
with this hypothesis test?

##### Question 10

Now implement the RD using the `rd` command, as described in lecture.  The outcome variable is (once again) `hs_women`.  Do not include any controls.  The RD 
command reports results for three bandwidths:  the Imbens-Kalyanaraman optimal bandwidth (`lwald` in the Stata output), half of that (`lwald50`), 
and two times the optimal bandwidth (`lwald200`).  What is the optimal bandwidth (the first one reported), according to the `rd` command?  How does it compare to 
the one used by Dr. Meyersson?  

##### Question 11  

When you use the `rd` command, what is the estimated treatment effect of having a mayor from the Islamic party on women's education (using the optimal bandwidth)?

##### Question 12  

Now use the `rdcv` command (as described in the lecture notes).  What is the `rdcv` command's estimate of the optimal bandwidth?


