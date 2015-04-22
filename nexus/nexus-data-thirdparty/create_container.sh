#!/bin/sh
#
# Creates the Docker container.
#
# author: ddoyle@redhat.com
#
docker create --name=nexus-data-thirdparty ddoyle/nexus-data-thirdparty:1.0.0
