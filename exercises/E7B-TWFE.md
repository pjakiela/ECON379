## Empirical Exercise 7, Part 2  

In this exercise, we'll be using a data set on school enrollment in 15 African countries that eliminated primary 
school fees between 1990 and 2015.  Data on enrollment comes from the World Bank's 
[World Development Indicators Database](https://databank.worldbank.org/source/world-development-indicators). We'll be using 
these data to estimate the two-way fixed effects estimator of the impact of eliminating school fees on enrollment.  Since 
this policy was phased in by different countries at different time, it is a useful setting for exploring the potential pitfalls 
of two-way fixed effects.

<br>

#### Getting Started

Start by creating a do file that downloads the data from the course website.  Your 
code will look something like this:

```
clear all 
set scheme s1mono 
set more off
set seed 12345
webuse set https://pjakiela.github.io/ECON379/exercises/E7-TWFE/
webuse E7-TWFE-data.dta
```

The data set only contains six variables:  `country`, `year`, `id`, `gross_enrollment`, `net_enrollment`, 
and `fpe_year`.  The variables `country` and `year` are self-explanatory.  `id` is a unique 
numeric identifier for each of the 15 individual countries in the data set.  The variable `fpe_year` 
indicates the year in which a given country made primary schooling free to all eligible children.  Malawi 
was the first country in the data set that eliminated primary school fees (in 1994), while Namibia was the 
last (in 2013).  The countries in the data set and the timing of school fee elination is summarized in the table below.

ID|Country|Implementation of Free Primary Education
--|-------|----------------------------------------
27|Malawi|1994
17|Ethiopia|1995
20|Ghana|1996
46|Uganda|1997
7|Cameroon|2000
44|Tanzania|2001
47|Zambia|2002
35|Rwanda|2003
23|Kenya|2003
5|Burundi|2005
31|Mozambique|2005
24|Lesotho|2006
2|Benin|2006
4|Burkina Faso|2007
32|Namibia|2013

The data set contains 15 countries, but only 13 distinct "timing groups" - since Kenya and Rwanda both 
eliminated primary school fees in 2003, while Benin and Lesotho both eliminated fees in 2006.  

The data set also contains the the variables `gross_enrollment` and `net_enrollment` which 
provide two closely related measures of school participation.  The **gross primary enrollment ratio** 
is 100 times the number of students enrolled in primary school divided by the number of primary-school aged 
children.  This number can be greater than 100 when over-age children are enrolled in primary school - which 
often happens when school fees are eliminated.  The **net primary enrollment ratio** is 100 times 
the number of _primary-school aged_ children enrolled in primary school divided (again) by the total number of 
primary-school aged children.  The net primary enrollment ratio should not be greater than 100.

Start by familiarizing yourself with the data set.  What are the first and last years included in the sample?  Which 
countries eliminated school fees in the 1990s?  How many countries eliminated primary school fees after 2010?

<br>

#### The Mechanics of Two-Way Fixed Effects

Now we are ready to estimate the impact of eliminating primary school fees on enrollment using two-way 
fixed effects.  We want to implement the regression equation:

![twfe-eq](https://pjakiela.github.io/ECON379/exercises/E7-TWFE/DD-equation.png)

where Y<sub>it</sub> is the outcome variable of interest and _D<sub>it</sub>_ is...
