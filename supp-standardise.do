* standardise positions

* see description at the end *
if 1{

	capture noisily gen edu_type =. 
	label define edu_type 1 "bachelor" 2 "master" 3 "phd" 4 "md", modify
	label values edu_type edu_type
	* phd or doctor of science

	replace edu_type = 1 if regexm(position,"^b[\.]?[\ ]?[a]?[sc]*[\.]?$")
	replace edu_type = 1 if regexm(position,"^b[\.]?[\ ]?[a]?[sc]*[\.]? \(hons\)$")
	replace edu_type = 1 if regexm(position,"^b[\.]?[\ ]?[a]?[sc]*[\.]? \(hono[u]?rs\)$")
	replace edu_type = 1 if regexm(position,"^b[\.]?[\ ]?eng[\.]?$")
	replace edu_type = 1 if regexm(position,"^a[\.]?[\ ]?b[\.]?$")
	replace edu_type = 1 if regexm(position,"^sc[\.]?[\ ]?b[\.]?$")
	replace edu_type = 1 if regexm(position,"^b[\.]?[\ ]?e[\.]?$")
	replace edu_type = 1 if regexm(position,"^bachelor[\']?[s]?$")
	replace edu_type = 1 if regexm(position,"^bachelor[\']?[s]? degree$")
	replace edu_type = 1 if regexm(position,"^bachelor[\']?[s]? of science$")
	replace edu_type = 1 if regexm(position,"^bachelor[\']?[s]? of engineering$")
	replace edu_type = 1 if regexm(position,"^bachelor[\']?[s]? of arts$")
	replace edu_type = 1 if regexm(position,"^bachelor[\']?[s]? of technology$")
	replace edu_type = 1 if regexm(position,"^b[\.]?[\ ]?tech$")
	replace edu_type = 1 if regexm(position,"^undergrad[\.]?$")
	replace edu_type = 1 if regexm(position,"^undergraduate$")
	
	replace edu_type = 2 if regexm(position,"^m[\.]?[\ ]?[a]?[sc]*[\.]?$")
	replace edu_type = 2 if regexm(position,"^m[\.]?[\ ]?eng[\.]?$")
	replace edu_type = 2 if regexm(position,"^master[s]?$")
	replace edu_type = 2 if regexm(position,"^master[\']?[s]? of science$")
	replace edu_type = 2 if regexm(position,"^master of arts$")
	replace edu_type = 2 if regexm(position,"^magister$")
	replace edu_type = 2 if regexm(position,"^master of engineering$")
	replace edu_type = 2 if regexm(position,"^master[\']?[s]? degree$")
	replace edu_type = 2 if regexm(position,"^mba$")
	replace edu_type = 2 if regexm(position,"^mph$")
	replace edu_type = 2 if regexm(position,"^master[\']?[s]? of public health$")
	replace edu_type = 2 if regexm(position,"^m[\.]?[\ ]?phil[\.]?$")
	replace edu_type = 2 if regexm(position,"^m[\.]?tech[\.]?$")
	replace edu_type = 2 if regexm(position,"^mbbs$")
	
	replace edu_type = 3 if regexm(position,"^ph[\.]?[\ ]?d[\.]?$")
	replace edu_type = 3 if regexm(position,"^ph[\.]?[\ ]?d[\.]? in [a-z]*$")
	replace edu_type = 3 if regexm(position,"^d[\.]?[\ ]?phil[\.]?$")
	replace edu_type = 3 if regexm(position,"^doctor$") & otype=="education":otype
	replace edu_type = 3 if regexm(position,"^d[\.]?[\ ]?r[\.]$") & otype=="education":otype
	replace edu_type = 3 if regexm(position,"^doctor of philosophy$")
	replace edu_type = 3 if regexm(position,"^doctor of science$")
	replace edu_type = 3 if regexm(position,"^ph[\.]?[\ ]?d[\.]? student$")
	replace edu_type = 3 if regexm(position,"^ph[\.]?[\ ]?d[\.]? candidate$")
	replace edu_type = 3 if regexm(position,"^doctoral candidate$")
	replace edu_type = 3 if regexm(position,"^doctoral student$")
	
	replace edu_type = 4 if regexm(position,"^m[\.]?[\ ]?d[\.]?$")
	replace edu_type = 4 if regexm(position,"^m[\.]?[\ ]?d[\.]?, phd$")
	replace edu_type = 4 if regexm(position,"^medical doctor$") & otype=="education":otype
	replace edu_type = 4 if regexm(position,"^doctor of medicine$") & otype=="education":otype
	
}
* folding for : education types *
* labels for education types

* see description at the end *
if 1{

	capture noisily gen emp_type =. 
	label define emp_type 1 "postdoc" 2 "(senior) lecturer" 3 "assistant professor" 4 "associate professor" 5 "professor" 6 "(senior) researcher/research associate/research fellow/(research) scientist" 7 "research assistant" 8 "teaching assistant" 9 "medical doctor" 10 "resident" 11 "teaching assistant" 12 "adjunct professor", modify
	label values emp_type emp_type

	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doc$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doc researcher$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doctoral$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doctoral fellow$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doctoral research fellow$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doctoral research associate$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doctoral associate$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doctoral scholar$")
	replace emp_type = 1 if regexm(position,"^post[-]?[\ ]?doctoral researcher$")
	
	replace emp_type = 2 if regexm(position,"^lecturer$")
	replace emp_type = 2 if regexm(position,"^senior lecturer$")
	replace emp_type = 2 if regexm(position,"^assistant lecturer$")
	
	replace emp_type = 3 if regexm(position,"^assistant professor$")
	replace emp_type = 3 if regexm(position,"^research assistant professor$")
	
	replace emp_type = 4 if regexm(position,"^associate professor$")
	
	replace emp_type = 5 if regexm(position,"^professor$")
	replace emp_type = 5 if regexm(position,"^profesor$")
	replace emp_type = 5 if regexm(position,"^full professor$")
	replace emp_type = 5 if regexm(position,"^tenured professor$")
	
	replace emp_type = 6 if regexm(position,"^junior researcher$")
	replace emp_type = 6 if regexm(position,"^assistant researcher$")
	replace emp_type = 6 if regexm(position,"^researcher$")
	replace emp_type = 6 if regexm(position,"^research scholar$")
	replace emp_type = 6 if regexm(position,"^research officer$")
	replace emp_type = 6 if regexm(position,"^researcher \(academic\)$")
	replace emp_type = 6 if regexm(position,"^research associate$")
	replace emp_type = 6 if regexm(position,"^junior research fellow$")
	replace emp_type = 6 if regexm(position,"^research fellow$")
	replace emp_type = 6 if regexm(position,"^senior research fellow$")
	replace emp_type = 6 if regexm(position,"^scientist$")
	replace emp_type = 6 if regexm(position,"^senior scientist$")
	replace emp_type = 6 if regexm(position,"^research scientist$")
	replace emp_type = 6 if regexm(position,"^senior researcher$")
	
	replace emp_type = 7 if regexm(position,"^research assistant$")
	
	replace emp_type = 9 if regexm(position,"^medical doctor$") & otype=="employment":otype
	replace emp_type = 9 if regexm(position,"^doctor of medicine$") & otype=="employment":otype
	replace emp_type = 9 if regexm(position,"^doctor$") & otype=="employment":otype
	
	replace emp_type = 10 if regexm(position,"^resident$")
	replace emp_type = 10 if regexm(position,"^residency$")
	
	replace emp_type = 11 if regexm(position,"^teaching assistant$")
	
	replace emp_type = 12 if regexm(position,"^adjunct professor$")
	

}
* folding for : employment types *
	
