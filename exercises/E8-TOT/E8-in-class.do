
// PRELIMINARIES

clear all
set more off
set scheme s1mono
set seed 314159

cd "C:\Users\pj\Dropbox\econ379-2021\exercises\E8-TOT"

webuse set https://pjakiela.github.io/ECON379/exercises/E8-TOT/
webuse E8-BanerjeeEtAl-data.dta


// REPLICATE TABLE 2

global area_controls "area_pop_base area_debt_total_base area_business_total_base area_exp_pc_mean_base area_literate_head_base area_literate_base"

est clear
foreach var in spandana_1 othermfi_1 anymfi_1 anybank_1	anyinformal_1 ///
			anyloan_1 everlate_1 mfi_loan_cycles_1 credit_index_1 {
	reg `var' treatment $area_controls [pweight=w1], cluster(areaid)
	eret2 scalar pval=2*ttail(e(df_r),abs(_b[treatment]/_se[treatment]))
	sum `var' if treatment==0 & e(sample)
	eret2 scalar mn1=r(mean)
	est store `var'
}

estout * using "Table2.txt", drop($area_controls _cons) title("Table 2: Credit") ///
	prehead("" @title) cells(b(fmt(a3) s) se(fmt(a3) par)) replace s(mn1 N) ///
	starlevels(* .1 ** .05 *** .01) legend ///
	postfoot("Robust standard errors, clustered at the area level, in parentheses.")
	

	
// EXPLORE TREATMENT ON THE TREATED

** drop observations missing key variables (so sample doesn't change across specifications)
drop if spandana_1==. | anymfi_1==. | bizprofit_1==. | any_old_biz==.

reg spandana_1 treatment, cluster(areaid) // first-stage regression



