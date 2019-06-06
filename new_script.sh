#!/bin/bash

#===========================================================
# Ronald Wochner
# 5/23/2017
# Version 1.1.1
# Simple bash script to create the boiler plate for scripts of different languages
#===========================================================

file_name=$1
description=$2
today="`date`"
language=$3
shbang=''

# Check that all 3 elements are given
if [ $# -lt 3 ]
then 
    echo 'Usage: $0 \"file name \" \"description\" \"language\"'
    exit
fi

case "$3" in 
    [Bb]'ash') echo "creating a $language script... "
        language='bash'
        shbang='/bin/bash'
		useage='usage() {
	echo -e "\n usage: $0 filename \n"
}
if [ $# -lt 1 ]; then
	usage
	exit 1
fi
'	
        ;;
    
    [Pp]'owershell') echo "creating a $language script... " 
        language='powershell'
        shbang='/usr/bin/powershell'
        ;;

    [Pp]'ython') echo "creating a $language script... " 
        language='python'
        shbang='/usr/bin/python'
        ;;

    [Pp]'erl') echo "creating a $language script... " 
        language='perl'
        shbang='/usr/bin/perl'
        ;;

    [Rr]'uby') echo "creating a $language script... " 
        language='ruby'
        shbang='/usr/bin/ruby'
        ;;

    [Pp]'hp') echo "creating a $language script... " 
        language='php'
        shbang='/usr/bin/php'
        ;;
    
    *) echo "$language not recognized, defaulting to bash..."
        language='bash'
        shbang='/bin/bash'
        ;;
esac


if [ -e "$file_name" ]
then
 echo "Error: "$file_name" exists!"
else
 touch "$file_name"
 echo "Created $file_name"
 echo "#!$shbang" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "# $file_name" >> $file_name
 echo "# $USER " >> $file_name
 echo "# $today" >> $file_name
 echo "# Version 1" >> $file_name
 echo "# $language script to $description" >> $file_name
 echo "#=========================================================================================" >> $file_name
 echo "" >> $file_name
 echo "$useage" >> $file_name
 echo "" >> $file_name
 echo "" >> $file_name
 echo "Added date: $today and description: $description"
 echo "Changing permisions on "$file_name""
 chmod a+x "$file_name"
fi



exit
