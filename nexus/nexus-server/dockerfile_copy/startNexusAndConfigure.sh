#!/bin/sh
#
# Starts Nexus (console) and configures the platform. 
#
# author: ddoyle@redhat.com
#
#$NEXUS_HOME/bin/nexus console & ./add_nexus_repositories.sh -r /data/nexus/repositories
./add_nexus_repositories.sh -r /data/nexus/repositories & $NEXUS_HOME/bin/nexus console


