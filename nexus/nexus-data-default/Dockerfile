#
# Base image for all Docker data volume containers.
#
# This docker image uses CentOS 6 as the base OS (CentOS 7's systemd gives problems in a Docker environment atm),
#
FROM    ddoyle/data_base:1.0.0

MAINTAINER ddoyle <ddoyle@redhat.com>

# Create a user in our data-volume so we can correctly map access rights.
RUN useradd -r -m  -s /sbin/nologin -c "Nexus image user" -p nexus@01 nexus

RUN mkdir -p /data/nexus/sonatype-work/storage && chown -R nexus:nexus /data/nexus
USER nexus 

# Data volume for the nexus-repo's
VOLUME ["/data/nexus/sonatype-work/storage"]


