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

CMD ["/bin/bash","-l"]
