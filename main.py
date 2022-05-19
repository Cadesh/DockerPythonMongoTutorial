#------------------------------------------------------------------
"""
PYTHON DOCKER TUTORIAL
Objective: Deploy a Python App with Mongo in Docker containers.
Date: 18MAR2020
"""
#------------------------------------------------------------------

import pymongo 
from flask import Flask
import json

PORT = 8005
app = Flask(__name__)

myclient = pymongo.MongoClient("mongodb://mongo:27017") # NOTE: 'mongo' is the same name of our MongoDB container
# connect to database in Mongo
mydb = myclient["mydatabase"]
# create collection in Mongo
mycol = mydb["mycollection"]


#-------------------------------------------------------------------
def testingMongoConnection():
    """ Test function for MongoDB connection """

    # add data to collection
    mydict = {"name": "John Smith", "address": "Highway 37"}
    mycol.insert_one(mydict)
#-------------------------------------------------------------------

#-------------------------------------------------------------------
def recoverData():
    """ Get data from MongoDB collection """

    x = mycol.find_one({})
    print (x, flush=True)
    if x:
        return str(x)
    else:
        return "collection is empty"
    
#-------------------------------------------------------------------

#-------------------------------------------------------------------
def deleteData():
    """ Delete all data from MongoDB collection"""

    mycol.delete_many({})
#-------------------------------------------------------------------

#-------------------------------------------------------------------
def helloRoute():
    return "Hello from Python!"
#-------------------------------------------------------------------

#-------------------------------------------------------------------
def main():
    """ This is the main function """

    # FOR ROUTING WITH FLASK CHECK:
    # https://hackersandslackers.com/flask-routes/
    @app.route("/")
    def hello():
        return helloRoute()

    @app.route("/test")
    def test():
        testingMongoConnection()
        return "Data added to DB, Use Mongo-Express page to check!"
    
    @app.route("/recover")
    def recoverDataFromMongo():
        return recoverData()

    @app.route("/delete")
    def deleteDataInMongo():
        deleteData()
        return "Data deleted, check in Mongo-Express."

    if __name__ == "__main__":
        app.run(host="0.0.0.0", port=int(PORT), debug=True)   

#-------------------------------------------------------------------

#-------------------------------------------------------------------
main()
#-------------------------------------------------------------------

