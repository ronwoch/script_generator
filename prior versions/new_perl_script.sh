#!/bin/bash

#===========================================================
# Ronald Wochner
# 5/16/2017
# Version 1.1
# Simple bash script to create the boiler plate for Perl scripts
#===========================================================

file_name=$1
description=$2
today="`date`"
if [ -e "$file_name" ]
then
 echo "Error: "$file_name" exists!"
else
 touch "$file_name"
 echo "Created $file_name"
 echo "#!/usr/bin/perl" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "# Ronald Wochner " >> $file_name
 echo "# $today" >> $file_name
 echo "# Version 1" >> $file_name
 echo "# Simple Perl script to $description" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "exit" >> $file_name
 echo "Added date: $today and description: $description"
 echo "Changing permisions on "$file_name""
 chmod a+x "$file_name"
fi



exit
