#!/bin/sh
echo "Seting up the Docker directory."
echo "Copying JBoss EAP patch and profile-setup scripts."
cp ../../../scripts/setup-jboss-eap-profile.sh dockerfile_copy/

echo "Creating the PostgreSQL layer in dockerfile_copy/layers"
cd install-postgresql-layer && ant install-layer

