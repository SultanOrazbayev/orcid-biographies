* standardise positions

* see description at the end *
if 1{

	capture noisily gen edu_type =. 
	label define edu_type 1 "bachelor" 2 "master" 3 "phd" 4 "md", modify
	label values edu_type edu_type
	* phd or doctor of science

	replace edu_type = 1 if ustrregexm(roletitle,"^b[\.]?[\ ]?[a]?[sc]*[\.]?$")
	replace edu_type = 1 if ustrregexm(roletitle,"^b[\.]?[\ ]?[a]?[sc]*[\.]? [a-z\ \(\)\[\]\-\,]*$")
	replace edu_type = 1 if ustrregexm(roletitle,"^b[\.]?[\ ]?[a]?[sc]*[\.]? \(hons\)$")
	replace edu_type = 1 if ustrregexm(roletitle,"^b[\.]?[\ ]?[a]?[sc]*[\.]? \(hono[u]?rs\)$")
	replace edu_type = 1 if ustrregexm(roletitle,"^b[\.]?[\ ]?eng[\.]?$")
	replace edu_type = 1 if ustrregexm(roletitle,"^a[\.]?[\ ]?b[\.]?$")
	replace edu_type = 1 if ustrregexm(roletitle,"^sc[\.]?[\ ]?b[\.]?$")
	replace edu_type = 1 if ustrregexm(roletitle,"^b[\.]?[\ ]?e[\.]?$")
	replace edu_type = 1 if ustrregexm(roletitle,"^bachelor[\']?[s]?$")
	replace edu_type = 1 if ustrregexm(roletitle,"^bachelor[\']?[s]? degree$")
	replace edu_type = 1 if ustrregexm(roletitle,"^bachelor[\']?[s]? of science$")
	replace edu_type = 1 if ustrregexm(roletitle,"^bachelor[\']?[s]? of engineering$")
	replace edu_type = 1 if ustrregexm(roletitle,"^bachelor[\']?[s]? of arts$")
	replace edu_type = 1 if ustrregexm(roletitle,"^bachelor[\']?[s]? of technology$")
	replace edu_type = 1 if ustrregexm(roletitle,"^b[\.]?[\ ]?tech$")
	replace edu_type = 1 if ustrregexm(roletitle,"^undergrad[\.]?$")
	replace edu_type = 1 if ustrregexm(roletitle,"^undergraduate$")
	
	replace edu_type = 2 if ustrregexm(roletitle,"^m[\.]?[\ ]?[a]?[sc]*[\.]?$")
	replace edu_type = 2 if ustrregexm(roletitle,"^m[\.]?[\ ]?[a]?[sc]*[\.]? [a-z\ \(\)\[\]\-\,]*$")
	replace edu_type = 2 if ustrregexm(roletitle,"^m[\.]?[\ ]?eng[\.]?$")
	replace edu_type = 2 if ustrregexm(roletitle,"^master[s]?$")
	replace edu_type = 2 if ustrregexm(roletitle,"^master[\']?[s]? of science$")
	replace edu_type = 2 if ustrregexm(roletitle,"^master of arts$")
	replace edu_type = 2 if ustrregexm(roletitle,"^magister$")
	replace edu_type = 2 if ustrregexm(roletitle,"^master of engineering$")
	replace edu_type = 2 if ustrregexm(roletitle,"^master[\']?[s]? degree$")
	replace edu_type = 2 if ustrregexm(roletitle,"^mba$")
	replace edu_type = 2 if ustrregexm(roletitle,"^mph$")
	replace edu_type = 2 if ustrregexm(roletitle,"^master[\']?[s]? of public health$")
	replace edu_type = 2 if ustrregexm(roletitle,"^m[\.]?[\ ]?phil[\.]?$")
	replace edu_type = 2 if ustrregexm(roletitle,"^m[\.]?tech[\.]?$")
	replace edu_type = 2 if ustrregexm(roletitle,"^mbbs$")
	
	replace edu_type = 3 if ustrregexm(roletitle,"^ph[\.]?[\ ]?d[\.]?$")
	replace edu_type = 3 if ustrregexm(roletitle,"^ph[\.]?[\ ]?d[\.]? in [a-z]*$")
	replace edu_type = 3 if ustrregexm(roletitle,"^ph[\.]?[\ ]?d[\.]? [a-z\ \(\)\[\]\-\,]*$")
	replace edu_type = 3 if ustrregexm(roletitle,"^d[\.]?[\ ]?phil[\.]?$")
	replace edu_type = 3 if ustrregexm(roletitle,"^doctor$") & occupationtype=="EDUCATION":occupationtype
	replace edu_type = 3 if ustrregexm(roletitle,"^d[\.]?[\ ]?r[\.]$") & occupationtype=="EDUCATION":occupationtype
	replace edu_type = 3 if ustrregexm(roletitle,"^doctor of philosophy$")
	replace edu_type = 3 if ustrregexm(roletitle,"^doctor of science$")
	replace edu_type = 3 if ustrregexm(roletitle,"^ph[\.]?[\ ]?d[\.]? student$")
	replace edu_type = 3 if ustrregexm(roletitle,"^ph[\.]?[\ ]?d[\.]? candidate$")
	replace edu_type = 3 if ustrregexm(roletitle,"^doctoral candidate$")
	replace edu_type = 3 if ustrregexm(roletitle,"^doctoral student$")
	
	replace edu_type = 4 if ustrregexm(roletitle,"^m[\.]?[\ ]?d[\.]?$")
	replace edu_type = 4 if ustrregexm(roletitle,"^m[\.]?[\ ]?d[\.]?, phd$")
	replace edu_type = 4 if ustrregexm(roletitle,"^medical doctor$") & occupationtype=="EDUCATION":occupationtype
	replace edu_type = 4 if ustrregexm(roletitle,"^doctor of medicine$") & occupationtype=="EDUCATION":occupationtype
	replace edu_type = 4 if ustrregexm(roletitle,"^.*doctor of medicine.*$") & occupationtype=="EDUCATION":occupationtype
	
}
* folding for : education types *
* labels for education types

