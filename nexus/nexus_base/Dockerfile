#
# Base image for all jboss related docker images.
#
# This docker image uses CentOS 6 as the base OS (CentOS 7's systemd gives problems in a Docker environment atm), 
#
FROM    ddoyle/java_base:1.7

MAINTAINER ddoyle <ddoyle@redhat.com>


# User and group management. Create the (system) jboss user and group (including the jboss home dir). Set the jboss user's password. Set the root password.
#RUN groupadd -r jboss -g 433 && useradd -u 431 -r -m -g jboss -d /home/jboss -s /sbin/nologin -c "JBoss Docker image user" jboss && mkdir /home/jboss && chown -R jboss:jboss /home/jboss && echo "jboss:jboss" | chpasswd && echo "root:root" | chpasswd
RUN useradd -r -m  -s /sbin/nologin -c "Nexus user" -p nexus@01 nexus

# Create the directory for all JBoss product installations.
RUN mkdir /opt/nexus && chown nexus:nexus /opt/nexus

# Set user, workdir and HOME environment variable to the JBoss user.
USER nexus
WORKDIR /home/nexus
ENV HOME /home/nexus

CMD ["/bin/bash","-l"]
