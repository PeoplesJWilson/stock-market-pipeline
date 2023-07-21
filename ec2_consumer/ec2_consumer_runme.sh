#!/bin/bash
# PLEASE APPROPRIATELY CONFIGURE THESE VARIABLES
export PRIVATE_IP_DNS="ip-0-0-0-0.region.compute.internal"
export BUCKET_NAME="peoples-stock-streaming-data"

export SERVER_PORT="${PRIVATE_IP_DNS}:9092"

# personalize these variables to your liking
export TOPIC_NAME="stock_pipeline" #this must match your topic name across other files
export SYMBOL="AAPL"

python3 consumer.py