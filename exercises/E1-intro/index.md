## Empirical Exercise 1

This exercise makes use of the data set [E1-CohenEtAl-data.dta](https://pjakiela.github.io/ECON379/exercises/E1-intro/E1-CohenEtAl-data.dta), a subset of the data used in the paper [Price Subsidies, Diagnostic Tests, and Targeting of Malaria Treatment: Evidence from a Randomized Controlled Trial](https://www.aeaweb.org/articles?id=10.1257/aer.20130267) by Jessica Cohen, Pascaline Dupas, and Simone Schaner, published in the _American Economic Review_ in 2015.  The authors examine behavioral responses to various discounts ("subsidies") for malaria treatment, called "artemisinin combination therapy" or "ACT."

The aim of this exercise is to review key Stata commands.  You can download the activity as a do file or a pdf.

```
clear all 
set scheme s1mono 
set more off
set seed 12345
version 16.1

** load the data from the course website
webuse set https://pjakiela.github.io/ECON379/exercises/E1-intro/
webuse E1-CohenEtAl-data.dta
```

This exercise is part of [Module 1:  Why Evaluate?](https://pjakiela.github.io/ECON379/M1-why-evaluate.html).
