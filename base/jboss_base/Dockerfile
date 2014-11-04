#
# Base image for all jboss related docker images.
#
# This docker image uses CentOS 6 as the base OS (CentOS 7's systemd gives problems in a Docker environment atm), 
#
FROM    centos:centos6

MAINTAINER ddoyle <ddoyle@redhat.com>

# Update the system.
RUN yum -y update && yum clean all

# Set root password
RUN echo "root:redhat" | chpasswd

#Install necessary RPMs, i.e. the JVM and unzip. A JVM is required for all JBoss docker images.
RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel unzip && yum clean all

# Set the JAVA_HOME environment variable.
ENV JAVA_HOME /usr/lib/jvm/jre

# User and group management. Create the (system) jboss user and group (including the jboss home dir). Set the jboss user's password. Set the root password.
#RUN groupadd -r jboss -g 433 && useradd -u 431 -r -m -g jboss -d /home/jboss -s /sbin/nologin -c "JBoss Docker image user" jboss && mkdir /home/jboss && chown -R jboss:jboss /home/jboss && echo "jboss:jboss" | chpasswd && echo "root:root" | chpasswd
RUN useradd -r -m  -s /sbin/nologin -c "JBoss Docker image user" -p jboss@01 jboss

# Create the directory for all JBoss product installations.
RUN mkdir /opt/jboss && chown jboss:jboss /opt/jboss

# Set user, workdir and HOME environment variable to the JBoss user.
USER jboss
WORKDIR /home/jboss
ENV HOME /home/jboss

CMD ["/bin/bash","-l"]
