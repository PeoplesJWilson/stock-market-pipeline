#!/bin/bash

# PLEASE APPROPRIATELY CONFIGURE THESE VARIABLES

#________enter your twelvedata api key below_______
export TWELVE_DATA_API_KEY="YOURAPIKEY"

# since the kafka and zookeeper servers (as well as producer) will be running on this instance,
# keeping PUBLIC_IP="0.0.0.0" is okay
export PRIVATE_IP="0.0.0.0"
export SERVER_PORT="${PRIVATE_IP}:9092"

# enter appropriate values for kafka variables for downloading with wget
export KAFKA_RECENT="3.4.1"
export KAFKA_VERSION="kafka_2.12-3.4.1"

# personalize these variables to your liking
export BUCKET_NAME="peoples-stock-streaming-data"
export TOPIC_NAME="stock_pipeline"
export SYMBOL="AAPL"
export N_SAMPLES=800 #number of allowed api calls per day on twelvedata free tier

#________ SCRIPT________
# update download link and version appropriately over time
wget https://downloads.apache.org/kafka/${KAFKA_RECENT}/${KAFKA_VERSION}.tgz
tar -xvf ${KAFKA_VERSION}.tgz
rm -r "${KAFKA_VERSION}.tgz"

# make bucket 
aws s3 mb s3://${BUCKET_NAME}

# fix kafka server config to run on EC2's public IP
cd $KAFKA_VERSION
sed -i "38a advertized.listeners=PLAINTEXT://$SERVER_PORT" config/server.properties

# configure desired heap size
export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"

# start zookeeper in the background
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
sleep 5

# start the server in the background 
bin/kafka-server-start.sh -daemon config/server.properties
sleep 5

# create a topic 
bin/kafka-topics.sh --create --topic $TOPIC_NAME --bootstrap-server $SERVER_PORT --replication-factor 1 --partitions 1

# run the producer for N_SAMPLES many 10 second increments
cd ..
python3 producer.py
sleep 10

# shutdown zookeeper and kafka servers
killall -9 java


