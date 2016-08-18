## Introduction
This Docker image facilitates analyzing, processing and visualizing Twitter Sentiment using the following technologies:

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

## Softwares and versions
This Docker image is built on top of another image: [p7hb-docker-spark](https://hub.docker.com/r/p7hb/p7hb-docker-spark/), which contains Java, Scala, SBT and Apache Spark.

This image adds and sets up the following to the above image.

 * Redis
 * Python
 * pip 
 * pip packages for Redis and Flask
 

## Prerequisites for successful execution

* A decent machine in which you can allocate at least the following to the Docker-machine [actually the more, the merrier]:
	* 1.5 GB RAM
	* 2 CPUs
	* 6 GB free disk space
* We will need unfettered internet access for executing this project.
* Twitter App OAuth Credentials are mandatory. This is for retrieving tweets from Twitter in real-time.
* We will download ~1.5 GB of data with this image and SBT dependencies, etc and also tweets.


## Get this Docker image
There are 2 options for getting this image:

1. Build the image using Dockerfile
2. Pull the image directly from DockerHub

### Build Docker image
Copy the [`Dockerfile`](Dockerfile) and the other 2 supporting files: [`bootstrap.sh`](bootstrap.sh) and [`exec_spark_jobs.sh`](exec_spark_jobs.sh) to a folder on your local machine and then invoke the following command.


    docker build -t p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2 .

This will build a docker image on your machine.

Please wait as this might take a bit of time depending your internet speed.

### Pull the image from Docker Hub
With this approach, we are basically pulling the image hosted on Docker Hub directly instead of building it ourselves.

    docker pull p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2


## Run the image
This step will launch and run the image and after it completes the initial setup, you will land into a bash shell waiting for your input.

    docker run -ti -p 4040:4040 -p 8080:8080 -p 8081:8081 -p 9999:9999 -h spark --name=spark p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2

Please note the following:

 * `root` is the user we logged into.
 * `spark` is host name of this container. This is very important as Spark Slaves are started using this host name as the master.
 * `spark` is the container name.
 * Exposes ports 4040, 8080, 8081 for Spark Web UI console and 9999 for Twitter Sentiment Visualization.


## Steps to execute the prototype
During the image building phase, [`bootstrap.sh`](`bootstrap.sh`) shell script is copied to the home folder of `root` user. 

When the image is executed for the first time, this particular file creates the required folder structure, completes the downloading, setting up the source code and the training dataset on the image.

And finally, in a `screen` session, it triggers an app for the Visualization of Twitter Sentiment on a world map, which can be accessed on the host machine by launching the browser and pointing it to: [`http://192.168.99.100:9999/`](http://192.168.99.100:9999/).

Docker image also contains another shell script: [`exec_spark_jobs.sh`](exec_spark_jobs) is also copied to home directory of `root` user.

### Twitter App OAuth Credentials
The only manual intervention required in this project is setting up a Twitter App and updating its Credentials to connect to Twitter Streaming API.

* Please check the [`application.conf`](src/main/resources/application.conf#L7-10) and add your own values and complete the integration of Twitter API to your application by looking at your values from [Twitter Developer Page](https://dev.twitter.com/apps).
	* If you did not create a Twitter App before, then please create a new Twitter App on [Twitter Developer Page](https://dev.twitter.com/apps), where you will get all the required values of `application.conf` afresh and then populate them here without any mistake.<br>

## Execute Spark jobs for sentiment analysis
We can take one of these approaches to run the Spark jobs.

* Automated; using a shell script
* Manual steps

### Automated -- Use a shell script to run Spark jobs
Please execute [`exec_spark_jobs.sh`](exec_spark_jobs) on the console.

This script first starts Spark Master and Spark Slave and then launches the Spark jobs one after the other.

This might take sometime as SBT will initiate a download and setup of all the required packages from Maven Central Repo and Typesafe repo as required.

### Manual -- Start Spark Services and then execute Spark jobs individually
#### Start Spark Master
$SPARK_HOME/sbin/start-master.sh

#### Start Spark Slave
$SPARK_HOME/sbin/start-slave.sh spark://spark:7077

#### Execute Spark job for creating the Naive Bayes Model
By invoking this step, we are triggering a Spark job for loading the training data to create a Naive Bayes Model for the training set. 

This Model will be used in the next step for predicting the sentiment of streaming tweets in real-time.

    cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/
	sbt clean assembly
	cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/target/scala-2.10/
	spark-submit --class "org.p7h.spark.sentiment.mllib.SparkNaiveBayesModelCreator" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar

#### Execute Spark Streaming job for sentiment prediction

	cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/target/scala-2.10/
	spark-submit --class "org.p7h.spark.sentiment.TweetSentimentAnalyzer" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar

## Visualization app
After a few minutes of launching Spark jobs, point your browser on the host machine to [`http://192.168.99.100:9999/`](http://192.168.99.100:9999/) to view the Twitter Sentiment visualized on a world map.

Hover over a bubble to see additional info about that data point.


## License
Copyright &copy; 2016 Prashanth Babu.<br>
Licensed under the [Apache License, Version 2.0](LICENSE).
