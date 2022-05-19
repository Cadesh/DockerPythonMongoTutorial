#!/bin/bash
# author: Andre Rosa
# 24 MAR 2020
# objective: Launch all containers
# Docker must be installed to work 
#---------------------------------------------------------------------------

#0. Stop/Remove previous MyApp containers
docker stop myapp_ctn
docker rm myapp_ctn

#1. Create Docker Network if not exists
docker network create -d bridge vubblenet || true

#2. Deploy MongoDB if not deployed
docker run --network=vubblenet -p 127.0.0.1:27018:27017 --name mongo -d mongo:4.4-focal  || true

#3. Deploy Mongo-Express if not deployed
docker run --network=vubblenet -e ME_CONFIG_MONGODB_SERVER=mongo -p 8081:8081 --name mongo-express -d mongo-express  || true

#4. Build Python app MyApp
docker build -t myapp_img .

#5. Deploy MyApp Container
docker run --network=vubblenet -p 8005:8005 --name myapp_ctn -d myapp_img