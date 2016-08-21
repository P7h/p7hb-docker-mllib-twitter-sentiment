#! /bin/bash

CODE_FOLDER="/root/Spark-MLlib-Twitter-Sentiment-Analysis"
cd $CODE_FOLDER/


# Initiate SBT build of the project.
sbt error clean assembly


# Start Spark Services.
$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-slave.sh spark://spark:7077
echo -e "***** Started Spark services...... *****\n"


# Trigger Spark job for creating the Naive Bayes Model.
cd $CODE_FOLDER/target/scala-2.10/
echo -e "\n\n***** Starting Naive Bayes Model creation of training data...... *****\n\n"
spark-submit --class "org.p7h.spark.sentiment.mllib.SparkNaiveBayesModelCreator" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar
echo -e "\n\n***** Naive Bayes Model creation of training data is complete...... *****\n\n"


# Trigger Spark Streaming job for sentiment prediction.
echo -e "\n***** Starting Twitter Sentiment Analysis ...... *****\n"
echo -e "***** Please launch browser on the host machine to http://192.168.99.100:9999 to view Twitter Sentiment visualized on a world map ...... *****\n\n"
cd $CODE_FOLDER/target/scala-2.10/
spark-submit --class "org.p7h.spark.sentiment.TweetSentimentAnalyzer" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar

