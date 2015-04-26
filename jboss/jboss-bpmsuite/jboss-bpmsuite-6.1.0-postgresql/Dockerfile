#
# JBoss BPMSuite 6.1.0 image which uses PostgreSQL as datasource.
#
FROM ddoyle/jboss-bpmsuite:6.1.0

MAINTAINER ddoyle <ddoyle@redhat.com>

############################################
# Copy artifacts.
############################################
RUN mkdir /tmp/dockerfile_copy
COPY dockerfile_copy/ /tmp/dockerfile_copy

# Install the new layers, which in this case is the PostgresSQL layer.
# TODO: Find a cleaner way to add the postgres layer (probably using sed).
RUN cp -R /tmp/dockerfile_copy/layers/* /opt/jboss/jboss-eap-6.4/modules/system/layers && echo "layers=base,postgresql" > /opt/jboss/jboss-eap-6.4/modules/layers.conf

#Change the database dialect of the system from H2 to PostgreSQLDialect
RUN sed -i "s/org.hibernate.dialect.H2Dialect/org.hibernate.dialect.PostgreSQLDialect/" /opt/jboss/jboss-eap-6.4/standalone/deployments/business-central.war/WEB-INF/classes/META-INF/persistence.xml

# Configure the EAP installation
# There seems to be a filesystem bug in Docker, which causes the 'jboss' user not to be able to rename /opt/jboss/jboss-eap-6.2/standalone/configuration/standalone_xml_history/current.
# Therefore deleting the whole history directory after we've configured our profile.
RUN /tmp/dockerfile_copy/setup-jboss-eap-profile.sh -j /opt/jboss/jboss-eap-6.4/ -s standalone.xml -t bpmsuite-standalone.xml -c /tmp/dockerfile_copy/cli-scripts && rm -rf /opt/jboss/jboss-eap-6.4/standalone/configuration/standalone_xml_history

# Set correct access rights (no longer needed when COPY sets file ownership to USER).
USER root
RUN chown -R jboss:jboss /opt/jboss/jboss-eap-6.4/modules/system/layers
RUN rm -rf /tmp/dockerfile_copy
USER jboss

# Entrypoint (i.e, standalone.sh) is defined in the base image. Here we just want to override the profile we wan
CMD ["-c", "bpmsuite-standalone.xml", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
