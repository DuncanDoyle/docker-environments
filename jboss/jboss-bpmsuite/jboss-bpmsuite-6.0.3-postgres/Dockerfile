#
# JBoss BPMSuite 6.0.2 image which uses PostgreSQL as datasource.
#
FROM ddoyle/jboss-bpmsuite-6.0.3_base

MAINTAINER ddoyle <ddoyle@redhat.com>

############################################
# Copy artifacts.
############################################
RUN mkdir /tmp/dockerfile_copy
COPY dockerfile_copy/ /tmp/dockerfile_copy

# Install the new layers, which in this case is the PostgresSQL layer.
# TODO: Find a cleaner way to add the postgres layer (probably using sed).
RUN cp -R /tmp/dockerfile_copy/layers/* /opt/jboss/jboss-eap-6.1/modules/system/layers && echo "layers=bpms,postgresql" > /opt/jboss/jboss-eap-6.1/modules/layers.conf

#Change the database dialect of the system from H2 to PostgreSQLDialect
RUN sed -i "s/org.hibernate.dialect.H2Dialect/org.hibernate.dialect.PostgreSQLDialect/" /opt/jboss/jboss-eap-6.1/standalone/deployments/business-central.war/WEB-INF/classes/META-INF/persistence.xml

# Configure the EAP installation
RUN /tmp/dockerfile_copy/setup-jboss-eap-profile.sh -j /opt/jboss/jboss-eap-6.1/ -s standalone.xml -t standalone-bpmsuite.xml -c /tmp/dockerfile_copy/cli-scripts

# There seems to be a filesystem bug in Docker, which causes the 'jboss' user not to be able to rename /opt/jboss/jboss-eap-6.2/standalone/configuration/standalone_xml_history/current.
# Therefore deleting the whole history directory.
RUN rm -rf /opt/jboss/jboss-eap-6.1/standalone/configuration/standalone_xml_history

# Set correct access rights (no longer needed when COPY sets file ownership to USER).
USER root
RUN chown -R jboss:jboss /opt/jboss/jboss-eap-6.1/modules/system/layers
RUN rm -rf /tmp/dockerfile_copy
USER jboss

# Entrypoint (i.e, standalone.sh) is defined in the base image. Here we just want to override the profile we wan
CMD ["-c", "standalone-bpmsuite.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

# Expose the debug port.
EXPOSE 8787 8001 9418
