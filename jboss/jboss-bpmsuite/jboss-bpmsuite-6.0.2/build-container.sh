#!/bin/sh
#
# Builds the Docker container.
#
# author: ddoyle@redhat.com
#
docker build --rm -t ddoyle/jboss-bpmsuite:6.0.2 .
