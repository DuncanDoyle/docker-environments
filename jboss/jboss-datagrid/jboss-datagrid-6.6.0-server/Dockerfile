#
# JBoss Data Grid Server 6.6.0.
#
FROM ddoyle/jboss_base:1.0.0

MAINTAINER ddoyle <ddoyle@redhat.com>

EXPOSE 8080 9990 9999 11222

# Add installation files to tmp.
RUN mkdir /tmp/dockerfile_copy
COPY ./dockerfile_copy/ /tmp/dockerfile_copy

# Unzip the JBoss JDG installation.
RUN unzip -q /tmp/dockerfile_copy/jboss-datagrid-6.6.0-server.zip -d /opt/jboss

# Add a default admin user.
RUN /opt/jboss/jboss-datagrid-6.6.0-server/bin/add-user.sh admin jboss@01 --silent 

# Patch the JDG installation
#RUN /tmp/dockerfile_copy/patch-jboss-eap.sh -j /opt/jboss/jboss-datagrid-6.3.0-server/ -p /tmp/dockerfile_copy/jboss-eap-6.2.4-patch.zip

# Configure the JDG installation
RUN /tmp/dockerfile_copy/setup-jboss-datagrid-profile.sh -j /opt/jboss/jboss-datagrid-6.6.0-server/ -s standalone.xml -t docker-standalone.xml -c /tmp/dockerfile_copy/cli-scripts

# There seems to be a filesystem bug in Docker, which causes the 'jboss' user not to be able to rename /opt/jboss/jboss-eap-6.2/standalone/configuration/standalone_xml_history/current.
# Therefore deleting the whole history directory.
RUN rm -rf /opt/jboss/jboss-eap-6.6.0-server/standalone/configuration/standalone_xml_history

# Clean up. Need to change to root for now because Docker COPY copies files as root (this is likely gonna change in future versions, where Docker COPY will respect USER config.
USER root
RUN rm -rf /tmp/dockerfile_copy
USER jboss

# Define the entrypoint and cmd.
ENTRYPOINT ["/opt/jboss/jboss-datagrid-6.6.0-server/bin/standalone.sh"]
CMD ["-c", "docker-standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
