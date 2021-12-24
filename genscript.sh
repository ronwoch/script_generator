#!/bin/bash

#===========================================================
# GenScript by Ronald Wochner
# Originally based on a project for class. See www.github.com/ronwoch
# 12/06/2021
# Version 4.0
# Updated: 12/24/21
# No longer simple bash script to create the boiler/header for scripts/programs of different languages
#===========================================================

genscript_version="4.0"

#===========================================================
# Configuration variables. Adjust as needed.
# Set scriptspath to the directory you want to store your new scripts in

installpath=$HOME/git-repos/github/script_generator
scriptspath=$HOME/git-repos/github/

#===========================================================

file_name="test"
description="Description here"
today="`date`"
language="bash"
shbang=''
author=`whoami`
scriptdir=$scriptspath$file_name
templates=$installpath/templates
version="1.0"
create_makefile="false"
set_execute="false"
create_alias="false"
new_dir="false"

Help() {
# Display help
    echo "Script and source file generator by Ron Wochner."
    echo
    echo "Syntax: gs [-h|V|N|a|l|v|m|f|d|e|s]"
    echo "options:"
    echo "h Flag. Print this Help and exit."
    echo "V Flag. Print GenScript version and exit."
    echo "N Create a new directory for this project to reside in. Otherwise, create in pwd. Takes argument."
    echo "a Author's name. If none is provided, the result of [whoami] is used. Takes argument."
    echo "l File language [bash is default] Takes argument."
    echo "v Version number to insert in file. Takes argument."
    echo "m Flag. Copy template makefile"
    echo "f File name (WITHOUT file extension) Takes argument."
    echo "d Description of the script or source file. Must be enclosed in double quotes Takes argument."
    echo "e Flag. Make script file executable"
    echo "s Flag. Create a bash alias for file name."
    echo
    exit
}

Create_Scriptpath() {
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
}

Create_Scriptdir() {
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
}

Generate_File() {
# Check if file with the provided file name exists, if it does we error out and exit so as not to clobber anything important. 
if [ -e "$file_name" ]
then
        echo "Error: "$file_name" exists!"
        exit
else
        touch "$file_name"
        echo "Created $file_name"
fi

if [ "$language" == "php" ]
then
        echo "<?php " >> $file_name
fi

echo $shbang >> $file_name
echo "" >> $file_name
echo "#=========================================================================================" >> $file_name
echo "# $file_name" >> $file_name
echo "# $author " >> $file_name
echo "# $today" >> $file_name
echo "# Version: $version" >> $file_name
echo "# Description:  $description" >> $file_name
echo "# $language file.">> $file_name
echo "# This file was generated using GenScript version: $genscript_version, written by Ron Wochner" >> $file_name
echo "# Visit https://www.github.com/ronwoch/script_generator to get a copy" >> $file_name
echo "#=========================================================================================" >> $file_name
echo "" >> $file_name
echo "" >> $file_name
echo "" >> $file_name
echo $includes >> $file_name
echo "" >> $file_name
echo "" >> $file_name
echo $body >> $file_name
echo "" >> $file_name

if [ "$language" == "php" ]
then
        echo "?>" >> $file_name
fi
echo "Added date: $today and description: $description"


# Pause and allow a chance to read the output
read -rsp $'Press any key to continue...\n' -n1 key
}




# Main program                                             #
############################################################
# Process the input options. Add options as needed.        #
############################################################
while getopts "hVNa:l:v:mf:d:es" option; do
   case $option in
        h) # display Help
                Help
                exit
                ;;

        V) #print genscript version
                echo $genscript_version
                exit
                ;;

        N) # Create new directory folder?
                new_dir="true"
                ;;

        a) #Set Author if provided
                 author=$OPTARG
                 ;;

        l) #Set Language
                 language=$OPTARG
                 ;;

        v) ## Insert a version number
                version=$OPTARG
                ;;

        m) # Create Makefile
                create_makefile="true"
                ;;

        f) # file name
                file_name=$OPTARG
                ;;

        d) # description
                description=$OPTARG
                ;;

        e) # e to set execute bit
                set_execute="true"
                ;;

        s) # create an alias
                make_alias="true"
                ;;

        \?) # Invalid option
                 echo "Error: Invalid option"
                 exit;;
        esac
done

case "$language" in
        [Bb]'ash') source $templates/bash.template
                ;;

        [Pp]'owershell') source $templates/powershell.template
                ;;

        [Pp]'ython') source $templates/python.template
                ;;

        [Pp]'erl')   source $templates/perl.template
                ;;

        [Rr]'uby')   source $templates/ruby.template
                ;;

        [Pp]'hp')   source $templates/php.template
                ;;

        [Cc])   source $templates/c.template
                ;;
            
        [Cc]'pp')   source $templates/cpp.template
                ;;

        *) echo "$language not recognized, defaulting to bash..."
                source $templates/bash.template
                ;;
esac


if [ "$new_dir" == "true" ]
then
        Create_Scriptpath
        scriptdir=$scriptspath$file_name
        file_name="$file_name$extension"
        Create_Scriptdir
else
        file_name="$file_name$extension"
        scriptdir="`pwd`\$file_name"
fi

echo "creating a $language file... " 

Generate_File

if [ "$create_makefile" == "true" ]
then
        echo "Copying Makefile template."
        cp $templates/Makefile.template $scriptdir/Makefile
fi

if [ "$set_execute" == "true" ]
then
        echo "Changing permisions on "$file_name""
        chmod a+x "$file_name"
fi

if [ "$make_alias" == "true" ]
then
        if [ -f $HOME/.bash_aliases ]
        then
                echo "Creating a bash alias for your new script. Remember to source your aliases file in the terminal to make it work."
                echo "alias $file_name='bash $scriptdir/$file_name$extension'" >> $HOME/.bash_aliases
        fi
fi


exit
