#!/bin/sh
#
# Builds the Docker container.
#
# author: ddoyle@redhat.com
#
docker build --rm -t ddoyle/jboss-eap:6.2.4 .
