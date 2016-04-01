#!/bin/sh
#
# Builds the Docker container.
#
# author: ddoyle@redhat.com
#
docker build --rm -t ddoyle/jboss-bpmsuite_postgesql:6.2.0 .
