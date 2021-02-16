## Selection Bias and the Experimental Ideal

<br>

### Overview  
This module introduces the **potential outcomes** framework that we'll use throughout the course as well as the concept of **selection bias** before explaining how average treatment effects can be estimated when treatment status is randomly assigned.  

_This module includes one reading, XX video lectures, and an empirical exercise._

<br>

### Readings
[_Mastering Metrics_: Chapter 1](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjE2pfw-JjuAhUBZc0KHQo1DnoQFjAAegQIBhAC&url=http%3A%2F%2Fassets.press.princeton.edu%2Fchapters%2Fs10363.pdf&usg=AOvVaw3IGywrUpw1_F9e5npteATA)

<details><summary>Review Questions</summary>
  <br>
  <ol>
  <li>How do Americans with health insurance differ from those without health insurance?  Are those differences likely to represent the causal effects of having health insurance?  Why or why not? </li>
  <li>What are potential outcomes?  How do potential outcomes lead to a missing data problem in causal inference?  </li>
  <li>What is selection bias, and what implications does it have for program evaluation?  </li>
  <li>What is the Law of Large Numbers, and why is it important in randomized experiments?  </li>
  <li>Based on the evidence presented in the reading, what are the impacts of access to health insurance (in the United States)?  </li>
  </ol>
</details>

<br>

### Video Lectures  

[Lecture 2.1 The Potential Outcomes Framework](https://vimeo.com/512774637)

<details><summary>Review Questions</summary>
  <br>
  <ol>
  <li>What is the fundamental problem of causal inference?</li>
  </ol>
</details>
  
<br>

Lecture 2.2  

<br>

Lecture 2.3  

<br>

#### Referenced in the Lectures

[_The Design of Experiments_, Chapter 2](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjzkKfKr-7uAhWkB50JHTs7BfoQFjADegQIAhAC&url=https%3A%2F%2Fmimno.infosci.cornell.edu%2Finfo3350%2Freadings%2Ffisher.pdf&usg=AOvVaw3PD-Tt-WKw8_2oE_GqJOZl)  

[The Entry of Randomized Assignment into the Social Sciences](https://www.degruyter.com/document/doi/10.1515/jci-2017-0025/html) by Julian Jamison  

<br>

### Empirical Exercise

In this exercise, we'll use Stata's `rnormal()` command to generate draws from a normally-distributed random variable.  This approach - simulating data 
according to a known data-generating process - is an incredibly useful tool in empirical microeconomics (both for checking your econometric intuitions and 
your anlayis code).    

We'll use "locals" (also know as "local macros") to easily change the number of observations and other parameters of our data set.  This will allow us to 
explore the way the properties of randomly-assigned treatment groups in larger and smaller samples.  

This exercise introduces a range of practical coding tools:  `rnormal()`, locals, and the `return list` and `display` commands.  By varying the sample size, we'll build a better understanding of the role that the Law of large Numbers plays in randomized evaluations.  

You can download the activity as a [do](https://pjakiela.github.io/ECON379/exercises/E2-selection-bias/E2-questions.do) file or a [pdf](https://pjakiela.github.io/ECON379/exercises/E2-selection-bias/E2-questions.pdf).

<br>

### Further Reading

#### More Recent Evidence on Health Insurance
[Health Insurance and Mortality: Experimental Evidence from Taxpayer Outreach](https://academic.oup.com/qje/article/136/1/1/5911132?login=true)  
