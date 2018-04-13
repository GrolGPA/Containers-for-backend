#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo"
    exit 1
fi 

#Install docker & docker-compose
apt-get install && sudo apt-get install docker docker-compose docker.io
#Add user to group docker:
usermod -a -G docker $SUDO_USER

#Create network:
docker network create front


#Add to /etc/hosts
cp /etc/hosts /etc/hosts.bak
DOCKER_IP=`ifconfig docker0 | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
echo "$DOCKER_IP  backend.net" >> /etc/hosts
echo "$DOCKER_IP  db.backend.net" >> /etc/hosts

su $SUDO_USER:
#Starting container: 
#echo "Starting Docker containers..."
#docker-compose -p backend up -d --build

chown $SUDO_USER: -R ./
echo "To use the Docker under a local user, you must re-log in"
echo "For the first run, use command: docker-compose up -d --build"
echo "To stop containers, enter command: docker-compose down"
echo "Start the containers with the command: docker-compose up -d"
