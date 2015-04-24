#
# Nexus data-container for thirdparty repo's.
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
USER nexus 
# JBoss EAP 6.3.0
RUN unzip /tmp/dockerfile_copy/jboss-eap-6.3.0-maven-repository.zip -d /data/nexus/repositories/thirdparty && cp /tmp/dockerfile_copy/jboss-eap-6.3.0.GA-maven-repository-nexus-rest-repository_add_request.json /data/nexus/repositories/thirdparty/jboss-eap-6.3.0.GA-maven-repository-nexus-rest-repository_add_request.json

#JBoss EAP 6.4.0
RUN unzip /tmp/dockerfile_copy/jboss-eap-6.4.0-maven-repository.zip -d /data/nexus/repositories/thirdparty && cp /tmp/dockerfile_copy/jboss-eap-6.4.0.GA-maven-repository-nexus-rest-repository_add_request.json /data/nexus/repositories/thirdparty/jboss-eap-6.4.0.GA-maven-repository-nexus-rest-repository_add_request.json

#JBoss BPMSuite 6.1.0.GA
RUN unzip /tmp/dockerfile_copy/jboss-bpmsuite-6.1.0.GA-maven-repository.zip -d /data/nexus/repositories/thirdparty && cp /tmp/dockerfile_copy/jboss-bpmsuite-6.1.0.GA-maven-repository-nexus-rest-repository_add_request.json /data/nexus/repositories/thirdparty/jboss-bpmsuite-6.1.0.GA-maven-repository-nexus-rest-repository_add_request.json

# Set correct access rights (no longer needed when COPY sets file ownership to USER).
USER root
RUN rm -rf /tmp/dockerfile_copy
USER nexus

# Data volume for the nexus-repo's
VOLUME ["/data/nexus/repositories/thirdparty"]


