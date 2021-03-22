## Empirical Exercise 8  

In this exercise, we'll be using data from the paper [The Miracle of Microfinance?  Evidence from a Randomized Evaluation](https://www.jstor.org/stable/43189512?seq=1) by 
Abhijit Banerjee, Esther Duflo, Rachel Glennerster, and Cynthia Kinnan.  The paper reports the results of one of the first randomized evaluations of a microcredit intervention.  Before getting started, take a look at this [J-PAL policy brief on microfinance](https://www.povertyactionlab.org/policy-insight/microcredit-impacts-and-limitations).  

We'll be using a small slice of the data from the paper by Banerjee, Duflo, Glennerster, and Kinnan to explore the use of instrumental variables techniques to estimated impacts of treatment on the treated - and to think about when such methods are appropriate.

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
