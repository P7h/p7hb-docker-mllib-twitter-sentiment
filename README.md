# Visualization of Twitter Sentiment using Spark MLlib


## Introduction
Docker image facilitating analysis, processing and visualizing Twitter Sentiment using Spark MLlib for ["Spark-MLlib-Twitter-Sentiment-Analysis" project hosted on GitHub](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis).

Please check ["Spark-MLlib-Twitter-Sentiment-Analysis" README](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/blob/master/README.md) of the GitHub project or the [blogpost](http://P7h.org) for more info.

Docker Image is hosted on [Docker Hub](https://hub.docker.com/r/p7hb/p7hb-docker-mllib-twitter-sentiment); while the code for the accompanying project is hosted on [GitHub](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis).

Dockerfile and other supporting files are also [hosted](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment) on GitHub.


## Twitter Sentiment Visualization Demo
### Demo of Visualization
![Demo of Twitter Sentiment Visualization](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/Twitter_Sentiment_Visualization.gif)

### Screenshot of Visualization
![Screenshot of Twitter Sentiment Visualization](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/Twitter_Sentiment_Visualization.png)


## Softwares and versions
This Docker image is built on top of another image: [p7hb-docker-spark](https://hub.docker.com/r/p7hb/p7hb-docker-spark/), which contains OpenJDK, Scala, SBT and Apache Spark.

This image adds and sets up the following to the above image.

 * Redis
 * Python
 * pip 
 * pip packages for Redis and Flask
 
 Following is the complete list of languages, libraries and components used in this project.

0. OpenJDK 64-Bit v1.8.0_102 » Java for compiling and execution
1. Scala v2.10.6 » basic infrastructure and Spark jobs
2. SBT v0.13.12 » build file for scala code
3. Apache Spark v1.6.2
	* Spark Streaming » connecting to Twitter and streaming the tweets
	* Spark MLlib » creating a ML model and predicting the sentiment of tweets based on the text
	* Spark SQL » saving tweets [both raw and classified]
4. Stanford CoreNLP v3.6.0 » alternative mechanism to find sentiment of tweets based on the text
5. Redis » publishing classified tweets, subscribed by the front-end app to render the chart
6. Datamaps » charting and visualization
7. Python » running the flask app for rendering the front-end
8. Flask » rendering the template for front-end


## Prerequisites for successful execution

* A decent machine in which you can allocate at least the following to the Docker-machine [actually the more, the merrier]:
	* 2 GB RAM
	* 2 CPUs
	* 6 GB free disk space
* We will need unfettered internet access for executing this project.
* Twitter App OAuth credentials are mandatory. This is for retrieving tweets in real-time using Twitter Streaming API.
* We will download ~1.5 GB of data with this image and SBT dependencies, etc and streaming tweets too.

### Resources for the Docker machine
* Stop docker-machine.

	`docker-machine stop default`

* Launch Virtual Box and click on settings of `default` instance, which should be in `Powered Off` state.
* Fix the settings as highlighted in the screenshots below. Please note this is minimum required config; you might want to allocate more.

* Increase RAM of the VM
![Docker Machine RAM](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/Docker_Machine__RAM.png)

* Increase # of CPUs of the VM
![Docker Machine CPU](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/Docker_Machine__CPU.png)

* Relaunch docker after modifying the settings.
* Any Docker image you create now will have 2 GB RAM and 2 CPUs allocated.
	* Or the resources you allocated earlier.


## Get this Docker image
There are 2 options for getting this image:

1. Build the image using Dockerfile
2. Pull the image from DockerHub

### Build Docker image
Copy the [`Dockerfile`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/Dockerfile) and the other 2 supporting files: [`bootstrap.sh`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/bootstrap.sh) and [`exec_spark_jobs.sh`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/exec_spark_jobs.sh) to a folder on your local machine and then invoke the following command.

    docker build -t p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2 .

This will build the docker image on your machine.

Please wait as this might take a bit of time depending on your internet speed.

### Pull the image from Docker Hub
With this approach, we are pulling the image hosted on Docker Hub instead of building it ourselves.

    docker pull p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2


## Run the image
This step will launch and run the image and after it completes the setup process, you will land into a bash shell waiting for your input. If the image is not already present, this statement will download it from Docker Hub or uses the build already present on the local machine.

    docker run -ti -p 4040:4040 -p 8080:8080 -p 8081:8081 -p 9999:9999 -h spark --name=spark p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2

Please note the following:

 * `root` is the user we logged into.
 * `spark` is the container name.
 * `spark` is host name of this container. 
 	* This is very important as Spark Slaves are started using this host name as the master.
 * Exposes ports 4040, 8080, 8081 for Spark Web UI console and 9999 for Twitter Sentiment Visualization.


## Steps to execute the prototype
During the image building phase, [`bootstrap.sh`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/bootstrap.sh) shell script is copied to the home folder of `root` user. 

When the image is executed for the first time, this particular file creates the required folder structure, completes the downloading, setting up the source code and the training dataset on the image.

And finally, in a `screen` session, it triggers an app for the Visualization of Twitter Sentiment on a world map, which can be accessed on the host machine by launching the browser and pointing it to: [`http://192.168.99.100:9999/`](http://192.168.99.100:9999/).

Docker image also contains another shell script: [`exec_spark_jobs.sh`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/exec_spark_jobs.sh) is also copied to home directory of `root` user.

### Twitter App OAuth credentials
The only manual intervention required in this project is setting up a Twitter App and updating its credentials to connect to Twitter Streaming API. Please note that this is a critical step and without this, Spark will not be able to connect to Twitter or retrieve tweets with Twitter Streaming API and so, the visualization will be empty basically without any data.

* Please check the [`application.conf`](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/blob/master/src/main/resources/application.conf#L7-10) and add your own values and complete the integration of Twitter API to your application by looking at your values from [Twitter Developer Page](https://dev.twitter.com/apps).
	* If you did not create a Twitter App before, then please create a new Twitter App on [Twitter Developer Page](https://dev.twitter.com/apps), where you will get all the required values of `application.conf` and then populate them here.


## Execute Spark jobs for sentiment analysis
We can take one of the following 2 approaches to run the Spark jobs.

* Automated mechanism
* Manual steps

### Automated mechanism -- Use a shell script to run Spark jobs
Just to remind, before executing this step and further, please ensure that you have updated Twitter App OAuth credentials in [`application.conf`](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/blob/master/src/main/resources/application.conf#L7-10).

Please execute [`exec_spark_jobs.sh`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/exec_spark_jobs.sh) on the console.

This script first starts Spark Master and Spark Slave and then launches the Spark jobs one after the other.

This might take sometime as SBT will initiate a download and setup of all the required packages from Maven Central Repo and Typesafe repo as required.

### Manual -- Start Spark Services and then execute Spark jobs individually
#### Start Spark Master

	$SPARK_HOME/sbin/start-master.sh

#### Start Spark Slave

	$SPARK_HOME/sbin/start-slave.sh spark://spark:7077

#### Execute Spark job for creating the Naive Bayes Model
By invoking this step, we are triggering a Spark job for loading the training data to create a Naive Bayes Model for the training set.

    cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/
	sbt clean assembly
	cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/target/scala-2.10/
	spark-submit --class "org.p7h.spark.sentiment.mllib.SparkNaiveBayesModelCreator" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar

This Model will be used in the next step for predicting the sentiment of streaming tweets in real-time.

Build might take a bit of time depending on your internet speed, as SBT will initiate a download and setup of all the required packages from Maven Central Repo and Typesafe repo as required.

#### Execute Spark Streaming job for sentiment prediction
Just to remind, before executing this step and further, please ensure that you have updated Twitter App OAuth credentials in [`application.conf`](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/blob/master/src/main/resources/application.conf#L7-10).

	cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/target/scala-2.10/
	spark-submit --class "org.p7h.spark.sentiment.TweetSentimentAnalyzer" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar


## Visualization app
After a few minutes of launching Spark jobs, point your browser on the host machine to [`http://192.168.99.100:9999/`](http://192.168.99.100:9999/) to view Twitter Sentiment visualized on a world map.

Hover over a bubble to see additional info about that data point.


## TODO
* TBD
* Visualization could be completely scrapped for something better and UX needs a lot of uplifting.
* Use Spark wrapper for [Stanford CoreNLP](https://spark-packages.org/package/databricks/spark-corenlp) and reduce the boilerplate code further.
* Add or update comments in the code where necessary.
* Update the project to Spark v2.0.
	* Push out RDDs and use `org.apache.spark.ml` package; hello DataFrames and Datasets!


## Expert Mode execution steps
This is a very quick summary of the steps required for execution of this code.

Please consider these steps only if you are an expert on Docker, Spark and ecosystem of this project and understand clearly what is being done here.

* Install and launch Docker.
* Stop Docker and in the Virtual Box GUI, increase RAM of Docker machine [instance named `default` and should be in `Powered Off` state] to at least 2 GB [or more] and # of CPUs to 2 [or more].
* Start Docker again.
* Pull the project Docker image and launch it.
	* Might have to wait for ~10 minutes or so [depending on your internet speed].

	`docker run -ti -p 4040:4040 -p 8080:8080 -p 8081:8081 -p 9999:9999 -h spark --name=spark p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2`

* Update `/root/Spark-MLlib-Twitter-Sentiment-Analysis/src/main/resources/application.conf` to include your Twitter App OAuth credentials.
* Execute: `/root/exec_spark_jobs.sh`
	* Might have to wait for ~10 minutes or so [depending on your internet speed].
* Point your browser on the host machine to [`http://192.168.99.100:9999`](http://192.168.99.100:9999) for visualization.


> ###NOTE:
Please do not forget to modify the Twitter App OAuth credentials in the file [`application.conf`](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/blob/master/src/main/resources/application.conf#L7-10).
Please check [Twitter Developer page](https://dev.twitter.com/apps) for more info. 


## License
Copyright &copy; 2016 Prashanth Babu.

Licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
