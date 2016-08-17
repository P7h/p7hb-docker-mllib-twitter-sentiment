#! /bin/bash

echo -e "\n\n******* Bootstrapping the env setup...... *******\n"
mkdir -p /tmp/spark-events/

echo -e "****** Initiated download of Sentiment140 Training data from Stanford website...... ******"
mkdir -p /root/tweets_sentiment/sentiment140/
wget -q http://cs.stanford.edu/people/alecmgo/trainingandtestdata.zip
echo -e "	****** Download complete...... ******\n"

echo -e "***** Extracting Sentiment140 Training data...... *****"
unzip -qq trainingandtestdata.zip -d /root/tweets_sentiment/sentiment140/
rm -rf trainingandtestdata.zip
echo -e "	***** Extract complete...... *****\n"

service redis-server restart




echo -e "\n*** Started Visualization app in a screen session...... ***"

$SPARK_HOME/sbin/start-master.sh
$SPARK_HOME/sbin/start-slave.sh spark://spark:7077
echo -e "** Started Spark services...... **\n"



echo -e "\n\n***** Please update Twitter OAuth Credentials in src/main/resources/application.conf and follow steps in the README / blogpost...... *****\n"
echo -e "*** Also, please launch Google Chrome browser on the host machine and access http://192.168.99.100:9999/ for Visualization...... ***\n\n"
