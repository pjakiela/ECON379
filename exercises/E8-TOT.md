## Empirical Exercise 8  

In this exercise, we'll be using data from the paper [The Miracle of Microfinance?  Evidence from a Randomized Evaluation](https://www.jstor.org/stable/43189512?seq=1) by 
Abhijit Banerjee, Esther Duflo, Rachel Glennerster, and Cynthia Kinnan.  The paper reports the results of one of the first randomized evaluations of a microcredit intervention.  The authors worked with an Indian MFI (microfinance institution) called Spandana that was expanding into the city of Hyderabad.  Spandana identified 104 neighborhoods where it would be willing to open branches.  They couldn't open branches in all the neighborhoods simultaneously, so they worked with the researchers to assign half of them to a treatment group where branches would be opened immediately.  Spandana held off on opening branches in the control neighborhoods until after the study.  

Before getting started, take a look at this [J-PAL policy brief on the impacts of microfinance](https://www.povertyactionlab.org/policy-insight/microcredit-impacts-and-limitations).  We'll be using a small slice of the data from the paper by Banerjee, Duflo, Glennerster, and Kinnan to explore the use of **instrumental variables** techniques to estimate impacts of **treatment on the treated** - and to think about when such methods are appropriate.

<br>

#### Getting Started

Before you get started, you need to open Stata and install the commands `estout` and `eret2`.  Use the `findit` command in Stata to 
locate the links to install these user-written programs.

Now open this [do file](https://pjakiela.github.io/ECON379/exercises/E8-TOT/E8-in-class.do) in your do file editor.  The do file 
opens a data set containing information on 6,863 households in treatment and control neighborhoods in Hyderabad; these households 
were randomly sampled form the local population, so not all of them will have chosen to take out loans from an MFI.  

The do file 
starts with Banerjee et al's replication code to recreate Table 2.  After you run this code, you will have a file called 
`Table2.txt` saved in your local folder.  `Table2.txt` will contain the same results reported in Panel A of the paper (you may 
need to open it in a new window if you actually want to read it):

![PanelATable2](https://pjakiela.github.io/ECON379/exercises/E8-TOT/MOM-Tab2-color.png)

The replication code shows you some of the many tricks economists use when writing do files:  storing a set of controls 
as a local or global macro that is included in each specification, writing a `foreach` loop to run the same regression for a number of 
different outcome variables, using regression weights, and saving the regression results in a text file using the `estout` command.  You don't need 
to understand every line, but these techniques will help you write clearer do files faster.  

We're going to focus on a simpler specification in this exercise.  The last line of the do file runs the regression 
```
reg spandana_1 treatment, cluster(areaid)
```

Your results should be fairly close to Column 1 of Table 2, but not identical 
(because we're not including controls, or reweighting observations).  The results indicate that assignment to treatment 
leads to a statistically significant increase in the likelihood of taking out a microloan from Spandana.  How large is this estimated 
treatment effect?  What does this coefficient tell us about take-up of the intervention in this evaluation?

Now, run a new regression to estimate the impacts of treatment (access to a Spandana branch in your neighborhood) on the 
`bizprofit_1` variable, which reports a household's total profits from their small businesses (which we often refer to 
as microenterprises - because they are typically very small).  What is the estimated 
treatment effect on microenterprise profits?  Is the estimated treatment effect statstically significant?  What are the upper and lower 
bounds on the 95 percent confidence interval?

Now, suppose you thought that the impacts of treatment (Spandana branches) on microenterprise profits could only be the result of 
borrowing from Spandana.  How would you use the two coefficients that you just estimated to calculate the estimated impact of 
treatment on the treated?  What is the estimated TOT effect?

Now calculate the estimated TOT effect using instrumental variables:

```
ivregress 2sls bizprofit_1 (spandana_1 = treatment), ///
  cluster(areaid) 
```

Did you get the coefficient that you expected?  
