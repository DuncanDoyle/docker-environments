#
# Image for the Nexus repository that contains the artifacts created by our own build process (hence the name: distribution).
#
# This docker image uses CentOS 6 as the base OS (CentOS 7's systemd gives problems in a Docker environment atm),
#
FROM    ddoyle/data_base:1.0.0

MAINTAINER ddoyle <ddoyle@redhat.com>

# Install unzip. Maybe this should be done in the base data image ....
RUN yum -y install unzip && yum clean all

# Create a user in our data-volume so we can correctly map access rights.
RUN useradd -r -m  -s /sbin/nologin -c "Nexus image user" -p nexus@01 nexus

RUN mkdir /tmp/dockerfile_copy
COPY dockerfile_copy/ /tmp/dockerfile_copy

# Create the directory for all JBoss product installations.
RUN mkdir -p /data/nexus/repositories && chown -R nexus:nexus /data/nexus/

# Create the directory for distribution releases and snapshots.
USER nexus
RUN mkdir -p /data/nexus/repositories/distribution/release && cp /tmp/dockerfile_copy/distribution-release-nexus-rest-repository_add_request.json /data/nexus/repositories/distribution/distribution-release-nexus-rest-repository_add_request.json
RUN mkdir -p /data/nexus/repositories/distribution/snapshot && cp /tmp/dockerfile_copy/distribution-snapshot-nexus-rest-repository_add_request.json /data/nexus/repositories/distribution/distribution-snapshot-nexus-rest-repository_add_request.json

# Cleanup
USER root
RUN rm -rf /tmp/dockerfile_copy
USER nexus

# Data volume for the nexus-repo's
VOLUME ["/data/nexus/repositories/distribution"]

