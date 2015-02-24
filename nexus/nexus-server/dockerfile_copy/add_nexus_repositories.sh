#!/bin/sh
#
# This scripts is used in our Nexus Docker containers to scan for any json files with a request to configure a new repository on the Nexus server.
#
# The main idea is that our nexus-data container, from which we mount the volume in our nexus-server containet, contains these json files. When we start our nexus container,
# we first wait until the nexus repo is available (we check whether the REST API is available), next we check which scripts we've already executed (we keep a small cache in our container).
# This allows us to control not to run scripts twice if we re-use the container (in docker-compose, containers are always rebuild, so we won't have that problem, but this
# is to support additional use-cases as well).
#
# This allows us to plugin new data-containers with new Maven repo's without altering the nexus-server container. Also, it allows us to upgrade the nexus-server container, without 
# having to rebuild the data-container.
#
# author: ddoyle@redhat.com
#
# Source function library.
if [ -f /etc/init.d/functions ]
then
        . /etc/init.d/functions
fi

function usage {
      echo "Usage: add_nexus_repositories.sh [args...]"
      echo "where args include:"
      echo "    -r              Directory with the JSON requests."
}

#Parse the params
while getopts ":r:h" opt; do
  case $opt in
    r)
      JSON_ADD_REPO_REQUESTS_DIR=$OPTARG
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

PARAMS_NOT_OK=false

#Check params
if [ -z "$JSON_ADD_REPO_REQUESTS_DIR" ]
then
        echo "No directory with JSON requests specified."
        PARAMS_NOT_OK=true
fi

if $PARAMS_NOT_OK
then
        usage
        exit 1
fi



STARTUP_WAIT=60

#First check if the Nexus REST API is available. We'll wait for 60 seconds
count=0
launched=false
until [ $count -gt $STARTUP_WAIT ]
do
  curl --output /dev/null --silent --head --fail http://localhost:8081/nexus/service/local/repositories
  if [ $? -eq 0 ] ; then
    echo "Nexus REST API started."
    launched=true
    break
  fi
  printf '.'
  sleep 5
  let count=$count+5;
done

#Check that the platform has started, otherwise exit.
if [ $launched = "false" ]
then
  echo "Nexus did not start correctly. Exiting."
  exit 1
else
  echo "Nexus started."
fi

# Now, loop through all the JSON files that we want to execute against the repo.
if [ ! -z "$JSON_ADD_REPO_REQUESTS_DIR" ]
then
# Now that the system is running, we can run our CLI scripts. They will be executed in the order defined by 'sort -V'
        for f in `ls $JSON_ADD_REPO_REQUESTS_DIR/*.json | sort`
        do
                echo "Calling Nexus REST API. Adding repositories. JSON request file: " $f
		curl -i -H "Accept: application/json" -H "Content-Type: application/json" -f -X POST  -v -d "@$f" -u "admin:admin123" "http://localhost:8081/nexus/service/local/repositories"			
        done
fi

echo -e "\n\nDone"
