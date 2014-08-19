#
# JBoss EAP 6.1.1 base-image.
#
FROM    ddoyle/jboss_base

MAINTAINER ddoyle <ddoyle@redhat.com>

# Add installation files to tmp.
RUN mkdir /tmp/dockerfile_add
ADD . /tmp/dockerfile_add

# Unzip the JBoss EAP installation
RUN unzip -q /tmp/dockerfile_add/jboss-eap-6.1.1.zip -d /opt/jboss

#Add a default admin user.
RUN /opt/jboss/jboss-eap-6.1/bin/add-user.sh admin jboss@01 --silent 

#Clean Up
RUN rm -rf /tmp/dockerfile_add

ENTRYPOINT ["/opt/jboss/jboss-eap-6.1/bin/standalone.sh"]
CMD ["-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
#CMD $HOME/eap/jboss-eap-6.1/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

EXPOSE 8080 9990 9999

