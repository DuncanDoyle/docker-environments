#!/bin/sh
#
# This scripts is used in our Nexus Docker containers to scan for any json files with a request to configure a new repository on the Nexus server.
#
# The main idea is that our nexus-data container, from which we mount the volume in our nexus-server containet, contains these json files. When we start our nexus container,
# we first wait until the nexus repo is available (we check whether the REST API is available). Next, we search the $JSON_ADD_REPO_REQUESTS_DIR for JSON request files to fire
# against the Nexus REST API to add repositories.
#
# Finally, we add all repositories to the 'public' group of Nexus so we can actually access them via the public repository URL.
#
# This allows us to plugin new data-containers with new Maven repo's without altering the nexus-server container. Also, it allows us to upgrade the nexus-server container, without 
# having to rebuild the data-container.

# TODO: We might want to check which scripts we've already executed (we keep a small cache in our container). This would allow us to control not to run scripts twice if we re-use the container.
# (in docker-compose, containers are always rebuild, so we won't have that problem, but this is to support additional use-cases as well).
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
ADD_REPOS_TO_PUBLIC_GROUP_FILE="add_repos_to_public.txt"
if [ ! -z "$JSON_ADD_REPO_REQUESTS_DIR" ]
then
# Now that the system is running, we can run our CLI scripts. They will be executed in the order defined by 'sort -V'
#        for f in `ls $JSON_ADD_REPO_REQUESTS_DIR/*.json | sort`
	echo "Configuring additional Maven repositories."

	for f in `find $JSON_ADD_REPO_REQUESTS_DIR -type f -name "*_add_request.json"`
        do
                echo "Calling Nexus REST API. Adding repositories. JSON request file: " $f
		curl -i -H "Accept: application/json" -H "Content-Type: application/json" -f -X POST  -v -d "@$f" -u "admin:admin123" "http://localhost:8081/nexus/service/local/repositories"
		# We now add the ID of the repo to a temp file so we can add the repo automatically to the 'public' group of Nexus.
		cat $f | /usr/local/bin/jq ".data.id" >> $ADD_REPOS_TO_PUBLIC_GROUP_FILE
        done
fi

# We now parse our temp file with repo IDs and configure the Nexus public repo.
echo "Adding new repositories to Nexus public group."
UPDATE_PUBLIC_GROUP_JSON="update-public-group.json"

echo '{"data":
        {"id":"public",
        "name":"Public Repositories",
        "format":"maven2",
        "exposed":true,
        "provider":"maven2",
        "repositories":[
                {"id":"releases"},
                {"id":"snapshots"},
                {"id":"thirdparty"},
                {"id":"central"}' > $UPDATE_PUBLIC_GROUP_JSON

while read repo
do
   echo "               ,{\"id\": $repo}" >> $UPDATE_PUBLIC_GROUP_JSON
done < $ADD_REPOS_TO_PUBLIC_GROUP_FILE

echo '  ]}
}' >> $UPDATE_PUBLIC_GROUP_JSON

#Execute this REST call to update the public group:
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -f -X PUT  -v -d "@$UPDATE_PUBLIC_GROUP_JSON" -u "admin:admin123" "http://localhost:8081/nexus/service/local/repo_groups/public"

#And remove the temp file with repo's.
#rm $UPDATE_PUBLIC_GROUP_JSON && rm $ADD_REPOS_TO_PUBLIC_GROUP_FILE

echo -e "\n\nDone"
