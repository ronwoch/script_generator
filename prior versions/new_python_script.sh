#!/bin/bash

#===========================================================
# Ronald Wochner
# 5/16/2017
# Version 1
# Simple bash script to create the boiler plate for Python scripts
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
 echo "#!/usr/bin/python" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "# Ronald Wochner " >> $file_name
 echo "# $date" >> $file_name
 echo "# Version 1" >> $file_name
 echo "# Simple Powershell script to $description" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "exit" >> $file_name
 echo "Added date: $2 and description: $3"
 echo "Changing permisions on "$file_name""
 chmod a+x "$file_name"
fi



exit
