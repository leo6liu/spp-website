#!/bin/sh

# file: spp_web_start.sh
#
# description...
#

# make sure this script is run as root
#
if (test ${EUID} -ne 0); then
    printf "$0: Error: Permission denied.\n"
    printf "Make sure this script is run as root.\n"
    exit 1
fi

# make sure dockerfile exists
#
if (test ! -r "Dockerfile"); then
    printf "$0: Error: No dockerfile found.\n"
    exit 1
fi

# build image from dockerfile
#
sudo docker build -t spp_webserver_image .

# start webserver
#  --detach  Run container in background and print container ID
#  --rm      Automatically remove the container when it exits
#  --publish Describe which port the container is listening on at runtime
#  --name    Assign a name to the container
#  --mount   Attach a filesystem mount to the container
#
sudo docker run \
     -d \
     --rm \
     -p 80:80 \
     --name spp_webserver \
     --mount type=bind,source=$(pwd)/src,target=/usr/share/nginx/html \
     spp_webserver_image

# exit normally
#
exit 0

#
# end of file
