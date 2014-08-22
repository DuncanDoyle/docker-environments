# 
# Docker base image of JBoss BPMSuite 6.0.2
#
FROM ddoyle/jboss-eap-6.1.1

MAINTAINER ddoyle <ddoyle@redhat.com>

# Copy JBoss BPM-Suite
RUN mkdir /tmp/dockerfile_copy
COPY dockerfile_copy/jboss-bpms-6.0.2.GA-redhat-5-deployable-eap6.x.zip /tmp/dockerfile_copy/jboss-bpms-6.0.2.GA-redhat-5-deployable-eap6.x.zip

#Install BPMSuite 
RUN /usr/bin/unzip -qo /tmp/dockerfile_copy/jboss-bpms-6.0.2.GA-redhat-5-deployable-eap6.x.zip -d /opt/jboss

# Create initial users.
RUN /opt/jboss/jboss-eap-6.1/bin/add-user.sh -a -r ApplicationRealm -u bpmsAdmin -p jboss@01 -ro admin,analyst,developer --silent

# Clean up
USER root
RUN rm -rf /tmp/dockerfile_copy
USER jboss
