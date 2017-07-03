#!/bin/bash
#=========================================================================================
# ../web_stop.sh
# Ronald Wochner 
# Wed May 31 09:35:26 PDT 2017
# Version 1
# Simple bash script to Start the web server to test scripts
#=========================================================================================

echo "Stopping apache2 web service..."
sudo /etc/init.d/apache2 stop

