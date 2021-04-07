## Empirical Exercise 9  

In this exercise, we'll be using data from the paper [Islamic Rule and the Empowerment of the Poor and Pious](https://www.jstor.org/stable/24029175?seq=1) by 
Dr. Erik Meyersson.  The paper uses a **regression discontnuity** design to estimate the impact of Islamic political parties on women's equality, comparing municipalities where the Islamic party just won the mayorial election in 1994 to those where the Islamic party just lost.  We'll be replicating Dr. Meyersson's key results using [a replication data set](https://github.com/rdpackages-replication/CIT_2019_CUP) produced by [Professor Matias Cattaneo](https://cattaneo.princeton.edu/home) (who uses this paper as an example in one of his [books on RD designs](https://cattaneo.princeton.edu/books/Cattaneo-Idrobo-Titiunik_2018_CUP-Vol2.pdf)).  

<br>

#### Getting Started

Before you get started, you need to open Stata and install the commands `rd` and `rdrobust`.  To find `rdcv`, 
type `findit rdcv`.  The pop-up window will only contain one link to a package.  Click it.  Then click 
the blue `click here to install` link.  Then, close the window.  To find the `rd` command, 
type `findit Austin Nichols` in Stata.  When the pup-up window opens, scroll throught the commands (which are listed 
alphabetically) until you get to the command `rd.`  Click the link to `rd from http://fmwww.bc.edu/RePEc/bocode/r`, and 
then click the blue `click here to install` link.

Now open this [do file](https://pjakiela.github.io/ECON379/exercises/E8-TOT/E8-in-class.do) in your do file editor.  The do file 
opens a data set containing information on 6,863 households in treatment and control neighborhoods in Hyderabad; these households 
were randomly sampled form the local population, so not all of them will have chosen to take out loans from an MFI.  

The do file 
starts with Banerjee et al's replication code to recreate Table 2.  After you run this code, you will have a file called 
`Table2.txt` saved in your local folder.  `Table2.txt` will contain the same results reported in Panel A of the paper.  We're 
going to focus on the first column, which reports the estimated impact of treatment (having a Spandana branch open in your 
neighborhood) on the likelihood of taking out a Spandana micrloan:

![PanelATable2](https://pjakiela.github.io/ECON379/exercises/E8-TOT/MOM-Tab2-color.png)
