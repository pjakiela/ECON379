## Selection Bias and the Experimental Ideal

### Overview  
Potential outcomes, selection bias, the experimental ideal. 

### Readings
[_Mastering Metrics_: Chapter 1](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjE2pfw-JjuAhUBZc0KHQo1DnoQFjAAegQIBhAC&url=http%3A%2F%2Fassets.press.princeton.edu%2Fchapters%2Fs10363.pdf&usg=AOvVaw3IGywrUpw1_F9e5npteATA)

<details><summary>Review Questions</summary>
  <br>
  <ol>
  <li>How do Americans with health insurance differ from those without health insurance?  Are those differences likely to result from having health insurance?  Why o why not? </li>
  <li>What are potential outcomes?  How do potential outcomes lead to a missing data problem?  </li>
  <li>What is selection bias, and what implications does it have for program evaluation?  </li>
  <li>What is the Law of Large Numbers, and why is it important in randomized experiments?  </li>
  <li>Based on the evidence presented in the reading, what are the impacts of health insurance?  </li>
  </ol>
</details>

### Video Lectures  
  

### Stata Exercise

The Stata do file `S2.do` uses Stata's `rnormal()` command to generate draws from a normally-distributed random variable using the following code:

```
clear
set seed 1234
local myobs = 10
set obs `myobs'
gen y = rnormal()
```

In the third line, we define a local, `myobs`, and in the next line, we use that local to set the number of observations in the data set.  Since we are starting with an empty data set, these observations are blank - we haven't defined any variables yet.  

In the last line, we use `rnormal()` to create a variable that is normally distributed (with mean 0 and SD 1).  Each of the ten observations has a different value of `y`, but if you plot these values, you will see that they represent draws from a standard normal.

### Additional Resources
