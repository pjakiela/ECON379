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

### Additional Resources
