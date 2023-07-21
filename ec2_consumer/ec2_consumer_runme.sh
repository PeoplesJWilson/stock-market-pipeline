#!/bin/bash

# enter your EC2 instance's private ip
export PRIVATE_IP_DNS="0.0.0.0"
export SERVER_PORT="${PRIVATE_IP_DNS}:9092"

# personalize these variables to your liking
export BUCKET_NAME="peoples-stock-streaming-data"
export TOPIC_NAME="stock_pipeline"
export SYMBOL="AAPL"
export N_SAMPLES=800 #number of allowed api calls per day on twelvedata free tier

python3 consumer.py