#
# PostgreSQL image for JBoss BPMSuite.
#
FROM ddoyle/postgres-9.3_base

MAINTAINER ddoyle <ddoyle@redhat.com>

#############################################
# Create database for BPM-Suite usage
#############################################
RUN $PGINST/bin/pg_ctl start -w -D $PGDATA && \
    $PGINST/bin/psql --command "CREATE USER bpmsuite PASSWORD 'jboss@01';" && \
     $PGINST/bin/psql --command "CREATE DATABASE bpmsuite OWNER bpmsuite;" 


