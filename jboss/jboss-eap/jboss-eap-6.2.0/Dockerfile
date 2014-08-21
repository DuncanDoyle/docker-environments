#
# JBoss EAP 6.2.0 base-image.
#
FROM ddoyle/jboss_base

MAINTAINER ddoyle <ddoyle@redhat.com>

EXPOSE 8080 9990 9999

# Add installation files to tmp.
RUN mkdir /tmp/dockerfile_copy
COPY ./dockerfile_copy/ /tmp/dockerfile_copy

# Unzip the JBoss EAP installation.
RUN unzip -q /tmp/dockerfile_copy/jboss-eap-6.2.0.zip -d /opt/jboss

# Add a default admin user.
RUN /opt/jboss/jboss-eap-6.2/bin/add-user.sh admin jboss@01 --silent 

# Patch the EAP installation
RUN /tmp/dockerfile_copy/patch-jboss-eap.sh -j /opt/jboss/jboss-eap-6.2/ -p /tmp/dockerfile_copy/jboss-eap-6.2.4-patch.zip

# Configure the EAP installation
RUN /tmp/dockerfile_copy/setup-jboss-eap-profile.sh -j /opt/jboss/jboss-eap-6.2/ -s standalone.xml -t standalone-docker.xml -c /tmp/dockerfile_copy/cli-scripts

# There seems to be a filesystem bug in Docker, which causes the 'jboss' user not to be able to rename /opt/jboss/jboss-eap-6.2/standalone/configuration/standalone_xml_history/current.
# Therefore deleting the whole history directory.
RUN rm -rf /opt/jboss/jboss-eap-6.2/standalone/configuration/standalone_xml_history

# Clean up. Need to change to root for now because Docker COPY copies files as root (this is likely gonna change in future versions, where Docker COPY will respect USER config.
USER root
RUN rm -rf /tmp/dockerfile_copy
USER jboss

# Define the entrypoint and cmd.
ENTRYPOINT ["/opt/jboss/jboss-eap-6.2/bin/standalone.sh"]
CMD ["-c", "standalone-docker.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
