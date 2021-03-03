# Empirical Exercise 4  

This is the empirical exercise associated with our [first module on difference-in-differences estimation](https://pjakiela.github.io/ECON379/M4-DD1.html). 
In this exercise, we're going to analyze data from Ignaz Semmelweis' handwashing 
intervention in the maternity hospital in Vienna.  The data come from 
Semmelweis' (1861) book, and some helpful person put them on Wikipedia.  

To get started, create a directory for this exercise, and then save 
[Semmelweis data](https://pjakiela.github.io/ECON379/exercises/E4-DD1/E4-Semmelweis1861-data.xlsx) to your directory. 
The data set is in excel, so we'll be using Stata's `import excel` command to read them into Stata. 
To make sure that you have downloaded the data correctly, open Stata, change the directory to the 
new folder you created for this excercise (using the `cd` command), and then use the `ls` command to 
list the contents of the directory.  You should see the excel file containing Semmelweis' data on maternal mortality 
listed in your directory.  

We'll be making graphs in this exercise.  Before doing this, you should install Stata's `blindschemes` 
package if you have not already.  Type the command `findit blindschemes` to look for the package on the web. 
You should see a window that looks like this: 
![stata-blindschemes](https://pjakiela.github.io/ECON379/exercises/E4-DD1/blindschemes.png). 
Click the first link (where the error is pointing) and follow the instructions to install the 
`blindschemes` package. This will allow you to access the colors of the 
[Okabe-Ito colorblind-friendly palette](https://jfly.uni-koeln.de/color/) to make 
elegant data visualizations.  
