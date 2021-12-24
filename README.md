# scripting
No longer so simple bash script to generate a new script or source file in various languages, with the appropriate boilerplate inserted as needed.
Version 4 now uses templates, stored in a sub directory, so that they can be easily modified or added to (create an appropriate language template, and add a case to the code for that language.) Also shifted to using getopts, so flags operate as flags (with semi-sane defaults) and position is no longer critical. YEAH! genscript.sh -h will display the options. Also now supports C and C++, as well as a flag for copying a Makefile template. (Still need to iron out the makefile stuff to make it more "Out Of Box")

Merry Christmas! 2021
