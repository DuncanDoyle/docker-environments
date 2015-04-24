#!/bin/sh
#
# Creates the Docker container.
#
# author: ddoyle@redhat.com
#
docker create --name=nexus-data-distribution ddoyle/nexus-data-distribution:1.0.0
