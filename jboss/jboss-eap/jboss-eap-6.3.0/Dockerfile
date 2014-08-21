#
# JBoss EAP 6.3.0 base-image.
#
FROM ddoyle/jboss_base

MAINTAINER ddoyle <ddoyle@redhat.com>

# Add installation files to tmp.
RUN mkdir /tmp/dockerfile_add
ADD . /tmp/dockerfile_add

# Unzip the JBoss EAP installation.
RUN unzip -q /tmp/dockerfile_add/jboss-eap-6.3.0.zip -d /opt/jboss

# Add a default admin user.
RUN /opt/jboss/jboss-eap-6.3/bin/add-user.sh admin jboss@01 --silent 

# Clean up.
RUN rm -rf /tmp/dockerfile_add

# Define the entrypoint and cmd.
ENTRYPOINT ["/opt/jboss/jboss-eap-6.3/bin/standalone.sh"]
CMD ["-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

EXPOSE 8080 9990 9999

