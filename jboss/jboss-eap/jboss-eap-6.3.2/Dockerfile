#
# JBoss EAP 6.3.0 base-image.
#
FROM ddoyle/jboss-eap:6.3.0

MAINTAINER ddoyle <ddoyle@redhat.com>

EXPOSE 8080 9990 9999

# Add installation files to tmp.
RUN mkdir /tmp/dockerfile_copy_2
COPY dockerfile_copy/ /tmp/dockerfile_copy_2

# Patch the EAP installation
RUN /tmp/dockerfile_copy_2/patch-jboss-eap.sh -j /opt/jboss/jboss-eap-6.3/ -p /tmp/dockerfile_copy/jboss-eap-6.3.2-patch.zip

# Clean up. Need to change to root for now because Docker COPY copies files as root (this is likely gonna change in future versions, where Docker COPY will respect USER config.
USER root
RUN rm -rf /tmp/dockerfile_copy_2
USER jboss

# Define the entrypoint and cmd.
ENTRYPOINT ["/opt/jboss/jboss-eap-6.3/bin/standalone.sh"]
CMD ["-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