* see description at the end *
if 1{

	capture noisily gen emp_type =. 
	label define emp_type 1 "postdoc" 2 "(senior) lecturer" 3 "assistant professor" 4 "associate professor" 5 "professor" 6 "(senior) researcher/research associate/research fellow/(research) scientist" 7 "research assistant" 8 "teaching assistant" 9 "medical doctor" 10 "resident" 11 "teaching assistant" 12 "adjunct professor", modify
	label values emp_type emp_type

	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doc$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doc researcher$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doctoral$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doctoral fellow$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doctoral research fellow$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doctoral research associate$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doctoral associate$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doctoral scholar$")
	replace emp_type = 1 if ustrregexm(roletitle,"^post[-]?[\ ]?doctoral researcher$")
	
	replace emp_type = 2 if ustrregexm(roletitle,"^lecturer$")
	replace emp_type = 2 if ustrregexm(roletitle,"^senior lecturer$")
	replace emp_type = 2 if ustrregexm(roletitle,"^assistant lecturer$")
	
	replace emp_type = 3 if ustrregexm(roletitle,"^assistant professor$")
	replace emp_type = 3 if ustrregexm(roletitle,"^research assistant professor$")
	
	replace emp_type = 4 if ustrregexm(roletitle,"^associate professor$")
	
	replace emp_type = 5 if ustrregexm(roletitle,"^professor$")
	replace emp_type = 5 if ustrregexm(roletitle,"^profesor$")
	replace emp_type = 5 if ustrregexm(roletitle,"^full professor$")
	replace emp_type = 5 if ustrregexm(roletitle,"^tenured professor$")
	
	replace emp_type = 6 if ustrregexm(roletitle,"^junior researcher$")
	replace emp_type = 6 if ustrregexm(roletitle,"^assistant researcher$")
	replace emp_type = 6 if ustrregexm(roletitle,"^researcher$")
	replace emp_type = 6 if ustrregexm(roletitle,"^research scholar$")
	replace emp_type = 6 if ustrregexm(roletitle,"^research officer$")
	replace emp_type = 6 if ustrregexm(roletitle,"^researcher \(academic\)$")
	replace emp_type = 6 if ustrregexm(roletitle,"^research associate$")
	replace emp_type = 6 if ustrregexm(roletitle,"^junior research fellow$")
	replace emp_type = 6 if ustrregexm(roletitle,"^research fellow$")
	replace emp_type = 6 if ustrregexm(roletitle,"^senior research fellow$")
	replace emp_type = 6 if ustrregexm(roletitle,"^scientist$")
	replace emp_type = 6 if ustrregexm(roletitle,"^senior scientist$")
	replace emp_type = 6 if ustrregexm(roletitle,"^research scientist$")
	replace emp_type = 6 if ustrregexm(roletitle,"^senior researcher$")
	
	replace emp_type = 7 if ustrregexm(roletitle,"^research assistant$")
	
	replace emp_type = 9 if ustrregexm(roletitle,"^medical doctor$") & occupationtype=="EMPLOYMENT":occupationtype
	replace emp_type = 9 if ustrregexm(roletitle,"^doctor of medicine$") & occupationtype=="EMPLOYMENT":occupationtype
	replace emp_type = 9 if ustrregexm(roletitle,"^doctor$") & occupationtype=="EMPLOYMENT":occupationtype
	
	replace emp_type = 10 if ustrregexm(roletitle,"^resident$")
	replace emp_type = 10 if ustrregexm(roletitle,"^residency$")
	
	replace emp_type = 11 if ustrregexm(roletitle,"^teaching assistant$")
	
	replace emp_type = 12 if ustrregexm(roletitle,"^adjunct professor$")
	

}
* folding for : employment types *
	
