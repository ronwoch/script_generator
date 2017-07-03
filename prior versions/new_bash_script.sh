#!/bin/bash

#===========================================================
# Ronald Wochner
# 5/10/2017
# Version 1
# Simple shell script to create the boiler plate for other scripts
#===========================================================

file_name=$1
date=$2
description=$3
if [ -e "$file_name" ]
then
 echo "Error: "$file_name" exists!"
else
 touch "$file_name"
 echo "Created $file_name"
 echo "#!/bin/bash" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "# Ronald Wochner " >> $file_name
 echo "# $date" >> $file_name
 echo "# Version 1" >> $file_name
 echo "# Simple shell script to $description" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "exit" >> $file_name
 echo "Added date: $2 and description: $3"
 echo "Changing permisions on "$file_name""
 chmod a+x "$file_name"
fi



exit
