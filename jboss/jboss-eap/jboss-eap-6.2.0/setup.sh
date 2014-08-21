#!/bin/sh
echo "Seting up the Docker directory."
echo "Copying JBoss EAP patch and profile-setup scripts."
cp ../../../scripts/patch-jboss-eap.sh dockerfile_copy/
cp ../../../scripts/setup-jboss-eap-profile.sh dockerfile_copy/
