#!/bin/bash

#===========================================================
# Ronald Wochner
# Originally based on a project for class. See www.github.com/ronwoch
# 12/06/2021
# Version 3.0
# Simple bash script to create the boiler plate for scripts of different languages
#===========================================================

#===========================================================
# Configuration variables. Adjust as needed.
# Set scriptspath to the directory you want to store your new scripts in

installpath=$HOME/git-repos/github/scripting
scriptspath=$HOME/git-repos/github/

#===========================================================

file_name=$1
description=$2
today="`date`"
language=$3
shbang=''
author=$4
insert_hello=$5
scriptdir=$scriptspath/$file_name
templates=$installpath/templates

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
        source $templates/bash.template

    [Pp]'owershell' echo "creating a $language script... " 
        source $templates/powershell.template
        ;;

    [Pp]'ython') echo "creating a $language script... " 
        source $templates/python.template
        ;;

    [Pp]'erl') echo "creating a $language script... " 
        source $templates/perl.template
        ;;

    [Rr]'uby') echo "creating a $language script... " 
        source $templates/perl.template
        ;;

    [Pp]'hp') echo "creating a $language script... " 
        source $templates/php.template
        ;;
    
    *) echo "$language not recognized, defaulting to bash..."
        source $templates/bash.template
        ;;

esac


# Check if scriptpath exists, if so move into it
if [ -e "$scriptspath" ]
then
        echo "Info: "$scriptspath" exists! CD'ing instead..."
        cd $scriptspath
else
        echo "Creating $scriptspath" 
        mkdir $scriptspath
        echo "Changing into $scriptspath"
        cd $scriptspthath
fi

# Check if a directory for the script exists, if so move into it
if [ -e "$scriptdir" ]
then
        echo "Info: "$scriptdir" exists! CD'ing instead..."
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
$EDITOR $scriptdir/$file_name



exit
