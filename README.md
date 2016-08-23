# p7hb-docker-mllib-twitter-sentiment ![](https://img.shields.io/docker/automated/p7hb/p7hb-docker-mllib-twitter-sentiment.svg) [![HitCount](https://hitt.herokuapp.com/P7h/p7hb-docker-mllib-twitter-sentiment.svg)](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment) [![Docker Pulls](https://img.shields.io/docker/pulls/p7hb/p7hb-docker-mllib-twitter-sentiment.svg)](https://hub.docker.com/r/p7hb/p7hb-docker-mllib-twitter-sentiment/) [![Size](https://images.microbadger.com/badges/image/p7hb/p7hb-docker-mllib-twitter-sentiment.svg)](https://microbadger.com/images/p7hb/p7hb-docker-mllib-twitter-sentiment)

Dockerfiles for ***Twitter sentiment analysis with Spark MLlib and visualization*** referenced by [https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis "» GitHub Repo").

The image is available directly from [https://index.docker.io](https://hub.docker.com/u/p7hb/ "» Docker Hub").


## Introduction
Docker image to analyse and visualize sentiment of tweets in real-time on a world map using Apache Spark ecosystem (Spark MLlib + Spark Streaming + Spark SQL).

For more details on this project and the code associated with it, please check the [blogpost](http://P7h.org/blog/2016/08/21/spark-twitter-sentiment/).<br>
Also, README of [https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis "» GitHub Repo") has details on how to execute this project.


## Twitter sentiment visualization Demo
### Demo of visualization
![Demo of visualization](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/images/Twitter_Sentiment_Visualization.gif)

### Screenshots of visualization
#### Overview
![Overview](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/images/Viz_Overview.png)

#### Positive sentiment
![Positive sentiment](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/images/Viz_Positive.png)

#### Neutral sentiment
![Neutral sentiment](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/images/Viz_Neutral.png)

#### Negative sentiment
![Negative sentiment](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/raw/master/images/Viz_Negative.png)


## Get this Docker image
There are 2 ways of getting this image:

1. Build the image using Dockerfile
2. Pull the image from Docker Hub

### Build Docker image
Copy the [`Dockerfile`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/Dockerfile) and the other 2 supporting files: [`bootstrap.sh`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/bootstrap.sh) and [`exec_spark_jobs.sh`](https://github.com/P7h/p7hb-docker-mllib-twitter-sentiment/blob/master/exec_spark_jobs.sh) to a folder on your local machine and then invoke the following command.

    docker build -t p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2 .

This will build the docker image on your machine.

Please wait as this might take a bit of time depending on your internet speed.

### Pull the image from Docker Hub
With this approach, we are pulling the image hosted on Docker Hub instead of building it ourselves.

    docker pull p7hb/p7hb-docker-mllib-twitter-sentiment:1.6.2


## Executing the prototype
Please check the README of the [Spark-MLlib-Twitter-Sentiment-Analysis project](https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis "» GitHub Repo") for detailed instructions on executing this prototype.


## Contributing [![Contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](http://p7h.org/contact/)
If you find any issues or would like to discuss further, please ping me on my Twitter handle [@P7h](http://twitter.com/P7h "» Twitter/@P7h") or drop me an [email](http://p7h.org/contact/ "» Contact me"). Appreciate your help. Thanks!


## License [![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)
Copyright &copy; 2016 Prashanth Babu.<br>
Licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).