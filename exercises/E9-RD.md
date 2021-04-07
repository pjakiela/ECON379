## Empirical Exercise 9  

In this exercise, we'll be using data from the paper [The Miracle of Microfinance?  Evidence from a Randomized Evaluation](https://www.jstor.org/stable/43189512?seq=1) by 
Abhijit Banerjee, Esther Duflo, Rachel Glennerster, and Cynthia Kinnan.  The paper reports the results of one of the first randomized evaluations of a microcredit intervention.  The authors worked with an Indian MFI (microfinance institution) called Spandana that was expanding into the city of Hyderabad.  Spandana identified 104 neighborhoods where it would be willing to open branches.  They couldn't open branches in all the neighborhoods simultaneously, so they worked with the researchers to assign half of them to a treatment group where branches would be opened immediately.  Spandana held off on opening branches in the control neighborhoods until after the study.  

Before getting started, take a look at this [J-PAL policy brief on the impacts of microfinance](https://www.povertyactionlab.org/policy-insight/microcredit-impacts-and-limitations).  We'll be using a small slice of the data from the paper by Banerjee, Duflo, Glennerster, and Kinnan to explore the use of **instrumental variables** techniques to estimate impacts of **treatment on the treated** - and to think about when such methods are appropriate.

<br>

#### Getting Started

Before you get started, you need to open Stata and install the commands `estout` and `eret2`.  Use the `findit` command in Stata to 
locate the links to install these user-written programs.

Now open this [do file](https://pjakiela.github.io/ECON379/exercises/E8-TOT/E8-in-class.do) in your do file editor.  The do file 
opens a data set containing information on 6,863 households in treatment and control neighborhoods in Hyderabad; these households 
were randomly sampled form the local population, so not all of them will have chosen to take out loans from an MFI.  

The do file 
starts with Banerjee et al's replication code to recreate Table 2.  After you run this code, you will have a file called 
`Table2.txt` saved in your local folder.  `Table2.txt` will contain the same results reported in Panel A of the paper.  We're 
going to focus on the first column, which reports the estimated impact of treatment (having a Spandana branch open in your 
neighborhood) on the likelihood of taking out a Spandana micrloan:

![PanelATable2](https://pjakiela.github.io/ECON379/exercises/E8-TOT/MOM-Tab2-color.png)
