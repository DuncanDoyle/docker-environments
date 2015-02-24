#!/bin/sh
#
# Builds the Docker image.
#
# author: ddoyle@redhat.com
#
docker build --rm -t ddoyle/nexus-data-default:1.0.0 .
