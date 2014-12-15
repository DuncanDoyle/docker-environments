# 
# Docker base image of JBoss BPMSuite 6.0.2
#
FROM ddoyle/jboss-eap:6.3.2

MAINTAINER ddoyle <ddoyle@redhat.com>

# Add installation files to tmp.
RUN mkdir -p /tmp/dockerfile_copy_3
COPY dockerfile_copy/kie-eap-distributions-bpms-layer-6.2.0-SNAPSHOT.zip /tmp/dockerfile_copy_3/kie-eap-distributions-bpms-layer-6.2.0-SNAPSHOT.zip

# Install the BPMSuite module layer.
RUN unzip -q /tmp/dockerfile_copy_3/kie-eap-distributions-bpms-layer-6.2.0-SNAPSHOT.zip -d /opt/jboss/jboss-eap-6.3/

# Install JBoss BPM-Suite
COPY dockerfile_copy/kie-eap-distributions-bpms-webapp-6.2.0-SNAPSHOT-kie-wb.war /opt/jboss/jboss-eap-6.3/standalone/deployments/kie-eap-distributions-bpms-webapp-6.2.0-SNAPSHOT-kie-wb.war
RUN touch /opt/jboss/jboss-eap-6.3/standalone/deployments/kie-eap-distributions-bpms-webapp-6.2.0-SNAPSHOT-kie-wb.war.dodeploy

# Create initial users.
RUN /opt/jboss/jboss-eap-6.3/bin/add-user.sh -a -r ApplicationRealm -u bpmsAdmin -p jboss@01 -ro admin,analyst,developer --silent

# Clean up. Need to change to root for now because Docker COPY copies files as root (this is likely gonna change in future versions, where Docker COPY will respect USER config.
USER root
RUN rm -rf /tmp/dockerfile_copy_3
USER jboss

#Start the container with standalone-full.xml profile as the BPMSuite deployment requires a default resource adapter.
CMD ["-c", "standalone-full.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

