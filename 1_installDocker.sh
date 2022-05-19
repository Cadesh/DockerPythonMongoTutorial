#!/bin/bash
# author: Andre Rosa
# 25 SEP 2021
# objective: Install Docker
#---------------------------------------------------------------------------

USER=$1 # CHANGE HERE FOR YOUR UBUNTU USER NAME

#-------------------------------------------------------
# INSTALL DOCKER
#-------------------------------------------------------
apt update
apt update -q

# install prerequisites
apt install apt-transport-https ca-certificates curl software-properties-common -y

# add key for docker repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add the repository to apt
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# ATTENTION: note the version "focal" for Ubuntu 20.04 

apt update

apt-cache policy docker-ce
apt install docker-ce -y
#-------------------------------------------------------

#-------------------------------------------------------
# ADD USER TO DOCKER GROUP (TO AVOID SUDO PASSWORD REQUESTS)
#-------------------------------------------------------
   groupadd docker
   gpasswd -a $USER docker
   newgrp docker 
   # for this step to work you must logoff