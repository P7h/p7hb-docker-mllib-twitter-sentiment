## Introduction
This image facilitates the analyzing, processing and visualizing Twitter Sentiment using the following technologies:

* Scala
* Spark
* Spark MLlib
* Spark Streaming
* Spark SQL
* Stanford CoreNLP
* Redis
* D3.js
* Datamaps
* Flask


## Get this Docker image
There are 2 options for getting this image:

1. Build the image using [`Dockerfile`](Dockerfile)
2. Pull the image directly from DockerHub.

### Build Docker image
Copy the [`Dockerfile`](Dockerfile) and [`bootstrap.sh`](bootstrap.sh) to a folder on your local machine and then invoke the following command.


    docker build -t p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2 .


### Pull the image from Docker Hub


    docker pull p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2


## Run the image

    docker run -ti -p 4040:4040 -p 8080:8080 -p 8081:8081 -p 9999:9999 -h spark --name=spark p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2


The above step will launch and run the image with:

 * `root` user [as defined in the `Dockerfile`].
 * `spark` as host name.
 * `spark` as container name.
 * Exposes ports 4040, 8080, 8081 and 9999.

## Softwares and versions
This image is built on top of another image: [p7hb-docker-spark](https://hub.docker.com/r/p7hb/p7hb-docker-spark/), which contains Java, Scala, SBT and Apache Spark.

This Docker image adds and sets up the following to the above image.

 * Redis
 * Python
 * pip 
 * pip packages for Redis and Flask
 

## Prerequisites for successful execution

* We will need unfettered internet access for executing this project.
* Twitter App OAuth Credentials are mandatory. This is for retrieving tweets from Twitter in real-time.
* We will download ~1.5 GB of data with this image and SBT dependencies, etc and also tweets.
* A decent enough workstation allocating at least the following to the Docker-machine [actually the more, the merrier]:
	* 1.5 GB RAM
	* 2 CPUs
	* 10 GB free disk space

## Steps to execute the prototype
During the image building phase, a file `bootstrap.sh` is copied to the home folder of `root` user. 

When the image is executed for the first time, this particular file creates the required folder structure, completes the downloading, setting up the source code and the training dataset on the image.

This file also starts Spark Master and Spark Slave services on the image.

And finally, in a `screen` session, it triggers an app for the Visualization of Twitter Sentiment on a world map, which can be accessed on the host machine by launching the browser and pointing it to: [`http://192.168.99.100:9999/`](http://192.168.99.100:9999/).  


### Twitter App OAuth Credentials
The only manual step in this completely automated project is setting up a Twitter App and updating its Credentials to connect to Twitter Streaming API.

* Please check the [`application.conf`](src/main/resources/application.conf#L4-7) and add your own values and complete the integration of Twitter API to your application by looking at your values from [Twitter Developer Page](https://dev.twitter.com/apps).<br>
	* If you did not create a Twitter App before, then please create a new Twitter App where you will get all the required values of `application.conf` afresh and then populate them here without any mistake.<br> 

## Execute Spark job for creating the Naive Bayes Model
By invoking this step, we are triggering a Spark job for loading the training data to create a Naive Bayes Model for the training set. 

This Model will be used in the next step for predicting the sentiment of streaming tweets in real-time.

    cd /root/MLlibTweetSentimentAnalysis/
	sbt clean assembly
	cd /root/MLlibTweetSentimentAnalysis/target/scala-2.10/
	spark-submit --class "org.p7h.spark.sentiment.mllib.SparkNaiveBayesModelCreator" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1-SNAPSHOT.jar

## Execute Spark Streaming job for sentiment prediction

	cd /root/MLlibTweetSentimentAnalysis/target/scala-2.10/
	spark-submit --class "org.p7h.spark.sentiment.TweetSentimentAnalyzer" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1-SNAPSHOT.jar
