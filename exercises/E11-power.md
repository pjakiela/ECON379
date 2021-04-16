## Empirical Exercie 11

This is the first of two exercises on power calculations.  In this exercise, we'll review the concepts 
of **size** and **power** in hypothesis testing, and learn how to calculate the **minimum detectable effect** 
as a function of sample size (or the required sample size as a function of the minimum detectable effect).  

<br>

#### What Is a Research Design?  

Every research design involves:  

1. A null hypothesis and either one or several alternative hypotheses
2. A statistic related to our hypotheses that we can calculate from observations of an outcome variable 
3. A rule that maps possible values of the statistic into decisions about whether to reject the null hypothesis

**Example 1.**  We want to test the null hypothesis that a coin is "fair" (equally likely to land on heads or tails).  Our 
statistic is the percentage of the time the coin lands on heads in 2 tosses.  What are some possible rules we 
might use to tell us when to reject the null hypothesis?  

**Example 2.**  We want to test the hypothesis that economics majors know more about Stata than English majors.  We have data 
measuring performance on a Stata proficiency test for four students:  two English majors and two econ majors.  How 
can we use the data to decide whether to reject the null hypothesis that econ majors and English majors 
are equally proficienct with Stata.  

Whenever we specify a rule about when to reject the null hypothesis, we have to worry about the possibility of getting 
it wrong.  One possibility is that the null hypothesis is correct, but (based on our rule) we reject it.  This is 
called a **Type I error** or a **false positive**.  We also have to worry about the possibility that the null 
hypothesis is wrong, but (based on our rule) we fail to reject it.  This is called a **Type II error** or, less 
commonly, a **false zero**.  It is not usually possible to reduce the probabilities of both Type I and Type II errors 
to zero; on the contrary, reducing the probability of a Type I error usually involves increasing the probability of 
a Type II error.  

We refer to the probability of a Type I error as the **size** of a test.  The convention (dating back 
to Ronald Fisher) is to use a test of size 0.05.  This means that we reject the null hypothesis 
whenever our statistic has a p-value of 0.05 or less (meaning that a statistic at least that large would occur less 
that five percent of the time under the null).  
