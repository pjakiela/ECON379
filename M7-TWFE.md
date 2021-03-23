## Two-Way Fixed Effects

<br>

### Overview  
In this module, we look at the use of two-way fixed effects to estimate generalized difference-in-differences models when treatment timing varies across treated units.  We'll see 
that the mis-specification issues we discussed in the context of continuous variation in treatment are also relevant here, and that two-way fixed effects estimates can be 
severely biased when treatment is staggered and treatment effects on individual units are not constant over time. 

_This module contains 34 minutes of video lecture, one short reading, and two empirical exercises._

<br>

### Readings

[What Are We Estimating When We Estimate Difference-in-Differences?](https://blogs.worldbank.org/impactevaluations/what-are-we-estimating-when-we-estimate-difference-differences)

<details><summary>Review Questions</summary>
  <br>
  <ol>
    <li>What is "staggered treatment timing" in the context of difference-in-differences estimation?  When might one try to estimate treatment 
      effects in a context where treatment timing is staggered?</li>
    <li>What is the two-way fixed effects estimator of the treatment effect?</li>
    <li>Dr. Andrew Goodman-Bacon shows that the two-way fixed effects estimator can be decomposed into a weighted average... of what?</li>
    <li>When we estimate a treatment effect via two-way fixed effects and treatment timing is staggered, which units are used a treatment and which are used as control?</li>
    <li>When is the two-way fixed effects estimator likely to provide a biased estimate of the treatment effect of a program?</li>
  </ol>
</details>

<br>

### Video Lectures  
[Lecture 7.1:  Two-Way Fixed Effects](https://vimeo.com/520567600) (34:30)  

<details><summary>Review Questions</summary>
  <br>
  <ol>
    <li>What is the two-way fixed effects estimator of the treatment effect?  What regression would you run to arrive at this estimator?  How must your data be structured?</li>
    <li>Describe how you could translate a two-way fixed effects regression into a univariate regression (of an outcome on a single independent variable).</li>
    <li>In two-way fixed effects regression, which units are implicitly included in the treatment group and which units are implicitly treated as controls?</li>
    <li>When can we be confident that two-way fixed effects provides an unbiased estimate of the average treatment effect of a program?</li>
    <li>When should we worry that two-way fixed effects will yield a biased estimate of the treatment effect of a program?</li>
  </ol>
</details>

<br>

### Empirical Exercise

[Empirical Exercise 7A](https://pjakiela.github.io/ECON379/exercises/E7A-TWFE.html)  

In this exercise, we’ll deepen our understanding of the mechanics of TWFE through a simple simulation. We’ll create a small data set containing two units that are observed over four periods, and we’ll calculate the TWFE estimator of a treatment effect of interest using both Excel and Stata.  

[Empirical Exercise 7B](https://pjakiela.github.io/ECON379/exercises/E7B-TWFE.html) 

In this exercise, we’ll be using a data set on school enrollment in 15 African countries that eliminated primary school fees between 1990 and 2015. Data on enrollment comes from the World Bank’s World Development Indicators Database. We’ll be using these data to estimate the two-way fixed effects estimator of the impact of eliminating school fees on enrollment. Since this policy was phased in by different countries at different time, it is a useful setting for exploring the potential pitfalls of two-way fixed effects.

<br>
