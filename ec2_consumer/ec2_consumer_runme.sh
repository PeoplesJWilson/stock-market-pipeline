#!/bin/bash

# enter your EC2 instance's public ip
export PUBLIC_IP="0.0.0.0" \
export SERVER_PORT="${PUBLIC_IP}:9092" \

# personalize these variables to your liking
export BUCKET_NAME="peoples-stock-streaming-data" \
export TOPIC_NAME="stock_pipeline" \
export SYMBOL="AAPL"
export N_SAMPLES=800 #number of allowed api calls per day on twelvedata free tier