#
# JBoss EAP 6.3.0 base-image.
#
FROM ddoyle/nexus_base:1.0.0

MAINTAINER ddoyle <ddoyle@redhat.com>

EXPOSE 8081

# Add installation files to tmp.
RUN mkdir /tmp/dockerfile_copy
COPY dockerfile_copy/ /tmp/dockerfile_copy

# Unzip the JBoss EAP installation.
RUN unzip -q /tmp/dockerfile_copy/nexus-2.11.1-01-bundle.zip -d /opt/nexus && cp /tmp/dockerfile_copy/add_nexus_repositories.sh /home/nexus/add_nexus_repositories.sh \ 
	&& cp /tmp/dockerfile_copy/startNexusAndConfigure.sh /home/nexus/startNexusAndConfigure.sh


# Clean up. Need to change to root for now because Docker COPY copies files as root (this is likely gonna change in future versions, where Docker COPY will respect USER config.
USER root
RUN mkdir -p /data/nexus/sonatype-work && chown -R nexus:nexus /data/nexus
RUN rm -rf /tmp/dockerfile_copy
USER nexus

# We map this to a data-container in our docker-compose.yml
ENV NEXUS_HOME /opt/nexus/nexus-2.11.1-01
ENV NEXUS_WORK /data/nexus/sonatype-work

# Define the entrypoint and cmd.
#ENTRYPOINT ["/opt/nexus/nexus-2.11.1-01/bin/nexus"]
#CMD ["console"]
ENTRYPOINT ["/home/nexus/startNexusAndConfigure.sh"]

