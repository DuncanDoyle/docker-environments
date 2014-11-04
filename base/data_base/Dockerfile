#
# Base image for all Docker data volume containers.
#
# This docker image uses CentOS 6 as the base OS (CentOS 7's systemd gives problems in a Docker environment atm),
#
FROM    centos:centos6

MAINTAINER ddoyle <ddoyle@redhat.com>

# Update the system.
RUN yum -y update && yum clean all

# Set root password
RUN echo "root:redhat" | chpasswd

CMD ["/bin/bash","-l"]
