#! /bin/bash

cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/
sbt clean assembly


$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-slave.sh spark://spark:7077
echo -e "\n\n***** Started Spark services...... *****\n\n"

cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/target/scala-2.10/
spark-submit --class "org.p7h.spark.sentiment.mllib.SparkNaiveBayesModelCreator" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar


cd /root/Spark-MLlib-Twitter-Sentiment-Analysis/target/scala-2.10/
spark-submit --class "org.p7h.spark.sentiment.TweetSentimentAnalyzer" --master spark://spark:7077 mllib-tweet-sentiment-analysis-assembly-0.1.jar

