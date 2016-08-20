#!/bin/bash

echo -e "\n\n******* Bootstrapping the code download and setup...... *******\n"

if [ ! -d "/tmp/spark-events/" ]; then
    mkdir -p /tmp/spark-events/
fi

# Download, setup and configure Training data.
TRAINING_DATA_FOLDER="/root/tweets_sentiment/sentiment140/"
if [ ! -d $TRAINING_DATA_FOLDER ]; then
    echo -e "****** Initiated download of Sentiment140 Training data...... ******"
    mkdir -p $TRAINING_DATA_FOLDER
    TRAINING_DATA_ZIP_FILE="/root/trainingandtestdata.zip"
    # Sentiment140 website is a bit slow. So, instead retrieving the training data archive from another source.
    # wget -q http://cs.stanford.edu/people/alecmgo/$TRAINING_DATA_ZIP_FILE
    wget --no-check-certificate 'https://googledrive.com/host/0B7czam11htXVT3NLNEx3UDdaV1k' -qO $TRAINING_DATA_ZIP_FILE
    echo -e "   ****** Download complete...... ******\n"

    echo -e "***** Extracting Sentiment140 Training data...... *****"
    unzip -qq $TRAINING_DATA_ZIP_FILE -d $TRAINING_DATA_FOLDER
    rm -rf $TRAINING_DATA_ZIP_FILE
    echo -e "   ***** Extract complete...... *****\n"
else
    echo -e "***** Skipping Sentiment140 Training data download, as the folder structure already exists...... *****\n"
fi

# Restart Redis server.
service redis-server restart

# Download, setup and configure code.
CODE_FOLDER="/root/Spark-MLlib-Twitter-Sentiment-Analysis"
CODE_ZIP_FILE="/root/Spark-MLlib-Twitter-Sentiment-Analysis.zip"
if [ ! -d $CODE_FOLDER ]; then
    echo -e "\n**** Initiated download and extract of Spark-MLlib-Twitter-Sentiment-Analysis source code from GitHub.com/P7h...... ****"
    wget --no-check-certificate 'https://github.com/P7h/Spark-MLlib-Twitter-Sentiment-Analysis/archive/master.zip' -qO $CODE_ZIP_FILE
    unzip -qq $CODE_ZIP_FILE
    mv "$CODE_FOLDER-master" $CODE_FOLDER
    rm -rf $CODE_ZIP_FILE
    echo -e "   **** Download and extract complete...... ****\n"
else
    echo -e "\n***** Skipping code download, as the folder structure already exists...... *****\n"
fi

TOTAL_SCREENS=`screen -list | wc -l`
if [ $TOTAL_SCREENS -eq 2 ]; then
    screen -dmS viz bash -c "cd $CODE_FOLDER/src/main/webapp; python app.py; exec bash"
    echo -e "\n*** Started Visualization app in a screen session...... ***\n"
else 
    echo -e "\n*** Visualization screen session is already running...... ***\n"
fi

# Change file permissions of exec spark jobs.
EXEC_FILE="exec_spark_jobs.sh"
if [ ! -x $EXEC_FILE ]; then
    chmod +x $EXEC_FILE
fi

echo -e "\n* Please follow steps in the README / blogpost and update Twitter App OAuth Credentials in 'application.conf' and then launch $EXEC_FILE file to trigger Spark jobs...... *\n"
echo -e "* Also, please launch Google Chrome browser on the host machine and access http://192.168.99.100:9999/ for Visualization...... *\n\n"
