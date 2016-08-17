FROM p7hb/p7hb-docker-spark:1.6.2

MAINTAINER Prashanth Babu <Prashanth.Babu@gmail.com>

# Download and install all the required packages.
RUN apt-get -y update && \
    apt-get install -y software-properties-common && \
    apt-get install -y python-pip redis-server && \
    pip install redis flask && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# We will be running our Spark jobs as `root` user.
USER root

# Working directory is set to the home folder of `root` user.
WORKDIR /root

# SBT and the Spark processes need a decent memory; so setting the max and min memory to 1.5G.
ENV JAVA_OPTS "-server -Xms1536M -Xmx1536M"

# Expose port for Visualization.
EXPOSE 9999

# A bash script to download and setup the training data and the source code.
ADD bootstrap.sh /root/bootstrap.sh

CMD bash -C '/root/bootstrap.sh';'bash'
