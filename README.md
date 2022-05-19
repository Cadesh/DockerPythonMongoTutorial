# Python Docker Tutorial #

## About

A simple Python App connecting to MongoDB with Docker Containers.


---

# 1 - Installing Docker

Run the script *1_installDocker.sh* with the parameter *user name* for your Ubuntu user

``` bash 1_installDocker.sh <user name> ``` 

---

# 2 - Creating a Docker Network for our containers

``` docker network create -d bridge vubblenet ```

---

# 3 - Deploying MongoDB

Deploy a MongoDB container direclty from DockerHub. (https://hub.docker.com/_/mongo)

``` docker run --network=vubblenet -p 127.0.0.1:27018:27017 --name mongo -d mongo:4.4-focal ```

Note that *focal* is the optimal for Ubuntu 20.04 (for Ubuntu 18.04 use mongo:4.2.3-bionic)

The parameter *-p 127.0.0.1:27018:27017* is meant to forbid external accesses to mongo (improved security)

Note the *--network* parameter ordering the container to run in the network defined in step 2. 

To access MongoDB container

``` docker exec -it mongo bash ```

then type ```mongo``` for CLI and issue commands in terminal like ```show dbs``` to list databases.

Note that this mongo container does not have an attached volume, therefore all data will be lost if the container is deleted.

To check is the container is running use command **docker ps**

---

# 4 - Deploying Mongo-Express 

Mongo-Express is a user friendly web interface for MongoDB. (https://hub.docker.com/_/mongo-express)

Deploy Mongo-Express directly from DockerHub

``` docker run --network=vubblenet -e ME_CONFIG_MONGODB_SERVER=mongo -p 8081:8081 --name mongo-express -d mongo-express ```

Mongo-Express can be accessed form the browser in http://host-ip:8081

To check is the container is running use command **docker ps**

---

# 5 - Deploying Python App

1 - From the app folder (the folder where the Dockerfile is located), build a local image named myapp_img:

``` docker build -t myapp_img . ```

The above command executes the Dockerfile to build the image for the Python App. 

2 - Launch myapp container with name myapp_ctn:

``` docker run --network=vubblenet -p 8005:8005 --name myapp_ctn -d myapp_img ```

To check is the container is running use command **docker ps**

MyApp has the following routes in the host *http://localhost:8005*:

*http://localhost:8005/test* - add a document named "John Smith" to MongoDB 

*http://localhost:8005/recover* - returns the added document

*http://localhost:8005/delete* - delete all documents in the collection

Use Mongo-Express to check the database updates in *mydatabase*


If you already have a container with the same name it is necessary to stop/remove the container with:

``` docker stop myapp_ctn ```

``` docker rm myapp_ctn ```

---

# 6 - Additional Docker commands

List local images: ``` docker image ls ```

List all containers (including stopped ones): ``` docker container ls -a ```

Stop all containers: ``` docker container stop $(docker container ls -aq) ```

Delete all containers: ``` docker container rm $(docker container ls -aq) ```

Delete all images: ``` docker system prune -a -f ```

Run a new container in bash mode: ``` docker container run --rm -it <image name> sh ```

Follow Logs in container ``` docker logs -f <container name> ```

---

# 7 - Cleaning Up

If you want to delete all container/images run scripts 2 and 3

---

# 8 - The easy way

If you already installed Docker (script 1_installDocker.sh)
You can deploy everything automatically with script **4_launchApp.sh**

``` bash 4_launchApp.sh ```
