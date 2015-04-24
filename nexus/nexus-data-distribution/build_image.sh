#!/bin/sh
#
# Builds the Docker container.
#
# author: ddoyle@redhat.com
#
docker build --rm -t ddoyle/nexus-data-distribution:1.0.0 .
