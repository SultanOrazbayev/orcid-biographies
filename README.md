# Replication code for: International stocks and flows of students and researchers reconstructed from ORCID biographies

This repository contains code which is needed to reproduce the data contained in the document "International stocks and flows of students and researchers reconstructed from ORCID biographies". 

To run the code you will need the following tools: bash, jq, Stata.

Steps:

0. Before running the files you must download the 2017 ORCID Public Data File (public_profiles_API2.0_2017_10_json.tar.gz) from https://figshare.com/articles/ORCID_Public_Data_File_2017/5479792. Note that the file is very large (4 GB+) and since each record is stored in individual files, extracting it will give millions of individual files! To avoid processing individual files, note the directory where you stored the downloaded file and proceed to step 1.

1. Make sure your terminal is changed into the relevant directory from step 0 (e.g. cd ~/desktop if your file is stored on the desktop). Run bash script called makecsv.bash. This script will combine all the individual records with at least one education or employment record into one big CSV file.

2. Run Stata script called orcid.do. This script will produce the dataset as reported in the document. Note that the other .do files (starting with "supp") are supporting files and there is no need to run them.

If you use or modify this code in your research, kindly cite me. Suggested citation:

Orazbayev, Sultan (2017) Replication code for: International stocks and flows of students and researchers reconstructed from ORCID biographies, doi: 10.6084/m9.figshare.4822798.

References:

Dolan, Stephen and other contributors (2015) "jq": https://stedolan.github.io/jq/.

Haak, Laurel, Josh Brown, Matthew Buys, Ana Patricia Cardoso, Paula Demain, Tom Demeranville, Maaike Duine, Stephanie Harley, Sarah Hershberger, Liz Krznarich, Alice Meadows, Nobuko Miyairi, Angel Montenegro, Laura Paglione, Lilian Pessoa, Robert Peters, Fran Ramı́rez Monge, Will Simpson, Catalina Wilmers, and Douglas Wright (2016). "ORCID Public Data File 2016". doi: 10.6084/m9.figshare.4134027.v1.
