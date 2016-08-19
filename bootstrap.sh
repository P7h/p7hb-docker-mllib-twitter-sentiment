#! /bin/bash

echo -e "\n\n******* Bootstrapping the code download and setup...... *******\n"
mkdir -p /tmp/spark-events/

echo -e "****** Initiated download of Sentiment140 Training data...... ******"
mkdir -p /root/tweets_sentiment/sentiment140/
# wget -q http://cs.stanford.edu/people/alecmgo/trainingandtestdata.zip
wget --no-check-certificate 'https://googledrive.com/host/0B7czam11htXVT3NLNEx3UDdaV1k' -qO trainingandtestdata.zip
echo -e "	****** Download complete...... ******\n"

echo -e "***** Extracting Sentiment140 Training data...... *****"
unzip -qq trainingandtestdata.zip -d /root/tweets_sentiment/sentiment140/
rm -rf trainingandtestdata.zip
echo -e "	***** Extract complete...... *****\n"

service redis-server restart

echo -e "**** Initiated download of Spark-MLlib-Twitter-Sentiment-Analysis source code from GitHub.com/P7h...... ****"
wget --no-check-certificate 'https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/archive/master.zip' -qO Spark-MLlib-Twitter-Sentiment-Analysis.zip
unzip -qq Spark-MLlib-Twitter-Sentiment-Analysis.zip
mv Spark-MLlib-Twitter-Sentiment-Analysis-master Spark-MLlib-Twitter-Sentiment-Analysis
rm -rf Spark-MLlib-Twitter-Sentiment-Analysis.zip
echo -e "	**** Download complete...... ****\n"

screen -dmS viz bash -c 'cd Spark-MLlib-Twitter-Sentiment-Analysis/src/main/webapp; python app.py; exec bash'
echo -e "\n*** Started Visualization app in a screen session...... ***\n"
chmod +x exec_spark_jobs.sh

echo -e "\n\n* Please follow steps in the README / blogpost and update Twitter App OAuth Credentials in Spark-MLlib-Twitter-Sentiment-Analysis/src/main/resources/application.conf and then launch 'exec_spark_jobs.sh' file to trigger Spark jobs...... *\n"
echo -e "* Also, please launch Google Chrome browser on the host machine and access http://192.168.99.100:9999/ for Visualization...... *\n\n"
