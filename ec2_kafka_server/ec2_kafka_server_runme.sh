#!/bin/bash

# PLEASE APPROPRIATELY CONFIGURE THESE VARIABLES
export PRIVATE_IP_DNS="ip-0-0-0-0.region.compute.internal" # kafka server ip 
export SERVER_PORT="${PRIVATE_IP_DNS}:9092"


# personalize these variables to your liking
export TOPIC_NAME="stock_pipeline" #This must match TOPIC_NAME used by producer and consumer

# enter appropriate values for kafka variables for downloading with wget
export KAFKA_RECENT="3.4.1"
export KAFKA_VERSION="kafka_2.12-3.4.1"



#________ SCRIPT________
# update download link and version appropriately over time
wget https://downloads.apache.org/kafka/${KAFKA_RECENT}/${KAFKA_VERSION}.tgz
tar -xvf ${KAFKA_VERSION}.tgz
rm -r "${KAFKA_VERSION}.tgz"


# fix kafka server config to run on EC2's private IP
cd $KAFKA_VERSION
sed -i "38a advertized.listeners=PLAINTEXT://$SERVER_PORT" config/server.properties

export KAFKA_HEAP_OPTS="-Xmx1G -Xms1G"

# start zookeeper in the background
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties
sleep 5

# start the server in the background 
bin/kafka-server-start.sh -daemon config/server.properties
sleep 5

# create a topic 
bin/kafka-topics.sh --create --topic $TOPIC_NAME --bootstrap-server $SERVER_PORT --replication-factor 1 --partitions 1
