#!/bin/bash


#Install docker & docker-compose
sudo apt-get install && sudo apt-get install docker docker-compose
#Add user to group docker:
sudo usermod -a -G docker $SUDO_USER

#Create network:
sudo docker network create front
  
  
#Add to /etc/hosts 
sudo cp /etc/hosts /etc/hosts.bak
DOCKER_IP=`ifconfig docker0 | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`
sudo echo "$DOCKER_IP  backend.net" >> /etc/hosts
sudo echo "$DOCKER_IP  db.backend.net" >> /etc/hosts

  
#Starting container: 
echo "Starting Docker containers..."
docker-compose -p backend up -d --build

echo "To stop containers, enter command: docker-compose down"
echo "Start the containers with the command:docker-compose up -d"
