#!/bin/bash

#===========================================================
# Ronald Wochner
# Originally based on a project for class. See www.github.com/ronwoch
# 11/24/2020
# Version 2.1
# Simple bash script to create the boiler plate for scripts of different languages
#===========================================================

#===========================================================
# Configuration variables. Adjust as needed.
# Set this to the directory you want to store your new scripts in

scriptspath=$HOME/github/scripting

#===========================================================

file_name=$1
description=$2
today="`date`"
language=$3
shbang=''
author=$4
insert_hello=$5
scriptdir=$scriptspath/$file_name

# Check that all elements are given
if [ $# -lt 4 ]
then 
    echo "Usage: $0 \"file name (WITHOUT file extension)  \" \"description\" \"language [bash]\" \"author's name [whoami]\" \"insert test string\""
    exit
fi

# Set author if provided, otherwise use 'whoami' to get a username.
if [ "$author" == "" ]
then
    echo "No author supplied, using result of whoami..."
    author=`whoami`
fi

# Check if we should insert a "Hello, World!"
if [ "$insert_hello" == "" ]
then
    echo "No 'hello world! string specified, script body will be empty."
fi

case "$3" in 
    [Bb]'ash') echo "creating a $language script... "
        language='bash'
        shbang='/bin/bash'
        extension='.sh'
        ;;
    
    [Pp]'owershell') echo "creating a $language script... " 
        language='powershell'
        shbang='/usr/bin/powershell'
        extension='.ps1'
        ;;

    [Pp]'ython') echo "creating a $language script... " 
        language='python'
        shbang='/usr/bin/python'
        extension='.py'
        ;;

    [Pp]'erl') echo "creating a $language script... " 
        language='perl'
        shbang='/usr/bin/perl'
        extension='.pl'
        ;;

    [Rr]'uby') echo "creating a $language script... " 
        language='ruby'
        shbang='/usr/bin/ruby'
        extension='.rb'
        ;;

    [Pp]'hp') echo "creating a $language script... " 
        language='php'
        shbang='/usr/bin/php'
        extension='.php'
        ;;
    
    *) echo "$language not recognized, defaulting to bash..."
        language='bash'
        shbang='/bin/bash'
        extension='.sh'
        ;;
esac


# Check if a directory for the script exists, if so move into it
if [ -e "$scriptdir" ]
then
        echo "Error: "$scriptdir" exists! CD'ing instead..."
        cd $scriptdir
else
        echo "Creating $scriptdir" 
        mkdir $scriptdir
        echo "Changing into $scriptdir"
        cd $scriptdir
fi

# Create a bash alias 
if [ -f $HOME/.bash_aliases ]
then
        echo "Creating a bash alias for your new script."
        echo "alias $file_name='bash $scriptdir/$file_name$extension'" >> $HOME/.bash_aliases
# Append a file extension to our file name. Not needed on UNIX systems, however, very useful on Windows boxes and makes our generated scripts more portable (and readable)
        file_name="$file_name$extension"
else
        echo "Creating a bash alias for your new script."
        echo "alias $file_name='bash $scriptdir/$file_name$extension'" >> $HOME/.bash_aliases
        file_name="$file_name$extension"
fi

# Check if file with the provided file name exists, if it does we error out and exit so as not to clobber anything important. 
if [ -e "$file_name" ]
then
        echo "Error: "$file_name" exists!"
else
        touch "$file_name"
        echo "Created $file_name"
if [ "$language" == "php" ]
then
        echo "<?php " >> $file_name
fi
echo "#!$shbang" >> $file_name
echo "#=========================================================================================" >> $file_name
echo "# $file_name" >> $file_name
echo "# $author " >> $file_name
echo "# $today" >> $file_name
echo "# Version 1" >> $file_name
echo "# $language script. Description:  $description" >> $file_name
echo "# This script was generated using gen_script.sh, written by Ron Wochner" >> $file_name
echo "#=========================================================================================" >> $file_name
echo "" >> $file_name
echo "" >> $file_name
echo "" >> $file_name
echo "$insert_hello" >> $file_name
if [ "$language" == "php" ]
then
echo "?>" >> $file_name
fi
echo "Added date: $today and description: $description"
echo "Changing permisions on "$file_name""
chmod a+x "$file_name"
fi

# Pause and allow a chance to read the output
echo "Opening script in $EDITOR..."
read -rsp $'Press any key to continue...\n' -n1 key
$EDITOR $file_name



exit
