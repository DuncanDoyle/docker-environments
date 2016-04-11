
# Base image for all JBoss related docker images.
#
# This images uses CentOS7 and Java 8.
#
FROM    centos:centos7

MAINTAINER ddoyle <ddoyle@redhat.com>

# Update the system.
RUN yum -y update && yum clean all

# Set root password
RUN echo "root:redhat" | chpasswd

#Install necessary RPMs, i.e. the JVM and unzip. A JVM is required for all JBoss docker images.
RUN yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel unzip && yum clean all

# Set the JAVA_HOME environment variable.
ENV JAVA_HOME /usr/lib/jvm/jre

CMD ["/bin/bash","-l"]
