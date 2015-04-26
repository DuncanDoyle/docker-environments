#!/bin/sh
echo "Seting up the Docker directory."

echo "Creating the PostgreSQL layer in dockerfile_copy/layers"
cd install-postgresql-layer && ant install-layer

