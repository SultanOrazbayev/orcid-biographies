use "orciddata/data-v1.0.dta", clear
		
egen idpair = group(origin destination)
xtset idpair year
		
tsfill, full
		
foreach k in origin destination{
	bysort idpair : egen temp=max(`k')
	replace `k'=temp if `k'==.
	drop temp
}

* missings are replaced with zeros since no individuals are observed in those countries
foreach k of varlist flow_* stock_*{
	replace `k'= 0 if `k'==.
}

xtset
drop idpair
