local runall 1
*local rowlimit rowrange(1:1000)

* include path names
include "/Volumes/work/projects/ORCIDnew/scripts/localpaths-stata.txt"

* copy the files into the data folder
shell cp "`pathscripts'/sci-data/supp-fix-orcids.do" "`pathdataproc'/supp-fix-orcids.do"
shell cp "`pathscripts'/sci-data/supp-standardise.do" "`pathdataproc'/supp-standardise.do" 
shell cp "`pathdatamanual'/countrycodes-orcid.dta" "`pathdataproc'/countrycodes-orcid.dta"

cd "`pathdataproc'"

* start a log for review
log using orciddata/log-orciddo.smcl, replace

* define sample period
	local yearmin 1990
	local yearmax 2015

* import the data
	import delimited using orciddata/orcid-raw.csv, clear encoding("UTF-8") `rowlimit'
	rename v1 orcid_string
	rename v2 yearstart
		label variable yearstart "Year of starting the position"
	rename v3 yearend
		label variable yearend "Year of ending the position"
	rename v4 occupationtype
	rename v5 position
		* the position string is trimmed and truncated to the first 100 characters conserve space
		replace position = ustrtrim(usubstr(ustrtrim(position),1,100))
	format position %10s
	rename v6 country

* clean up by trimming and converting all to lowercase
	foreach v of varlist position occupationtype country{
		replace `v' = ustrlower(ustrtrim(`v'))
	}
	
* fix orcids (spam/test accounts/etc)
	gen orcid = 1
	include supp-fix-orcids.do
	drop if orcid==.
	drop orcid

* convert the countries and encode (mainly to conserve space)
	rename country countryiso2_string
	merge n:1 countryiso2_string using countrycodes-orcid.dta , keepusing(country*code) keep(1 2 3) gen(mcountry)
		drop if mcountry!=3
	drop countryiso2_string mcountry countrycode
	
	
* there are a few observations with missing info on occupation type
	* based on their values seems more of employment type than education
	replace occupationtype = "employment" if occupationtype==""

* encode to conserve space
	encode occupationtype, gen(otype)
		label variable otype "Occupation type"
	drop occupationtype
	compress

