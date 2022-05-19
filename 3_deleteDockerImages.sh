#!/bin/bash
# author: Andre Rosa
# 18 JAN 2021
# objective: Stop and Erase all images, containers and volumes
# USE WITH CAUTION
#-----------------------------------------------------------------------------

# STOPS AND DELETES ALL CONTAINERS
docker container stop $(docker container ls -aq)
docker container rm $(docker container ls -aq)

# DELETE DOCKER NETWORK
docker network rm vubblenet

# PRUNE IMAGES, VOLUMES AND CONTAINERS
docker image prune -af
docker container prune -f
docker volume prune -f
