#!/bin/sh
#
# Builds the Docker container.
#
# author: ddoyle@redhat.com
#
tar -czh . | docker build --rm -t duncandoyle/jboss-brms:6.4 -
