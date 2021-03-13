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

The data set contains the the variables `gross_enrollment` and `net_enrollment` which 
provide two closely related measures of school participation.  The **gross primary enrollment ratio** 
is 100 times the number of students enrolled in primary school divided by the number of primary-school aged 
children.  This number can be greater than 100 when over-age children are enrolled in primary school - which 
often happens when school fees are eliminated.  The **net primary enrollment ratio** is 100 times 
the number of _primary-school aged_ children enrolled in primary school divided (again) by the total number of 
primary-school aged children.  The net primary enrollment ratio should not be greater than 100.


