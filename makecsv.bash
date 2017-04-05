#!/bin/bash

# this script will run for about 2 hours

# download the data manually (change to the directory containing the downloaded file before running this script)

# change the raw file name below IF the file was re-named after downloading
rawfile="ORCID_public_data_file_2016.tar"

# this command creates a folder which will store the processed file
mkdir orciddata

# the first command untars just the json files and pipes them (to avoid extracting millions of individual files) to jq, which extracts just the information of interest and stores it in csv format
tar -xf "$rawfile" --exclude="xml" --include="*.json" -O | jq -rc '."orcid-profile"|."orcid-identifier".path as $id|."orcid-activities"| if .==null then empty else .affiliations end| if .==null then empty else .affiliation end| if type=="array" then .[] else . end|[$id,."start-date"."year".value,."end-date".year.value,.type,(."role-title"|if .==null then . else (.|gsub("\r";"")|gsub("\n";"")) end),.organization.address.country]|@csv' > "orciddata/orcid-raw.csv"
