#
# Base image for all Docker data volume containers.
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
RUN mkdir -p /data/nexus/repositories && mkdir -p /data/nexus/json-add-repo-requests && chown -R nexus:nexus /data/nexus/
USER nexus 
RUN unzip /tmp/dockerfile_copy/jboss-eap-6.3.0-maven-repository.zip -d /data/nexus/repositories && mv /tmp/dockerfile_copy/jboss-eap-6.3.0.GA-maven-repository-nexus-rest-repository_add_request.json /data/nexus/json-add-repo-requests/jboss-eap-6.3.0.GA-maven-repository-nexus-rest-repository_add_request.json

# Set correct access rights (no longer needed when COPY sets file ownership to USER).
USER root
RUN rm -rf /tmp/dockerfile_copy
USER nexus

# Data volume for the nexus-repo's
VOLUME ["/data/nexus"]


