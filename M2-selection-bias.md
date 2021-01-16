## Selection Bias and the Experimental Ideal

### Overview  
Potential outcomes, selection bias, the experimental ideal. 

### Readings
[_Mastering Metrics_: Chapter 1](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjE2pfw-JjuAhUBZc0KHQo1DnoQFjAAegQIBhAC&url=http%3A%2F%2Fassets.press.princeton.edu%2Fchapters%2Fs10363.pdf&usg=AOvVaw3IGywrUpw1_F9e5npteATA)

### Video Lectures  
  

### Stata Exercise

The Stata do file `S2.do` uses Stata's `rnormal()` command to generate draws from a normally-distributed random variable using the following code:

```
local myobs = 10
set obs `myobs'
gen y = rnormal()
```

In the first line, we define a local, `myobs`, and in the next line, we use that local to set the number of observations in the data set.  Since we are starting with an empty data set, these observations are blank - there are no variables yet.  

In the third line, we use `rnormal()` to create a variable that is normally distributed (with mean 0 and SD 1).  Each of the ten observations has a different value of `y`, but if you plot these values, you will see that they represent draws from a standard normal.

### Additional Resources
