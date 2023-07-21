#!/bin/bash

# PLEASE APPROPRIATELY CONFIGURE THESE VARIABLES
export TWELVE_DATA_KEY="YOURAPIKEY"
export BUCKET_NAME="peoples-stock-streaming-data"
export PRIVATE_IP_DNS="ip-0-0-0-0.region.compute.internal" # kafka server ip 

export SERVER_PORT="${PRIVATE_IP_DNS}:9092"

# personalize these variables to your liking
export SYMBOL="AAPL"
export TOPIC_NAME="stock_pipeline" #This must match TOPIC_NAME used by server and consumer
export N_SAMPLES=800 #number of allowed api calls per day on twelvedata free tier


#________ SCRIPT________
# make bucket 
aws s3 mb s3://${BUCKET_NAME}

# run the producer for N_SAMPLES many 10 second increments
python3 producer.py


