# 
# Docker base image of JBoss BPMSuite 6.1.0
#
FROM duncandoyle/jboss-eap:7.0

MAINTAINER ddoyle <ddoyle@redhat.com>

ENV BRMS_VERSION_MAJOR 6
ENV BRMS_VERSION_MINOR 4
ENV BRMS_VERSION_MICRO 0
#ENV BRMS_VERSION_PATCH 0

ENV EAP_VERSION_MAJOR 7
ENV EAP_VERSION_MINOR 0

# Copy JBoss BPM-Suite
RUN mkdir /tmp/contrib
COPY contrib/jboss-brms-$BRMS_VERSION_MAJOR.$BRMS_VERSION_MINOR.$BRMS_VERSION_MICRO.GA-deployable-eap$EAP_VERSION_MAJOR.x.zip /tmp/contrib/jboss-brms-$BRMS_VERSION_MAJOR.$BRMS_VERSION_MINOR.$BRMS_VERSION_MICRO.GA-deployable-eap$EAP_VERSION_MAJOR.x.zip

#Install BPMSuite 
RUN /usr/bin/unzip -qo /tmp/contrib/jboss-brms-$BRMS_VERSION_MAJOR.$BRMS_VERSION_MINOR.$BRMS_VERSION_MICRO.GA-deployable-eap$EAP_VERSION_MAJOR.x.zip -d /opt/jboss

# Create initial users.
RUN /opt/jboss/jboss-eap-$EAP_VERSION_MAJOR.$EAP_VERSION_MINOR/bin/add-user.sh -a -r ApplicationRealm -u brmsAdmin -p jbossbrms1! -ro admin,analyst,developer,kiemgmt,plannermgmt --silent

# Clean up
USER root
# For one reason or the other, we need to delete this file first for the 'rm -rf' to work ... Got no idea why .....
#RUN rm /tmp/contrib/jboss-brms-$BRMS_VERSION_MAJOR.$EAP_VERSION_MINOR.$EAP_VERSION_MICRO.GA-deployable-eap$EAP_VERSION_MAJOR.x.zip
RUN rm -rf /tmp/contrib
USER jboss
