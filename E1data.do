
/***************************************************************************
The dataset is a subset of the data used in the paper "Price Subsidies, 
Diagnostic Tests, and Targeting of Malaria Treatment: Evidence from a 
Randomized Controlled Trialby Jessica Cohen, Pascaline Dupas, and Simone 
Schaner, published in the American Economic Review.  

It examines behavior in response to various discounts (“subsidies”) – or 
no discount – for malaria treatment, called “artemisinin combination therapy,” 
or “ACT.”
******************************************************************************/

// LOAD DATA

clear all 
set scheme s1mono 
set more off
set seed 12345
version 14.2

** change working directory as appropriate
cd "E:\Dropbox\BGSE\2019\1. Experimental Ideal\stata"
use MalariaDataAdapted.dta


// 1. ONE TREATMENT DUMMY

** The variable act_any is a dummy for assignment to any treatment (positive subsidy)
** The variablle c_act is a dummy for using ACT treatment during a malaria episode

** Calculate the mean of c_act in the treatment and comparison groups
**** control group mean:
**** treatment group mean:

** Regress c_act on act_any - how do the coefficients relate to the means above?

** Now includ strata dummies by including i.stratum - how do the results change?


// 2. MULTIPLE TREATMENTS

** The variable coartemprice indicates the randomly-assigned subsidy level
** The variables act40, act60, act100, and act500 are dummies for individual treatments

** Regress c_act on the dummies for the three subsidy levels (act40, act60, act100)
** Omit the stratum dummies for the time being - how do the results compare to those above?

** Tabulate the different treatments, then convince yourself that the OLS coefficient 
** 		from [1] is the weighted average of the coefficients you just estimated.  


// 3. TREATMENT AS A CONTINUOUS VARIABLE 

** Create a dummy equal to the level of the subsidy (between 0 and 1).  
** What values does this variable take?

** Regress c_act on this continuous treatment variable.  How do the results 
**		compare to those reported in [1] and [2]?  


// 4. INCLUDING CONTROLS

** Variables measured at baseline are prefixed with b_*
** Which baseline covariates predict c_act in the control group?  

** Replicate specifications [1], [2], and [3] including stratum dummies 
** 		and using robust standard errors.  Compare results without additional 
**		controls to those obtained when (b) all controls are included and 
**		(c) only controls that predict the outcome are included.


 


