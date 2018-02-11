#!/bin/bash

# this script will run for about 1.5-2 hours

# download the data manually (change to the directory containing the downloaded file before running this script)

# change the raw file name below IF the file was re-named after downloading
rawfile="public_profiles_API2.0_2017_10_json.tar.gz"
outfile="orciddata/orcid-raw.csv"

# this command creates a folder which will store the processed file
mkdir -p orciddata

# the first command untars just the json files and pipes them (to avoid extracting millions of individual files) to jq, which extracts just the information of interest and stores it in csv format

echo "orcid,countryiso2,yearstart,yearend,type,roletitle" > "$outfile" && \
tar -xf "$rawfile" -O | jq -rc '."orcid-identifier".path as $id|."activities-summary".educations|."education-summary"| if .==null then empty else .[] end| [$id,(.organization.address.country),."start-date"."year".value,."end-date".year.value,"EDUCATION",(."role-title"|if .==null then "NA:::n-u-l-l" else (.|gsub("\r";"")|gsub("\n";"")|gsub("\"";" ")|.[0:30]) end)]|@csv' >> "$outfile" && \
tar -xf "$rawfile" -O | jq -rc '."orcid-identifier".path as $id|."activities-summary".employments|."employment-summary"| if .==null then empty else .[] end| [$id,(.organization.address.country),."start-date"."year".value,."end-date".year.value,"EMPLOYMENT",(."role-title"|if .==null then "NA:::n-u-l-l" else (.|gsub("\r";"")|gsub("\n";"")|gsub("\"";" ")|.[0:30]) end)]|@csv' >> "$outfile"
