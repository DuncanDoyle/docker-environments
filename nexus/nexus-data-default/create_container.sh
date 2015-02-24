#!/bin/sh
#
# Creates the Docker container.
#
# author: ddoyle@redhat.com
#
docker create --name=nexus-data-default ddoyle/nexus-data-default:1.0.0
