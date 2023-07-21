#!/bin/bash

# PLEASE APPROPRIATELY CONFIGURE THESE VARIABLES

#________enter your twelvedata api key below_______
export TWELVE_DATA_KEY="YOURAPIKEY"

# since the kafka and zookeeper servers (as well as producer) will be running on this instance,
# keeping PUBLIC_IP="0.0.0.0" is okay
export PRIVATE_IP_DNS="0.0.0.0"
export SERVER_PORT="${PRIVATE_IP_DNS}:9092"


# personalize these variables to your liking
export BUCKET_NAME="peoples-stock-streaming-data"
export SYMBOL="AAPL"
export TOPIC_NAME="stock_pipeline" #This must match TOPIC_NAME used by server and consumer
export N_SAMPLES=800 #number of allowed api calls per day on twelvedata free tier

#________ SCRIPT________
# make bucket 
aws s3 mb s3://${BUCKET_NAME}

# run the producer for N_SAMPLES many 10 second increments
python3 producer.py