* standardise positions
	include supp-standardise.do
		
	replace otype = "employment":otype if emp_type!=.
	replace otype = "education":otype if edu_type!=.
	
	* deal with 'missing' times
	if 1{ 

		* fill in missing years

		* this is to see the extent of 'missing data' (note that if yearend is missing it can indicate ongoing employment or education)
		count if yearstart==. & yearend==.
		drop if yearstart==. & yearend==.
		
		count if yearstart==. & yearend!=.
		count if yearstart!=. & yearend==.

		
		* if year is missing for education, then subtract 3 years from end date for undergraduate and PhD and 1 for masters or unknown
		replace yearstart = yearend-1 if yearstart==. &  yearend!=. & otype=="education":otype & ( edu_type=="master":edu_type |  edu_type==. )
		replace yearend = yearstart + 1 if yearend ==. & yearstart!=. & otype=="education":otype & ( edu_type=="master":edu_type |  edu_type==. )
		
		replace yearstart = yearend-4 if yearstart==. &  yearend!=. & otype=="education":otype & ( edu_type!="master":edu_type & edu_type!=. )
		replace yearend = yearstart + 4 if yearend ==. & yearstart!=. & otype=="education":otype & ( edu_type!="master":edu_type & edu_type!=. )
		replace yearend = `yearmax' if yearend >`yearmax' & yearend!=. & otype=="education":otype
		
 		* if no starting date, then assume started the year before employment, if end year is beyond the sample period, then assign the maximum sample year
		replace yearstart = yearend - 1 if yearstart ==. & yearend!=. & otype=="employment":otype
		replace yearend = `yearmax' if yearend >`yearmax' & yearend!=. & otype=="employment":otype
		
		* if no end date, then assume this continues for either 5 years or until now (whichever is lowest)
		* you can change this line to allow ongoing employment (as it would show up on the ORCID web interface) by changding the line below to: replace yearend = `yearmax' if yearend ==. & yearstart!=. & otype=="employment":otype
		replace yearend = yearstart + 5 if yearend ==. & yearstart!=. & otype=="employment":otype
		
		* check that years make sense
		count if yearstart>yearend
				
		count if yearstart==. & yearend==.
		count if yearstart>yearend

	}
	* folding for : deal with 'missing' times (assumptions) *

** reshaping of the data
** do a manual reshaping of the data into a long form (easier to calculate stocks/flows)	
	gen yearsinposition = yearend-yearstart+1

	* generate a grouping by position country-year
	gen tempidgroup = _n

	* expand by the number of yearsin position
	expand yearsinposition

	bysort orcid position tempidgroup (yearstart yearend) : gen year = yearstart+_n-1

	* now can get rid of the yearstart/end
	drop yearstart yearend

	* won't need these either
	drop position tempidgroup

	* if you had different positions in the same country-year, then there will be duplicates
	drop yearsinposition
	duplicates drop

* this file will be re-used for descriptives to avoid re-calculating the necessary info from the scratch
	compress
	save orciddata/data-processed.dta, replace
			
	* see description at the end *
	if 1{ 

		use orciddata/data-processed.dta, clear
		
		* identify the origin based on year
		bysort orcid (year) : gen origincountry = countryiso2code[1]
		label values origincountry countryiso2code
		
		rename countryiso2code currentlocation
		
		gen stock_all = 1
		gen stock_students = (otype=="education":otype)
		gen stock_workers = (otype=="employment":otype)
		
		* keep just the period of interest
		keep if year>=`yearmin' & year<=`yearmax'
		
		* aggregate
		collapse (sum) stock_*, by(currentlocation origincountry year)
		
		rename currentlocation destination
		rename origincountry origin
				
		tempfile stocks
		save `stocks'

	}
	* folding for : * create bilateral stocks *
	
	* see description at the end *
	if 1{ 

		use orciddata/data-processed.dta, clear
		
		* identify the country in which the user was last year
		* note that due to individuals with multiple countries I will need to form all bilateral combinations of origin destination
		rename countryiso2code destination
		rename otype otype_destination
		
		replace year = year + 1
		drop if year>`yearmax'+1
		
		joinby orcid year using orciddata/data-processed.dta

		rename countryiso2code origin
		rename otype otype_origin
		drop otype_origin
		
		duplicates drop
		
		gen flow_all = 1
		gen flow_students = (otype=="education":otype)
		gen flow_workers = (otype=="employment":otype)
		
		keep if year>=`yearmin' & year<=`yearmax'

		* aggregate
		collapse (sum) flow_*, by(destination origin year)		
		
		* add stocks calculated earlier
		merge 1:1 origin destination year using `stocks'
		drop _merge
		
		* replace with zeros
		foreach v of varlist flow_* stock_*{
			replace `v' = 0 if `v' ==. 
		}
		
		order year origin destination flow_all stock_all flow_students stock_students flow_workers stock_workers
		compress
		
		label variable year "Calendar year"
		label variable destination "Country of destination for the bilateral flow data or country of the current location for the stock data"
		label variable origin "Country of origin of the bilateral flow data or country of the individual's origin for the stock data"
		
		label variable flow_all "The bilateral flow of students and workers who moved from origin to destination country"
		label variable flow_students "The bilateral flow of students who moved from origin to destination country"
		label variable flow_workers "The bilateral flow of workers who moved from origin to destination country"

		
		* save file (note this is the asymmetric form, must apply rectangularization for gravity-type analysis		
		save orciddata/data-v1.0.dta, replace 
		export delimited using orciddata/data-v1.0.csv, replace
		
		* also export country codes
		use countryiso2code countrycode using countrycodes-orcid.dta , clear
		sort countryiso2code
		rename countryiso2code iso2
		rename countrycode countryname
		export delimited using orciddata/country-names.txt, replace
		
		* also generate the list of excluded orcids
		import delimited using orciddata/orcid-raw.csv, clear encoding("UTF-8") `rowlimit' colrange(1:1)
		rename v1 orcid_string		
		gen orcid = 1
		include supp-fix-orcids.do
		keep if orcid==.
		drop orcid
		duplicates drop
		sort orcid
		export delimited using orciddata/excluded.txt, replace novarna

	}
	* folding for : create bilateral flows, add stocks and save *

log close
