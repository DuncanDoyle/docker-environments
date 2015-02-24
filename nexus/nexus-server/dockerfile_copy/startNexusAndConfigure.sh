#!/bin/sh
#
# Starts Nexus (console) and configures the platform. 
#
# author: ddoyle@redhat.com
#
$NEXUS_HOME/bin/nexus console & ./add_nexus_repositories.sh -r /data/nexus/nexus-data-3rdparty

